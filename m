From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problem with the dump HTTP transport
Date: Wed, 21 Dec 2005 19:43:05 +0100
Message-ID: <1135190585.14627.9.camel@localhost>
References: <1135166574.26233.64.camel@localhost>
	 <7vu0d2baaq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 19:47:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep8vr-0001g4-2S
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 19:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVLUSnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 13:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVLUSnU
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 13:43:20 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:16828 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751162AbVLUSnT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 13:43:19 -0500
Received: from blade (p5487C558.dip.t-dialin.net [84.135.197.88])
	by mail.holtmann.net (8.13.4/8.13.4/Debian-3) with ESMTP id jBLIhSdZ018429
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Wed, 21 Dec 2005 19:43:29 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0d2baaq.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.5.3 
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_96_XX 
	autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on coyote.holtmann.net
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13891>

Hi Junio,

> > Cannot obtain needed object c2f3bf071ee90b01f2d629921bb04c4f798f02fa
> > while processing commit 0000000000000000000000000000000000000000.
> > cg-fetch: objects fetch failed
> >
> > Both, git and cogito, are the latest versions from yesterday. So it
> > seems every time you repack, you need to do something extra to keep the
> > dump HTTP transport happy.
> 
> The last sentence is correct and I do that (the magic word is
> git-update-server-info, and that is done as part of git-repack
> automatically), but it does not seem to apply here.  It most
> likely is a mirroring delay.  That c2f3... object is the commit
> at the tip of the master branch, and the repository is fully
> packed right now (except v1.0.0 tag object which is loose).

it is still not working. How long does it take on www.kernel.org to
mirror it from the master.

Regards

Marcel
