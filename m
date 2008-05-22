From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git GUI vs interactive post-commit hooks
Date: Thu, 22 May 2008 14:53:01 +0200
Message-ID: <20080522125301.GD3206@steel.home>
References: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com> <20080519131942.GA5526@atjola.homenet> <20080520223158.GB13123@steel.home> <20080520230204.GA5383@atjola.homenet>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Gladysh <agladysh@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 22 14:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzAIx-0006ti-29
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 14:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762356AbYEVMxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 May 2008 08:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761700AbYEVMxG
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 08:53:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:60979 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762356AbYEVMxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 08:53:05 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMna1s/dNSK
Received: from tigra.home (Fa855.f.strato-dslnet.de [195.4.168.85])
	by post.webmailer.de (fruni mo62) (RZmta 16.38)
	with ESMTP id v01daek4MC9Bf3 ; Thu, 22 May 2008 14:53:01 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A8C5A277BD;
	Thu, 22 May 2008 14:53:01 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id ECD7456D28; Thu, 22 May 2008 14:53:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080520230204.GA5383@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82624>

Bj=C3=B6rn Steinbrink, Wed, May 21, 2008 01:02:04 +0200:
> On 2008.05.21 00:31:58 +0200, Alex Riesen wrote:
> > Bj?rn Steinbrink, Mon, May 19, 2008 15:19:42 +0200:
> > > On 2008.05.19 14:48:14 +0400, Alexander Gladysh wrote:
> > > >=20
> > > > Any advice? I do want to input password for my key each time I =
use it.
> > >=20
> > > For a graphical tool, you might want to use something like
> > > gtk-led-askpass, which shows a window with a password prompt. SSH=
 will
> > > make use of it if SSH_ASKPASS contains its path _and_ ssh is not =
started
> > > from a terminal. Unfortunately, the latter is probably not true f=
or git
> > > gui most of the time.
> >=20
> > Redirect stdin from /dev/null
>=20
> Does that actually work for you? It didn't work for me, because ssh t=
hen
> simply goes and opens /dev/tty to ask for the password.
>=20
> $ ssh -V
> OpenSSH_4.7p1 Debian-10, OpenSSL 0.9.8g 19 Oct 2007
>=20

No :( I took this information from sshs manpage:

     SSH_ASKPASS           If ssh needs a passphrase, it will read the
                           passphrase from the current terminal if it w=
as run
                           from a terminal.  If ssh does not have a ter=
minal
                           associated with it but DISPLAY and SSH_ASKPA=
SS are
                           set, it will execute the program specified b=
y
                           SSH_ASKPASS and open an X11 window to read t=
he
                           passphrase.  This is particularly useful whe=
n call=E2=80=90
                           ing ssh from a .xsession or related script. =
 (Note
                           that on some machines it may be necessary to=
 redi=E2=80=90
                           rect the input from /dev/null to make this w=
ork.)
