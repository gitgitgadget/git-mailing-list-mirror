From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 25/25] gettextize: git-status shortstatus messages
Date: Thu, 2 Sep 2010 20:34:45 +0000
Message-ID: <AANLkTikALp-JtWSnvG2qvQ3h06AZpXg1DOnMs9Pp6EoO@mail.gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
	<1283456446-22577-26-git-send-email-avarab@gmail.com>
	<20100902202537.GC2531@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:34:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGUq-0005sH-J6
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076Ab0IBUes convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:34:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57928 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab0IBUer convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:34:47 -0400
Received: by fxm13 with SMTP id 13so610968fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sNRhP/GAXkAis4xh0LGRpYXLNLZTCWY4GcZPsWdEKUs=;
        b=mf6jbweYK5PtQxABNMx0vGavJuCYz7I0bd+FKoApUuTt1PXqYeJD30XCb/VKmpVrNE
         wN4mbNNdN8YhyNCZqPWZOqxZo379cqkB5v4JBAKW4kax/igKgbv9kYFPcK3+x33AN22l
         GQIV2XjHDw+4OXP1qq7Kwi1WqHm+rf2Rc6ZSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OTOd2vqetHC38047YU+tDcUkH1xbXBstvIWeLvbIARhKz9tRY3C7tmOz6W6duKd3pe
         zCx9gLLKMsGvDI53ofMR+lquO3pBJ/nf9LOWx4urtF29Ajt/eAOnqoGnBhKlJTFWYuM1
         9xHYMq1dmEyxwEMQb1jnhAzh8tFVOeQeZLHHM=
Received: by 10.223.109.130 with SMTP id j2mr7774149fap.54.1283459686126; Thu,
 02 Sep 2010 13:34:46 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Thu, 2 Sep 2010 13:34:45 -0700 (PDT)
In-Reply-To: <20100902202537.GC2531@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155199>

On Thu, Sep 2, 2010 at 20:25, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -814,15 +814,15 @@ static void wt_shortstatus_print_tracking(stru=
ct wt_status *s)
> [...]
>> =C2=A0 =C2=A0 =C2=A0 } else {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp, hea=
der_color, "ahead ");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp, hea=
der_color, _("ahead "));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp=
, branch_color_local, "%d", num_ours);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp, hea=
der_color, ", behind ");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp, hea=
der_color, _(", behind "));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp=
, branch_color_remote, "%d", num_theirs);
>
> What we make those translators suffer through. :) =C2=A0Would it be p=
ossible to
> (eventually) introduce an interface vaguely like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0color_fprintf2(s->fp, "%C(ahead )%C(%d)%C(=
, behind )%C( %d)",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0header_color,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0branch_color_local, num_ours,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0header_color,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0branch_color_remote, num_thei=
rs);
>
> ? =C2=A0I guess this would require using strbuf_expand instead of vsn=
printf
> for %d et al.

Yeah, that's my eventual master plan. This color_printf() interface
really needs something like that so we can reasonably translate
git-status et al.

Aside from gettext that'd make using color_fprintf() much
nicer. Assembling messages like this bit-by-bit is really hard to
follow.
