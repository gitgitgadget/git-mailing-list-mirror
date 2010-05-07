From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Fri, 7 May 2010 12:02:49 -0700
Message-ID: <v2g8c9a061005071202h820ef8a6nab023868fec28222@mail.gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com> 
	<1273180440-8641-1-git-send-email-avarab@gmail.com> <AANLkTik6z4cvUzjfq-q61tgk_MhqWKc_A55i3VauPSQC@mail.gmail.com> 
	<AANLkTinhh8TXY9r9Jf394YKYXDxpU65qjg7MbPcb12Ls@mail.gmail.com> 
	<AANLkTilp0d28QMs_K7cVrfqmkzeqs8FTJbU1oeuUy7V6@mail.gmail.com> 
	<AANLkTilG5OGjQcd1Vd1CdyOibFh4Po6jdfvSRNidrRzh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 21:03:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OASpQ-0002qg-FI
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab0EGTDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:03:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56853 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab0EGTDK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:03:10 -0400
Received: by vws3 with SMTP id 3so28500vws.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BGqnxxyMRQwq/4NogJgcDSGlc985svGMIYOj3ZtfJHE=;
        b=WAvzUmaC4soW1uEabT2WrbZJb76BIdYeu3cIEp2h3NQc0aifgZH8CQOXRRgeVajrXA
         YAy7bXnsTQpwDQtWQKdicyB2AgZ2lQ6kXmhMyAoNvhpKnmZ4XSN6EkFkgeC5StQGtBVi
         ArsOxDiZ4NYoHz5y2XAqctCb3LT6YlGEl8Mnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GgUQKGlkSmGJKwjo6gA0axArpXNKnTxCoaCZT9u3KuC5LSqaSKHk7SrIOTWEU4aMzY
         eNyI1Ulf6NTAaEwnWvOGqBgp+DxJWW08XvawQGdkLjj+MCQRIXldv5idaDxO3fdMhOGS
         TEVtJCptT6lDbP9tVT+BKniyzSc+s92LBXQhk=
Received: by 10.229.231.193 with SMTP id jr1mr378490qcb.25.1273258989264; Fri, 
	07 May 2010 12:03:09 -0700 (PDT)
Received: by 10.229.215.131 with HTTP; Fri, 7 May 2010 12:02:49 -0700 (PDT)
In-Reply-To: <AANLkTilG5OGjQcd1Vd1CdyOibFh4Po6jdfvSRNidrRzh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146553>

On Fri, May 7, 2010 at 11:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Fri, May 7, 2010 at 18:29, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
>> On Fri, May 7, 2010 at 18:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>>> On Fri, May 7, 2010 at 06:00, Bert Wesarg <bert.wesarg@googlemail.c=
om> wrote:
>>>> On Thu, May 6, 2010 at 23:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>>>>>
>>>>> Not-signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com>
>>>>
>>>> So you don't agree to the Developer's Certificate of Origin, don't=
 you?
>>>
>>> Signed-off-by is for "if you want your work included in git.git"
>>> (according to Documentation/SubmittingPatches). I don't think this
>>> patch is ready for inclusion as-is, but I wanted to solicit comment=
s
>>> on the general approach.
>>>
>>
>> Can you please quote SubmittingPatches for your argumentation.
>
> I already did, but here's the full paragraph I quoted from, for
> reference:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- if you want your work included in git.gi=
t, add a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Signed-off-by: Your Name <you@exam=
ple.com>" line to the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0commit message (or just use the opt=
ion "-s" when
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0committing) to confirm that you agr=
ee to the Developer's
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Certificate of Origin
>
> I'm not seeking to include this work as-is in Git, so I added a
> Not-signed-off-by line to make that clear (as if all the bugs didn't
> do that already).
>
> I do agree to the Developer's Certificate of Origin, but just read th=
e
> "Not-signed-off-by" as "you really don't want to apply this in its
> current state". I'm asking for comments so that I can produce an
> appliable patch, that one will have a Signed-off-by line.
>

Having "[RFC]" instead of "[PATCH]" as the subject prefix is typically
considered sufficient to indicate "this isn't actually intended for
inclusion".
