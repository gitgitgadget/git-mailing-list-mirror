From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Mon, 6 Jun 2016 17:46:27 +0100
Organization: OPDS
Message-ID: <A8FD6EF510F149A4A05FE553BEDD8511@PhilipOakley>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org><1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org><9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley><D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org><vpqy46my05v.fsf@anie.imag.fr><F57B7CD2-8F8B-4D58-B145-285E69F9B4BE@grenoble-inp.org> <vpq7fe2rbno.fsf@anie.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
	"Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>,
	"Samuel Groot" <samuel.groot@grenoble-inp.org>,
	"Tom Russello" <tom.russello@grenoble-inp.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:46:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xff-0003id-4B
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbcFFQqb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 12:46:31 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:32142 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbcFFQqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:46:30 -0400
Received: from PhilipOakley ([92.22.6.31])
	by smtp.talktalk.net with SMTP
	id 9xfXbu4wHsdET9xfXb75li; Mon, 06 Jun 2016 17:46:28 +0100
X-Originating-IP: [92.22.6.31]
X-Spam: 0
X-OAuthority: v=2.2 cv=B/D766lM c=1 sm=1 tr=0 a=6rKLwjNE5rx67PMj20oCSw==:117
 a=6rKLwjNE5rx67PMj20oCSw==:17 a=IkcTkHD0fZMA:10 a=aSBN74SrAAAA:8
 a=xtxXYLxNAAAA:8 a=oSUHMdLMAAAA:8 a=VwQbUJbxAAAA:8 a=nZxIDeVLNa_uJn8TY28A:9
 a=x8gzFH9gYPwA:10 a=QLKLDn6n7aLR3e0nYJH2:22 a=xts0dhWdiJbonKbuqhAr:22
 a=mbJZPIM0HApMLseGL71l:22 a=AjGcO6oz07-iQ99wixmX:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfN3yM+M214ChDykpZaL3itRhQw8442zi9fvw0xH0xfBcXXpzPbV6fzcVKw+DVKFPj8Tf8fAiZj1DrgAhPpji2sUj8Y4dgGJ9WeQKX5nycUFHLCOJbQ2L
 BYWFqkCkOyyQPCTx4v4QuAqa7pv5VMojwNAyA58w+Pce3ysoR4hLBvIskamwLFBoJVrYhZonubhhUPwRAgjyhAiqG1n5FMTCV1zJgW3/+jInNXTcxPVPeEbF
 vuznbE0Gjm3Wd0fGJSbsjtG+G1KetzpSooGfTI9gXfDz+n9r310oLNHySWKzLu/ODmnUjBw6Qv2cV1fWpfuIWLckY4QqBWfbMBcSCV0HjefxwbELi3T54AS1
 SPVF7jsc1UqmgPWxxEUv6FuIxz9HG06uglOfozuk560I1Q91TbS0jMg9IXzqtYe3ce+1iRHd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296536>

=46rom: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
> Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:
>
>>> Matthieu Moy <matthieu.moy@grenoble-inp.fr> a =C3=A9crit :
>>>
>>> That is technically correct, but to illustrate the overall flow, I'=
d
>>> rather avoid naming the repositories in terms of git commands. If y=
ou do
>>> so, you will probably end up with tautological explanations like th=
is
>>> later in the text: "FETCH_REMOTE is the remote from where you fetch=
,
>>> PUSH_REMOTE is the remote to which you push, and LOCAL is local".
>>>
>>> I suggested PUBLIC-FORK earlier, and didn't get any feedback on it.=
 I
>>> think it translates the intent better than PUSH_REMOTE. An alternat=
ive
>>> would be PUBLISH (=3D the repository you use to publish your change=
s so
>>> that the maintainer can pick them).
>>
>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>> However your gitster/git repo feels like it would match the me/git
>>> viewpoint, in that while it is 'open', it isn't really a formal
>>> publishing place. Certainly I don't think that I 'publish' what's i=
n
>>> my personal github repos, which I use as an open backup (and any
>>> PR's I put to the G4W project repo are referenced from there).
>>
>>
>> For Philip Oakley, PUBLISH seems to not be a good name.
>> For PUBLIC-FORK, a fork can be private so I think that=E2=80=99s not=
 a good idea.
>
> I don't think you will find a name that fits all use-cases. IHMO, bes=
t
> is to pick one rather general use-case, make the explanations for it,
> and maybe explain somewhere that there are variants.
>
> If the fork is completely private, then your diagram with a "maintain=
er"
> arrow from it to upstream is not valid.

That's only true for a Pull Request workflow. For a Patch workflow (suc=
h as=20
Git) the user's home vault can be completely private.

>  It needs at least to be visible
> to the maintainer. "public" may be a bit strong as you don't need to
> make it "public" to everyone on earth, but to me that's OK to describ=
e
> the use-case.
>
>> As the third-place is the repository used to work on commits/patches=
,
>> a simple name can be WORK_REPOSITORY.
>
> "WORK" is already used to describe "worktree" which is precisely not
> this repository. I don't "work" on my public fork, I "work" locally a=
nd
> then just send commits there.
>
> --=20
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
