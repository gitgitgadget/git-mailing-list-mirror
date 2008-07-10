From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git over rsync+ssh
Date: Thu, 10 Jul 2008 12:06:55 +0200
Message-ID: <g54mvv$kek$1@ger.gmane.org>
References: <g52gbg$si9$1@ger.gmane.org> <e2b179460807090802j2dbb72efo4f03c0a9e79241c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 12:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGt4L-0003e1-Bf
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 12:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbYGJKHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 06:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbYGJKHL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 06:07:11 -0400
Received: from main.gmane.org ([80.91.229.2]:51549 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbYGJKHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 06:07:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGt3J-0005gL-47
	for git@vger.kernel.org; Thu, 10 Jul 2008 10:07:05 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 10:07:05 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 10:07:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <e2b179460807090802j2dbb72efo4f03c0a9e79241c0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87965>

Mike Ralphson venit, vidit, dixit 09.07.2008 17:02:
> 2008/7/9 Michael J Gruber <michaeljgruber+gmane@fastmail.fm>:
>> I want to put a git repo on a server where I have ssh access but failed to
>> compile git (AIX 5.1, has libz.a but no .so nor headers; compiling
>> prerequisite zlib failed, probably due to a botched build environment).
> 
> I can send you a binary to try if you'd like. It would be compiled on
> AIX 5.3 but I have to jump through hoops on several non-identically
> set-up servers here, so one might work for you.

Thanks for the offer. I found an AIX 4.3 box with a working build 
environment there, including zlib-devel, and I got git 1.5.6.2 compiled 
now (no tcltk, don't care). Runs fine on the AIX 5.1 box, I can clone 
and push happily. Yeah.

Michael
