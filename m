From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] SubmittingPatches: Cite the 50 char subject limit
Date: Wed, 28 Jul 2010 19:25:58 +0000
Message-ID: <AANLkTimieHJaw1UmKtQvS4=2i8TrmR5A5zFO13NaNBo=@mail.gmail.com>
References: <1280326285-10203-1-git-send-email-avarab@gmail.com>
	<7vzkxb4j1v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 21:26:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeCGc-0001nj-AE
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 21:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280Ab0G1T0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 15:26:07 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47351 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab0G1T0F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 15:26:05 -0400
Received: by gyg10 with SMTP id 10so1828018gyg.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hGbxcYNQtZpmYSzpYqQE0wHzTSsBOp3vhqbNKJY0tDI=;
        b=ha1KaaYmWsdgeGVi4RJlxlVWjbf8MK/g8mwTz1JYTVrf1wBNLzu+hN2zqOrA0+LHlh
         KvIqpgU2t/Iu0/uyc+IsCfQlJ2CZ8B/mPzK11VVsojOPBv1SyWbbCsGVCbfx+6JqPYUh
         imoN239C42OZMfSk4yZKMKBsht8mJMf730Utc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fvdPEs46gRXalbV3SlAgY5PmvwYF2got7HwdsQOLhtSteSDaymU9dlU9tN2HdfaHda
         29PbBIwMDKZkPCqwqE+YagoC82pcwF8CL8FsTF00cU4u6hgKDeJyM6M+yvhA/jktawl1
         o5MmfkmubgQPWRorVPEr286XR49og/j6gcJZU=
Received: by 10.150.93.13 with SMTP id q13mr3104736ybb.339.1280345158829; Wed, 
	28 Jul 2010 12:25:58 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 28 Jul 2010 12:25:58 -0700 (PDT)
In-Reply-To: <7vzkxb4j1v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152114>

On Wed, Jul 28, 2010 at 17:23, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Change the SubmittingPatches recommendations to mention the 50
>> character soft limit on patch subject lines. 50 characters is the so=
ft
>> limit mentioned in git-commit(1) and gittutorial(7), it's also the
>> point at which Gitweb, GitHub and various other Git front ends start
>> abbreviating the commit message.
>
> Hmph, we probably would want to do s/50 character/&s/ in the two manu=
al
> pages.

I'm not sure if "with a single short (less than 50 character) line" is
is grammatically correct with "characters", since "characters line"
wouldn't make sense.

On the other hand that sentence violates the rule that when you put
something in parens your sentence should still make sense with
s/[()]//g, "a single short less than 50 character line" is pushing it.

I do not think if anybody is ready to stand behind the specific
> number "50", and we can bikeshed about it separately.
>
> The spirit of having a soft limit is twofold:
>
> =C2=A0- It should fit on "git log --oneline" comfortably;
>
> =C2=A0- If your change is too complex to be summarized in such a shor=
t
> =C2=A0 sentence, you probably are doing too many things in one commit=
=2E
>
> The first does not justify "50" any better than other arbitrary limit=
, but
> with things like --graph and --source, anything longer makes the resu=
lting
> output very close to the edge of an 80-column terminal.
>
> The second does not justify "50" either, as your language may be verb=
ose
> or terse (e.g. Japanese can cram far more information in a 140-char t=
weet
> than somebody writing in English), but it is a more important one bet=
ween
> the two rationales above.

Right, 50 characters isn't magical. But I find it to be a really good
indicator that I'm going over the limit.

When I want to write something that's 60 characters or more that's
usually a sign that I should simplify the subject and just write a
more detailed body.

50 also fits neatly into interfaces where you want the summary and 2-3
other things on the page. Like in the Gitweb or Github interfaces.
