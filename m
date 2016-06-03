From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Fri, 3 Jun 2016 13:53:58 +0200
Message-ID: <83EF9DDB-34AB-4E91-A516-955DA1CC7AF9@grenoble-inp.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 03 13:54:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8ng2-00082A-Di
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbcFCLyE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 07:54:04 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:54722 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbcFCLyD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 07:54:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id AF89820DB;
	Fri,  3 Jun 2016 13:53:59 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WbAbFOF8WGHr; Fri,  3 Jun 2016 13:53:59 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9E53620D9;
	Fri,  3 Jun 2016 13:53:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 97B502077;
	Fri,  3 Jun 2016 13:53:59 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPl-ynpXb05F; Fri,  3 Jun 2016 13:53:59 +0200 (CEST)
Received: from eduroam-032251.grenet.fr (eduroam-032251.grenet.fr [130.190.32.251])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 533102066;
	Fri,  3 Jun 2016 13:53:59 +0200 (CEST)
In-Reply-To: <vpqy46my05v.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296305>

>> Like PUSH_REMOTE, the remote where we fetch can be called FETCH_REMO=
TE.=20
>> e.g. That=E2=80=99s clear to say "I fetch from fetch_remote".=20
>>=20
>> Do you agree?
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

PUBLISH sounds good. I take it for the next patch. 