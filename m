From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Sun, 5 Jun 2016 23:28:34 +0200
Message-ID: <F57B7CD2-8F8B-4D58-B145-285E69F9B4BE@grenoble-inp.org>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org> <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org> <9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley> <D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org> <vpqy46my05v.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 05 23:28:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9fbB-0006XV-Hw
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 23:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbcFEV2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2016 17:28:41 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:33960 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbcFEV2l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 17:28:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 900772558;
	Sun,  5 Jun 2016 23:28:36 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 44XNC24iSLYq; Sun,  5 Jun 2016 23:28:36 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5879E254C;
	Sun,  5 Jun 2016 23:28:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 4DEF02066;
	Sun,  5 Jun 2016 23:28:35 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WGeLDKzEexyE; Sun,  5 Jun 2016 23:28:35 +0200 (CEST)
Received: from macbook-pro-de-jordan.home (LFbn-1-8005-19.w90-112.abo.wanadoo.fr [90.112.16.19])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id DDF402055;
	Sun,  5 Jun 2016 23:28:34 +0200 (CEST)
In-Reply-To: <vpqy46my05v.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296482>


> Matthieu Moy <matthieu.moy@grenoble-inp.fr> a =C3=A9crit :
>=20
> That is technically correct, but to illustrate the overall flow, I'd
> rather avoid naming the repositories in terms of git commands. If you=
 do
> so, you will probably end up with tautological explanations like this
> later in the text: "FETCH_REMOTE is the remote from where you fetch,
> PUSH_REMOTE is the remote to which you push, and LOCAL is local".
>=20
> I suggested PUBLIC-FORK earlier, and didn't get any feedback on it. I
> think it translates the intent better than PUSH_REMOTE. An alternativ=
e
> would be PUBLISH (=3D the repository you use to publish your changes =
so
> that the maintainer can pick them).

> "Philip Oakley" <philipoakley@iee.org> writes:
> However your gitster/git repo feels like it would match the me/git vi=
ewpoint, in that while it  is 'open', it isn't really a formal publishi=
ng place. Certainly I don't think that I 'publish' what's in my persona=
l github repos, which I use as an open backup (and any PR's I put to th=
e G4W project repo are referenced from there).


=46or Philip Oakley, PUBLISH seems to not be a good name.=20
=46or PUBLIC-FORK, a fork can be private so I think that=E2=80=99s not =
a good idea.=20

As the third-place is the repository used to work on commits/patches,=20
a simple name can be WORK_REPOSITORY. 