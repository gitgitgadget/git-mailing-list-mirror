From: Abdelrazak Younes <younes.a@free.fr>
Subject: Re: Windows binaries for qgit 2.0
Date: Sun, 16 Dec 2007 09:52:27 +0100
Message-ID: <fk2p0f$961$1@ger.gmane.org>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>	 <fk2juf$t25$1@ger.gmane.org> <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 09:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3pFR-0002zy-9F
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 09:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbXLPIwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 03:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbXLPIwz
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 03:52:55 -0500
Received: from main.gmane.org ([80.91.229.2]:49081 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042AbXLPIwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 03:52:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J3pEn-0003EL-Cd
	for git@vger.kernel.org; Sun, 16 Dec 2007 08:52:41 +0000
Received: from gre92-5-82-237-199-162.fbx.proxad.net ([82.237.199.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 08:52:41 +0000
Received: from younes.a by gre92-5-82-237-199-162.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 08:52:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gre92-5-82-237-199-162.fbx.proxad.net
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68446>

Marco Costalba wrote:
> On Dec 16, 2007 8:26 AM, Abdelrazak Younes <younes.a@free.fr> wrote:
>> Sorry for the intrusion in this list but you don't need to compile Qt
>> statically IMO. Just bundle the Qt dlls that you needs (most probably
>> QtCore and QtGui) with you executable and be done with it.
>>
> 
> Yes. That's another option, I will try that to see if things get better.
> 
>> If you are using debug dlls, those are known to be slower  because of
> 
> Actually I use debug dll for normal development and never experienced slowness.
> I switched to "release" library to create the qgit package and _now_ I
> have the thing much slower and also misbehaving. So for me are the
> release library that have problems, not the debug ones.

Hum, I can't imagine this is the reason, it might be for another reason, 
most certainly the static compiling.

> 
>> In any case, if you want to gain
>> speed, you should compile with MSVC (MSVC2005Express is free as in beer).
>>
> 
> Yes, I was thinking about this, but Qt don't officially supports MSVC
> for the Qt4 GPL libraries,

Well, for the LyX project we used to use and distribute the patched 
version of Qt in order to compile it with MSVC. Now, since Qt4.3.2 the 
MSVC compilation support is enabled in the official release so you don't 
even have to patch it anymore. I can send you precompiled dll if you 
want. Or you can use the one bundled in the last lyx installer 
(www.lyx.org).

> so that's the reason I was stick to mingw
> (although now it comes more and more clear to me that the shipped
> version has problems with release compiled libraries)

The first reason why we went away from mingw was because it was way too 
slow to compile Qt and LyX. With MSVC the binaries are much faster.

Abdel.
