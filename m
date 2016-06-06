From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Mon, 6 Jun 2016 20:21:57 +0100
Organization: OPDS
Message-ID: <0B6B083EAEAA4E428C26CDAFE56E2FF6@PhilipOakley>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org><1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org><9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley><D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org><vpqy46my05v.fsf@anie.imag.fr><F57B7CD2-8F8B-4D58-B145-285E69F9B4BE@grenoble-inp.org><vpq7fe2rbno.fsf@anie.imag.fr><A8FD6EF510F149A4A05FE553BEDD8511@PhilipOakley> <vpqporucl6g.fsf@anie.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
	"Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>,
	"Samuel Groot" <samuel.groot@grenoble-inp.org>,
	"Tom Russello" <tom.russello@grenoble-inp.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:22:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA06A-0006ge-Pu
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 21:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbcFFTWB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 15:22:01 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:36834 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbcFFTWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 15:22:00 -0400
Received: from PhilipOakley ([92.22.6.31])
	by smtp.talktalk.net with SMTP
	id A061buQ4ksdETA061b7BPt; Mon, 06 Jun 2016 20:21:58 +0100
X-Originating-IP: [92.22.6.31]
X-Spam: 0
X-OAuthority: v=2.2 cv=B/D766lM c=1 sm=1 tr=0 a=6rKLwjNE5rx67PMj20oCSw==:117
 a=6rKLwjNE5rx67PMj20oCSw==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=GvpCenJnBcaIQRKAfwcA:9 a=xts0dhWdiJbonKbuqhAr:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPzC41UGpczw2oJdJ2KjajFp0cjeMBhJweqKY7R6Atpeuj7dlRfw6aK8/Wkv4elQZ+vsE6ony+JqJYIEBwxTGwr930kbun7M/5PI/jktgWU2ZrjQ5QuC
 G3lEk8m6QJXs/u8yixQY+TWeJ6UUdjTD3xvbOKKGEAMjxa29MekCjp9b1aqeOPQwMbPhJIXx1SIwo3zpwkc3yvYoPUnLMjXNFrNJLoR9its+Sp+We0kotch/
 NfLjcEc9RI0W4cvO6XgSJbj1ki16xtLcKLcqqze7lX2vV+Z8pC8ROFdkeh/U+8sv/VsN8+KPAsFKrnsJ1+NQlrm+NOsOvW2eGpxFuBmN4wsnIMsheX7Ozw3/
 n9LFZ81lCgI68iIlVJzoAvKogJiKY2KfBr4y4gaIiFu6kSAdZ8dQX75CBD7vheLXG/9slZsd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296553>

=46rom: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
>>>
>>> I don't think you will find a name that fits all use-cases. IHMO, b=
est
>>> is to pick one rather general use-case, make the explanations for i=
t,
>>> and maybe explain somewhere that there are variants.
>>>
>>> If the fork is completely private, then your diagram with a "mainta=
iner"
>>> arrow from it to upstream is not valid.
>>
>> That's only true for a Pull Request workflow. For a Patch workflow
>> (such as Git) the user's home vault can be completely private.
>
> But then the maintainer is not the one picking changes from it (you'r=
e
> sending them by email), so the "maintainer" label is not really accur=
ate
> in the diagram:
>
> +------------               -----------
> +| UPSTREAM |  maintainer   | ORIGIN  |
> +|  git/git |- - - - - - - -|  me/git |
> +------------       =E2=86=90       -----------
> +         \                   /
> +          \                 /
> +     fetch=E2=86=93\               /=E2=86=91push
> +            \             /
> +             \           /
> +             -------------
> +             |   LOCAL   |
> +             -------------
>
Ahh, that's a useful clarification. I use my git repo both for the G4W=20
(which does take pull requests) and for Junio's Git.

The use of the 'home-vault' fork as being for
(a) backup,
(b) open viewing, and
(c) sending pull requests
are subtle distinctions for the naming (of both the forked repo, and th=
e=20
workflow).

It's probably even worse in a corporate environment as to how personal =
the=20
personal home vault is, as compared to just having a namespace in a=20
centralised dev server/repo. (the question of how to make such arrangem=
ents=20
seems to come up moderately often on the various lists)

Philip=20
