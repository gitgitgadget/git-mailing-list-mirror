From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use action dispatcher for non-project actions, too.
Date: Fri, 18 Aug 2006 16:22:01 +0200
Organization: At home
Message-ID: <ec4ie9$sht$1@sea.gmane.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <1155767325181-git-send-email-tali@admingilde.org> <11557673263081-git-send-email-tali@admingilde.org> <11557673262714-git-send-email-tali@admingilde.org> <11557673281583-git-send-email-tali@admingilde.org> <7vk65815h1.fsf@assigned-by-dhcp.cox.net> <87y7tnxv9g.wl%cworth@cworth.org> <20060818131656.GR13776@pasky.or.cz> <87k656rvim.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Aug 18 16:23:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE5FV-0003pW-0o
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 16:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWHROW6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Aug 2006 10:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWHROW6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 10:22:58 -0400
Received: from main.gmane.org ([80.91.229.2]:17350 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030418AbWHROW5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 10:22:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE5FB-0003jU-UA
	for git@vger.kernel.org; Fri, 18 Aug 2006 16:22:42 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 16:22:41 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 16:22:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25667>

Carl Worth wrote:

> * A mechanism for not requiring me to invent tracking-branch names. =A0=
I
> =A0 end up manually doing a scheme with short prefixes for any given
> =A0 repository. It would be nice if I could configure that (in
> =A0 .git/remotes/<something> say) once so that any new branch I pulle=
d
> =A0 would get its properly named tracking branch. And git could find =
the
> =A0 right remotes file by matching up the URL.

This mechanism is called 'git clone --use-separate-remote'.

  --use-separate-remote
     Save remotes  heads under $GIT_DIR/remotes/origin/ instead  of
     $GIT_DIR/refs/heads/. Only the master branch is saved in the latte=
r.
     (as origin).

(Shouldn't it be $GIT_DIT/refs/remotes/<repository>/ instead, BTW?)
And of course you can configure pull lines in the following way:

  Pull: refs/heads/<branch>:refs/remotes/<repository>/<branch>

Unfortunately, there is no way to automatically pull new refs and tags
in such a way.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
