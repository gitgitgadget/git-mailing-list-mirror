From: LarryMartell <larry.martell@gmail.com>
Subject: Re: git calls SSH_ASKPASS even if DISPLAY is not set
Date: Mon, 7 May 2012 14:42:43 -0700 (PDT)
Message-ID: <1336426963148-7537044.post@n2.nabble.com>
References: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 23:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVhg-0003jx-HH
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab2EGVmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 17:42:44 -0400
Received: from sam.nabble.com ([216.139.236.26]:53876 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197Ab2EGVmn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 17:42:43 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <larry.martell@gmail.com>)
	id 1SRVhb-0003le-5c
	for git@vger.kernel.org; Mon, 07 May 2012 14:42:43 -0700
In-Reply-To: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197316>


Xin Wang wrote
>=20
> Hi all,
>=20
> I'm using git 1.7.3.2 in Fedora 14. In Fedora, SSH_ASKPASS will set t=
o
> be /usr/libexec/openssh/gnome-ssh-askpass in
> /etc/profile.d/gnome-ssh-askpass.sh, so this environment is set by
> login shell, and it will still be set even when X11 is not inuse.
>=20
> According to ssh's manpage: "If ssh does not have a terminal
> associated with it but DISPLAY and SSH_ASKPASS are set, it will
> execute the program specified by SSH_ASKPASS and open an X11 window t=
o
> read the passphrase." But git will call SSH_ASKPASS even if there is =
a
> terminal associated with it and DISPLAY is not set, then following
> warning is displayed and git failed to go through.
>=20
> $ git fetch
>=20
> (gnome-ssh-askpass:1487): Gtk-WARNING **: cannot open display:
>=20
> I think it=E2=80=98s better if git could implement behavior conformin=
g to ssh.
>=20
>=20


We are getting this error on a new CentOS system we just set up. Was th=
ere
ever a fix or workaround for this?

-larry


--
View this message in context: http://git.661346.n2.nabble.com/git-calls=
-SSH-ASKPASS-even-if-DISPLAY-is-not-set-tp5825303p7537044.html
Sent from the git mailing list archive at Nabble.com.
