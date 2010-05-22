From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH RFC] Add a config verbose option fetch and push
Date: Sat, 22 May 2010 15:34:18 +0200
Message-ID: <201005221534.18529.trast@student.ethz.ch>
References: <4bf6b6f5.dd79dc0a.5533.2acd@mx.google.com> <201005221244.32213.trast@student.ethz.ch> <AANLkTimQzAM7qA32FRFvQC1cx7UEEKtBxjU89whrSqF5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>,
	<git@vger.kernel.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 15:34:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFoqm-0007bj-Hu
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 15:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab0EVNen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 May 2010 09:34:43 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:12487 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695Ab0EVNem convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 May 2010 09:34:42 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 22 May
 2010 15:34:40 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 22 May
 2010 15:34:18 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <AANLkTimQzAM7qA32FRFvQC1cx7UEEKtBxjU89whrSqF5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147524>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Sat, May 22, 2010 at 10:44, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> > =C6var Arnfj=F6r=F0 Bjarmason wrote:
> > That would completely ruin the scriptability of almost all commands=
=2E
> > Imagine the user added the following options as default:
> >  add --edit
[...]
> > I'm sure you can find one option that changes the command in someth=
ing
> > completely different *for every command*.
>=20
> Sure. But so would adding this as git-add to your $PATH:
>=20
>     #!/bin/sh
>     /usr/lib/git-core/git-add --edit $@

Two points:

* This way is not documented in git-config(1), as the proposed
  interface would have to be; hence, it is not "official".

* More importantly, it doesn't work; for builtins such as git-add, not
  even if you put it under the `git --exec-path` (yes, I've tested
  this).

> Git already has plenty of ways to shoot yourself in the foot.

Can't argue with that.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
