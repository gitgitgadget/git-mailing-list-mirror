From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Tue, 7 Jun 2016 21:08:39 +0100
Organization: OPDS
Message-ID: <23D20F2F153B453D8EB5F6B3033911B5@PhilipOakley>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org><1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org><9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley><D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org><vpqy46my05v.fsf@anie.imag.fr><F57B7CD2-8F8B-4D58-B145-285E69F9B4BE@grenoble-inp.org><vpq7fe2rbno.fsf@anie.imag.fr><A8FD6EF510F149A4A05FE553BEDD8511@PhilipOakley><vpqporucl6g.fsf@anie.imag.fr><0B6B083EAEAA4E428C26CDAFE56E2FF6@PhilipOakley> <vpqportbhw4.fsf@anie.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>,
	"Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>,
	"Samuel Groot" <samuel.groot@grenoble-inp.org>,
	"Tom Russello" <tom.russello@grenoble-inp.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:01:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAO8F-0007r4-BP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842AbcFGVBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 17:01:47 -0400
Received: from a2i861.smtp2go.com ([103.47.207.93]:53052 "EHLO
	a2i861.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbcFGVBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:01:46 -0400
X-Greylist: delayed 2649 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jun 2016 17:01:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a0-2; h=Feedback-ID:X-Smtpcorp-Track:Date:Subject:To:From:
	Reply-To:Message-ID; bh=VajtfhKnKnvD5JAxObH50xMxVXr5G7n9oEAP4VXkhU0=; b=aFPbK
	NI0MGDjfVMyNEF3R0ATBv8ovcJL5ZoaZ3ONRmrJ+LL9KdcrJVK2TKT1pjGr4zzUi8mmQBWVShuiy3
	HTEu74bfSu68Rg6txtuTHWX+3QPD097cuT8pdisfsG3Jv9Q+0dGP6hMSYpFuhdXwFWrCm1SCqFEXg
	Kc2VXrmZbEN3JjP81JZIwXFjwvYtsL9FfXDV2joftkkAeN71Wh1DV8GZ87uTKYp5eYptA/qQdh/CX
	FcDkqPVbBWSX3TucSfhW8SjZy1ZTh0QIWrGxfVU6VX8JTMSWeh7hZMOyEXP1BdOphDohp5Se1kE5W
	WejmFWHI7ny02f3T1HHISx2Jq9IJQ==;
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1PjNQteLeTjyNf.VwI7F02LN
Feedback-ID: 66524m:66524aMf6O2Y:66524s9HmiMImg7:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296721>

=46rom: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
>>
>>> But then the maintainer is not the one picking changes from it (you=
're
>>> sending them by email), so the "maintainer" label is not really acc=
urate
>>> in the diagram:
>>>
>>> +------------               -----------
>>> +| UPSTREAM |  maintainer   | ORIGIN  |
>>> +|  git/git |- - - - - - - -|  me/git |
>>> +------------       =E2=86=90       -----------
>>> +         \                   /
>>> +          \                 /
>>> +     fetch=E2=86=93\               /=E2=86=91push
>>> +            \             /
>>> +             \           /
>>> +             -------------
>>> +             |   LOCAL   |
>>> +             -------------
>>>
>> Ahh, that's a useful clarification. I use my git repo both for the G=
4W
>> (which does take pull requests) and for Junio's Git.
>>
>> The use of the 'home-vault' fork as being for
>> (a) backup,
>> (b) open viewing, and
>> (c) sending pull requests
>> are subtle distinctions for the naming (of both the forked repo, and
>> the workflow).
>>
>> It's probably even worse in a corporate environment as to how person=
al
>> the personal home vault is, as compared to just having a namespace i=
n
>> a centralised dev server/repo. (the question of how to make such
>> arrangements seems to come up moderately often on the various lists)
>
> Yes, but again, the point of this thread is to document *one* workflo=
w,

I'd agree here.

> not all possible uses of pushRemote. It's much easier to describe "on=
e
> typical triangular workflow" in a concrete way

That *one* workflow would be a _specific_ flow - I'm reading 'typical' =
as
implying common/general workflow(s), which may not be what you hoped to
convey.

>   than to try to be
> completely general and end up with a description that average users
> would just not understand.

I do think that the description of the one specific flow should include=
 the
clarifications that discriminate it from other, potentially mistakenly
confused with this one, flows. It would be that disambiguation that wou=
ld
clear up the misunderstanding.

>
> It would be different to me if we were writting the pushRemote part o=
f
> config.txt, where we have to be as general as possible.

As an aside, the discussion has indicated that the documentation may be=
 a
bit light on describing (and referencing) how multi-user server set-ups=
 can
be arranged to faciltate (or may hinder) the different flows.
--
Philip
(mail delayed by lack of wifi)=20
