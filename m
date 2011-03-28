From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git @ be919d50 broken on OSX build
Date: Mon, 28 Mar 2011 09:34:40 -0700
Message-ID: <86hbani4pr.fsf@red.stonehenge.com>
References: <86lizzi4zv.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 18:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4FPR-0007aj-QH
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 18:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136Ab1C1Qen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 12:34:43 -0400
Received: from lax-gw09.mailroute.net ([199.89.0.109]:39374 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932080Ab1C1Qel (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 12:34:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw09.mroute.net (Postfix) with ESMTP id 64E68138560
	for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:34:41 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw09.mroute.net (Postfix) with ESMTP id AB39613855B
	for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:34:40 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 9F66A18EF; Mon, 28 Mar 2011 09:34:40 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.4.6; tzolkin = 7 Cimi; haab = 19 Cumku
In-Reply-To: <86lizzi4zv.fsf@red.stonehenge.com> (Randal L. Schwartz's message
	of "Mon, 28 Mar 2011 09:28:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170154>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> ...
Randal>     GEN git-add--interactive
Randal> Writing perl.mak for Git
Randal> make[2]: *** [perl.mak] Error 1
Randal> make[1]: *** [instlibdir] Error 2
Randal> make: *** [git-add--interactive] Error 2

And in bisecting, I got broken at fbc9629e2f0cd31 with:

Locohost.local:~/MIRROR/git-GIT % make prefix=/opt/git all install
quick-install-man
GITGUI_VERSION = 0.14.0
    * new locations or Tcl/Tk interpreter
    GEN git-gui
rm: git-gui: is a directory
make: *** [git-gui] Error 1

and after a few "git bisect skip", I'm still stuck.

Am I bisecting wrong?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
