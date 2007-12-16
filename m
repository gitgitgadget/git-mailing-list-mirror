From: Abdelrazak Younes <younes.a@free.fr>
Subject: Re: Windows binaries for qgit 2.0
Date: Sun, 16 Dec 2007 08:26:03 +0100
Message-ID: <fk2juf$t25$1@ger.gmane.org>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 08:26:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3ntj-0006bz-Hx
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 08:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbXLPH00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 02:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbXLPH00
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 02:26:26 -0500
Received: from main.gmane.org ([80.91.229.2]:37435 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521AbXLPH0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 02:26:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J3ntA-0004D5-Ba
	for git@vger.kernel.org; Sun, 16 Dec 2007 07:26:16 +0000
Received: from gre92-5-82-237-199-162.fbx.proxad.net ([82.237.199.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 07:26:16 +0000
Received: from younes.a by gre92-5-82-237-199-162.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 07:26:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gre92-5-82-237-199-162.fbx.proxad.net
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68443>

Marco Costalba wrote:
> Due to a feature request on sourceforge qgit account:
> 
> http://sourceforge.net/tracker/index.php?func=detail&aid=1759403&group_id=139897&atid=744830
> 
> I have cooked and uploaded a qgit.exe file with Qt4.3.3 statically
> linked in so to let Windows users that just want to give a shot to
> qgit the possibility to try it easily.

Sorry for the intrusion in this list but you don't need to compile Qt 
statically IMO. Just bundle the Qt dlls that you needs (most probably 
QtCore and QtGui) with you executable and be done with it.

> Normally I use debug shared Qt libraries for development, so after
> some effort I finally managed to build the static ones and finally to
> build qgit.exe
> 
> Problem is that _this_ qgit.exe shows strange misbehaviour like 20X
> slower then the one I normally build for development,  there is also
> some strange artifacts with file history graph.

If you are using debug dlls, those are known to be slower  because of 
the additional checking (like vector bundaries, etc). Beware also of 
stdlib-debug if you're using gcc. In any case, if you want to gain 
speed, you should compile with MSVC (MSVC2005Express is free as in beer).

Hope this helps,
Abdel.
