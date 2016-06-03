From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Fri, 03 Jun 2016 13:36:12 +0200
Message-ID: <vpqy46my05v.fsf@anie.imag.fr>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
	<1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley>
	<D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 13:36:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8nOz-0002H1-1T
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcFCLg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 07:36:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42654 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbcFCLg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 07:36:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u53BaCUs005611
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 3 Jun 2016 13:36:12 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u53BaCbK009117;
	Fri, 3 Jun 2016 13:36:12 +0200
In-Reply-To: <D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org> (Jordan
	DE's message of "Fri, 3 Jun 2016 11:52:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 03 Jun 2016 13:36:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u53BaCUs005611
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465558577.08411@av7nsifkbwU6CDm4DZU16A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296303>

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

> You=E2=80=99re right, finding a good name is not easy.=20
> Firstly, I wanted to use DOWNSTREAM and UPSTREAM. But git doesn=E2=80=
=99t make the difference between those words. =20

In english, "downstream" and "upstream" are relative terms. If A is
upstream compared to B, then B is downstream compared to A.

In terms of Git, you know what your upstream is (i.e. where you get
commits from), but you don't necessarily know what your downstream is
(i.e. who pulls from your repository). So, "downstream" wouldn't make
sense in a config file.

> Like PUSH_REMOTE, the remote where we fetch can be called FETCH_REMOT=
E.=20
> e.g. That=E2=80=99s clear to say "I fetch from fetch_remote".=20
>
> Do you agree?

That is technically correct, but to illustrate the overall flow, I'd
rather avoid naming the repositories in terms of git commands. If you d=
o
so, you will probably end up with tautological explanations like this
later in the text: "FETCH_REMOTE is the remote from where you fetch,
PUSH_REMOTE is the remote to which you push, and LOCAL is local".

I suggested PUBLIC-FORK earlier, and didn't get any feedback on it. I
think it translates the intent better than PUSH_REMOTE. An alternative
would be PUBLISH (=3D the repository you use to publish your changes so
that the maintainer can pick them).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
