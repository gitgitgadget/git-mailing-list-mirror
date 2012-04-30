From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/5] diff: move TRANSLATORS comments so they're picked up
Date: Mon, 30 Apr 2012 19:54:06 +0200
Message-ID: <CACBZZX7H-g836PwBA+zn8V+1TRhf36R3DA6qGmbFw9ybD62vKQ@mail.gmail.com>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
 <1335799995-7667-2-git-send-email-avarab@gmail.com> <7v8vhdgma7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 19:54:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOunx-0001TV-8w
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 19:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361Ab2D3Ry2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 13:54:28 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59227 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab2D3Ry1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 13:54:27 -0400
Received: by mail-ey0-f174.google.com with SMTP id q12so757655eaa.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Dj5QNGj4FaA0amz58raE6JXDtkIXtrdzTV37sZuRiRk=;
        b=qW0v7VNOcWtpfX9nFj6zKCdRHco4LM+1GB4yJk+g35SmzrtvZqCFq8YRd+Mm+cic2D
         EOnTFbIzVtBb6Aozk5X/0NzEjZIeyoh/NR/klAC7DM3seXUp6Ef2NmO7pH7aNXY9/xn1
         sF/st0NQdEeqGFab+37jeQb+NJIukB3WqXu0QWON+K2hsECY3/reAPqkJ+oESJwemiA7
         QREedwpNWT+eKzEcuDrBvUkBAaOMnFuhzqiimiCnfeGHVSlq3bnXwsgPcOM2mtnI5P6s
         vBIu+DuGjFupCrm0wvGxjPX8h583ZZu07ETMM52pRL/tA048IwvT8Zr2ExDKs+2K4Noj
         jFnQ==
Received: by 10.14.207.9 with SMTP id m9mr495949eeo.52.1335808466761; Mon, 30
 Apr 2012 10:54:26 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Mon, 30 Apr 2012 10:54:06 -0700 (PDT)
In-Reply-To: <7v8vhdgma7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196584>

On Mon, Apr 30, 2012 at 19:30, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> These TRANSLATORS comments weren't actually picked up by xgettext, t=
he
>> comment needs to be right before the Q_() function call, evidently i=
t
>> isn't picked up if that call is wrapped in another function call.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>
> The patch makes sense as an advice to people who update sources where=
 to
> place the "TRANSLATORS:" comment, but I am unsure about what this
> particular one says. Are we assuming that translators do not know wha=
t the
> sentence they are translating refers to?

They'd know if they looked at the source, but the reason for moving
this is that at the previous location the comment wasn't getting
picked up by xgettext.

I.e. before there would be no comment in git.pot and the derived PO
file, now there would be, in practice that means that most translators
will actually see it.

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&sb,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* TRANSLATORS: "+" in (+) is a line addition ma=
rker;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* do not translate it.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 Q_(", %d insertion(+)", ", %d insertions(+)",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0insertions),
>
> What I am getting at is that this may be simply being unnecessarily n=
oisy
> by trying to be helpful, and I am not sure if you are drawing the lin=
e at
> the right level. =C2=A0For example, "insertion" has many meanings and=
 in the
> context of this sentence it means lines added to the old material---s=
hould
> we mention that here, and tell translators to use the word that conve=
ys
> that particular meaning?
>
> For this particular one, I'd be happier if the TRANSLATORS comment to=
ld
> them to check if "diffstat" (which we borrowed this from) has a l10n =
of
> this message for the language they are translating to, and make sure =
they
> use the same format here.

That makes sense. But for this patch I just wanted to fix things up so
that it was placed in the PO file.
