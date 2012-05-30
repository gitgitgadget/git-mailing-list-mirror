From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for translation
Date: Wed, 30 May 2012 12:27:55 +0700
Message-ID: <CACsJy8Dg-M+3+_LWksq4fYHq3Tx96bQEDYkHApMj8+d=5wqqjQ@mail.gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com> <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
 <20120529203759.GC22151@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 07:28:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZbSR-0007hB-MN
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 07:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab2E3F21 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 01:28:27 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36493 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab2E3F20 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 01:28:26 -0400
Received: by wgbdr13 with SMTP id dr13so4629537wgb.1
        for <git@vger.kernel.org>; Tue, 29 May 2012 22:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rPcNr5693Ra+5WzAD/DCJHg+sqKMy7IajOt06oHjXj8=;
        b=zOoH0qbKUwPvKwcYyFcXsAsRTrCvHAzj534yvNTmKccm0GVKg+5m88N9xS5/gYM67v
         jrrMZ6SdeNj6/KdcKZdM+o2CTVulk0SCV7WEBlmGsDhTUNj0z5R+eG5sTjibX+VrIqV1
         wLGQtg0tOplhXus6Tsc6dKHPwDKDeKnL6LaS48i7c9O0KkQdW+kVDJy8iH2n1KmBzGuE
         9Dp7kbegugTEhkSHHCy/xPdrqns3hA6v0T6kQnSFEWg+P/jziMW/iJymPK9RjrFf0pyb
         sBcTKreS0MIK1aLrTYjzpDE0hVl1Q/Tuw5lQT6JDFpiOub2iU8oLaqku+pGdBF7CGhe6
         w3lA==
Received: by 10.216.50.211 with SMTP id z61mr8945107web.57.1338355705617; Tue,
 29 May 2012 22:28:25 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 29 May 2012 22:27:55 -0700 (PDT)
In-Reply-To: <20120529203759.GC22151@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198781>

On Wed, May 30, 2012 at 3:37 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Junio C Hamano wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>
>>> --- a/archive.c
>>> +++ b/archive.c
>>> @@ -7,10 +7,10 @@
>>> =C2=A0#include "unpack-trees.h"
>>>
>>> =C2=A0static char const * const archive_usage[] =3D {
>>> - =C2=A0 =C2=A0"git archive [options] <tree-ish> [<path>...]",
>>> - =C2=A0 =C2=A0"git archive --list",
>>> - =C2=A0 =C2=A0"git archive --remote <repo> [--exec <cmd>] [options=
] <tree-ish> [<path>...]",
>>> - =C2=A0 =C2=A0"git archive --remote <repo> [--exec <cmd>] --list",
>>> + =C2=A0 =C2=A0N_("git archive [options] <tree-ish> [<path>...]"),
>>> + =C2=A0 =C2=A0N_("git archive --list"),
>>> + =C2=A0 =C2=A0N_("git archive --remote <repo> [--exec <cmd>] [opti=
ons] <tree-ish> [<path>...]"),
>>> + =C2=A0 =C2=A0N_("git archive --remote <repo> [--exec <cmd>] --lis=
t"),
>>> =C2=A0 =C2=A0 =C2=A0NULL
>>> =C2=A0};
>>
>> I can understand the "help" text member of OPT_BLAH() construct, but
>> do we really want to translate the above?
>
> <repo>, <cmd>, [options], <tree-ish>, and <path> may be spelled
> differently in other languages. =C2=A0Would it be possible to take ca=
re
> of this kind of substitution automatically?

not for the "[<path>...]" part

> At least "git archive --list" should probably be kept untranslated
> to lessen the translator workload a bit. =C2=A0Good catch.

I use po-mode and for strings that no change is required like this,
simply C-j to copy as-is after a glance.
--=20
Duy
