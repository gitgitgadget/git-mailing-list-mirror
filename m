From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 13:31:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601091320420.2503@wbgn013.biozentrum.uni-wuerzburg.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136FE@hdsmsx401.amr.corp.intel.com>
 <46a038f90601090211j33479764q13c74df60033a061@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 13:32:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvwBs-0003r8-Mw
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 13:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWAIMb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 07:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWAIMb5
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 07:31:57 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:60311 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751244AbWAIMb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 07:31:56 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0343DE6006; Mon,  9 Jan 2006 13:31:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id E5AF19A3;
	Mon,  9 Jan 2006 13:31:52 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id C8A9694E;
	Mon,  9 Jan 2006 13:31:52 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3710413FAF6; Mon,  9 Jan 2006 13:31:52 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601090211j33479764q13c74df60033a061@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14373>

Hi,

On Mon, 9 Jan 2006, Martin Langhoff wrote:

> In a sense we are still exploring possible/desirable workflows and what 
> the missing pieces are. And yes, some thing don't quite make sense from 
> the outside, perhaps because they just don't or because we arent' 
> explaining them very well.

Maybe what is needed here is this:

T1 - T2 .. Tn .. Tp
  \         \      \
   \         M1     M2
    \       /      /
     B1 .. Bm .. Bo

where T1..Tp are the upstream commits, B1..Bo are the local commits, and
M1.. are the test merges just to make sure nothing breaks?

As long as the Mx commits resolve automatically, no need for an explicit 
merge in the Bx commits, since a pull from B into T will just recreate an 
Mx as next commit in T.

Kind of "throw away merge".

Ciao,
Dscho
