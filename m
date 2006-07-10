From: Paul Serice <paul@serice.net>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Mon, 10 Jul 2006 14:14:17 -0500
Message-ID: <44B2A709.8020500@serice.net>
References: <20060710065751.22902.43316.stgit@dv.roinet.com> <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net> <20060710094653.GA52962@dspnet.fr.eu.org> <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060710114117.GA62514@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 21:14:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G01Cm-00059p-9N
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 21:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422786AbWGJTOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 15:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422787AbWGJTOA
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 15:14:00 -0400
Received: from serice.org ([206.123.107.184]:3600 "EHLO serice.org")
	by vger.kernel.org with ESMTP id S1422786AbWGJTN7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 15:13:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by serice.org (Postfix) with ESMTP id E35B1580F8;
	Mon, 10 Jul 2006 14:13:58 -0500 (CDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
To: Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20060710114117.GA62514@dspnet.fr.eu.org>
X-Enigmail-Version: 0.92.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23640>

> Given than you can find gcc on pretty much everything that has a
> filesystem cache decent enough to handle git correctly, is this cost
> worth it?  _That_ was the question.

I've seen this argument before.  Unfortunately it seems reasonable
enough on the surface, and I actually bought into it much to may later
regret.

My experience is that gcc often produces buggy code, and if gcc is not
_the_ compiler for that platform, those bugs do not get fixed.
Specifically, I have had lots of problems with gcc and IRIX.

If you want to write portable code, you have to take into account
different operating systems _and_ different compilers.  Writing your
code for just a single compiler is almost as bad as writing your code
for just a single operating system.

Paul Serice
