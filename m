From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] perl bindings fix compilation errors
Date: Mon, 25 Sep 2006 12:34:20 +0100
Message-ID: <4517BEBC.4000002@shadowen.org>
References: <20060925100319.GA1655@shadowen.org> <Pine.LNX.4.63.0609251223590.25371@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 13:34:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRojW-0008MW-QR
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 13:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWIYLeo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 07:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWIYLeo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 07:34:44 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:15119 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751368AbWIYLen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 07:34:43 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GRoiz-00032n-Gw; Mon, 25 Sep 2006 12:34:13 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609251223590.25371@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27734>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 25 Sep 2006, Andy Whitcroft wrote:
> 
>> With the introduction of Makefile.PL to the perl bindings we no
>> longer seem to pass in either the definition of SHA1_HEADER or
>> GIT_VERSION.  It seems we no longer pass over the BASIC_FLAGS into
>> the compilation.
> 
> You probably got bitten by the fact that earlier runs left Git.c in the 
> perl/ directory. Go to perl/, "make distclean", and make git again.

Hmmm that sucks.  Yes, I had to make distclean more than once, but it
seems to fix things.

I am somewhat unhappy that a make clean at the top level and remake was
not sufficient to get a working tree.

-apw
