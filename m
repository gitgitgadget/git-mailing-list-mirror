From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Mon, 06 Jun 2016 09:58:51 +0200
Message-ID: <vpq7fe2rbno.fsf@anie.imag.fr>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
	<1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley>
	<D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org>
	<vpqy46my05v.fsf@anie.imag.fr>
	<F57B7CD2-8F8B-4D58-B145-285E69F9B4BE@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 09:59:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9pRR-000807-LU
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 09:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbcFFH7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 03:59:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35648 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbcFFH7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 03:59:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u567woJS011836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 09:58:51 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u567wp5d022855;
	Mon, 6 Jun 2016 09:58:51 +0200
In-Reply-To: <F57B7CD2-8F8B-4D58-B145-285E69F9B4BE@grenoble-inp.org> (Jordan
	DE's message of "Sun, 5 Jun 2016 23:28:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 06 Jun 2016 09:58:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u567woJS011836
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465804732.60626@qZDBjP7Wc7Tw2JAc1Mf95A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296487>

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

>> Matthieu Moy <matthieu.moy@grenoble-inp.fr> a =C3=A9crit :
>>=20
>> That is technically correct, but to illustrate the overall flow, I'd
>> rather avoid naming the repositories in terms of git commands. If yo=
u do
>> so, you will probably end up with tautological explanations like thi=
s
>> later in the text: "FETCH_REMOTE is the remote from where you fetch,
>> PUSH_REMOTE is the remote to which you push, and LOCAL is local".
>>=20
>> I suggested PUBLIC-FORK earlier, and didn't get any feedback on it. =
I
>> think it translates the intent better than PUSH_REMOTE. An alternati=
ve
>> would be PUBLISH (=3D the repository you use to publish your changes=
 so
>> that the maintainer can pick them).
>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>> However your gitster/git repo feels like it would match the me/git
>> viewpoint, in that while it is 'open', it isn't really a formal
>> publishing place. Certainly I don't think that I 'publish' what's in
>> my personal github repos, which I use as an open backup (and any
>> PR's I put to the G4W project repo are referenced from there).
>
>
> For Philip Oakley, PUBLISH seems to not be a good name.=20
> For PUBLIC-FORK, a fork can be private so I think that=E2=80=99s not =
a good idea.=20

I don't think you will find a name that fits all use-cases. IHMO, best
is to pick one rather general use-case, make the explanations for it,
and maybe explain somewhere that there are variants.

If the fork is completely private, then your diagram with a "maintainer=
"
arrow from it to upstream is not valid. It needs at least to be visible
to the maintainer. "public" may be a bit strong as you don't need to
make it "public" to everyone on earth, but to me that's OK to describe
the use-case.

> As the third-place is the repository used to work on commits/patches,=
=20
> a simple name can be WORK_REPOSITORY.

"WORK" is already used to describe "worktree" which is precisely not
this repository. I don't "work" on my public fork, I "work" locally and
then just send commits there.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
