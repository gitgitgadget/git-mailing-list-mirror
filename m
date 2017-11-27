Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC8720C11
	for <e@80x24.org>; Mon, 27 Nov 2017 20:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbdK0UEr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 15:04:47 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:41319 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdK0UEq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 15:04:46 -0500
Received: by mail-wm0-f66.google.com with SMTP id b189so36529817wmd.0
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 12:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K7qI00qk9I5ncBrdTCWD6AGdBIk8DsXB1U6OitTRPeY=;
        b=r5QTFP42r2Sv4Q7zJVtFiA6F4QUvwesJQnbScCrfPalmyOsTfPe5BBXKMzRZfi5LzU
         90eHiS9Hy29fDxChDxh9GEury9FjHoSMpoFW74e1lqp6AqJ3DSw/hxZS5aWFEpoTg2Ht
         tOAz+k5HzMfNBZb2W7WqJgLD5/eER9FFQofqkPnDQOVPdvLm6ane3tT3NyQDpvJjGvtQ
         AwNfEjUryXIyJlEwkaw10G8vlgKB+bgc21+bkkMM0WN8VmCfBNAoGkZyY2RAnz1XxnfE
         GBkFnvn67YpELCuCRTurDrm1ej0K1pBJjzl7zBAX7mtzU2byLaA0u68Luj/fDTWuXds2
         15Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K7qI00qk9I5ncBrdTCWD6AGdBIk8DsXB1U6OitTRPeY=;
        b=QkxIjDhZyb09oC47WKY6m17lD++KqLvnCL0QOKb0AAHDNEWW8CgZPo+LUhwqRn9jV0
         +LL+ZXzmzgIajduBvtygnCFVxPXQWme7nHRuRRYgCKeta+RJshyF1Dtx1Go0jMsWQK11
         OphWrifwPd9nMqsoAbfi7VdfcVnZz9/CM+T3/6gPbogvOFyVqXG7fsz0EraJN/DWnjeM
         TJWjpYtMTz1kXMKjm5AknC813xf/lIPKDiXDvD16XqAJH+ST/i6EiZPsTKYUz6xr68/f
         dv6jLD9Z05lcKJNMMoshYU6w/4wGvtlWztziaQijtYxAmCJ3Ffra37pNVDDe2U/XTBAd
         2FkA==
X-Gm-Message-State: AJaThX6G9wMpZOfvGHfo1ys5VPHftqgA2dRAA8TVAQAUDQ4NxoTfCZLc
        WrA0a4OQ9BsDIwPvsC2mk1w=
X-Google-Smtp-Source: AGs4zMZk4QNoN+LoyOigsz7PvflCzR3CwrgOYUWhT5nZ64T5Pgkjp4tkL7kaGQgsgbw7p/T7BDISdQ==
X-Received: by 10.28.9.146 with SMTP id 140mr18238457wmj.117.1511813085302;
        Mon, 27 Nov 2017 12:04:45 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB66BC.dip0.t-ipconnect.de. [93.219.102.188])
        by smtp.gmail.com with ESMTPSA id 16sm34332465wrt.81.2017.11.27.12.04.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 12:04:44 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cSStSbckFi5K33z0WZThjNZC5Eb1Fb+ikrd5ZajM6mV3Q@mail.gmail.com>
Date:   Mon, 27 Nov 2017 21:04:42 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF8D6B02-37C1-40B3-9FDA-3B1055389B85@gmail.com>
References: <20171127134716.69471-1-lars.schneider@autodesk.com> <CAPig+cSStSbckFi5K33z0WZThjNZC5Eb1Fb+ikrd5ZajM6mV3Q@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Nov 2017, at 19:36, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Mon, Nov 27, 2017 at 8:47 AM,  <lars.schneider@autodesk.com> wrote:
>> When a graphical GIT_EDITOR is spawned by a Git command that opens
>> and waits for user input (e.g. "git rebase -i"), then the editor =
window
>> might be obscured by other windows. The user may be left staring at =
the
>> original Git terminal window without even realizing that s/he needs =
to
>> interact with another window before Git can proceed. To this user Git
>> appears hanging.
>>=20
>> Show a message in the original terminal and get rid of it when the
>> editor returns.
>>=20
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/editor.c b/editor.c
>> @@ -40,6 +40,35 @@ int launch_editor(const char *path, struct strbuf =
*buffer, const char *const *en
>> +               static const char *close_notice =3D NULL;
>> +
>> +               if (isatty(2) && !close_notice) {
>> +                       char *term =3D getenv("TERM");
>> +
>> +                       if (term && strcmp(term, "dumb"))
>> +                               /*
>> +                                * go back to the beginning and erase =
the
>> +                                * entire line if the terminal is =
capable
>> +                                * to do so, to avoid wasting the =
vertical
>> +                                * space.
>> +                                */
>> +                               close_notice =3D "\r\033[K";
>> +                       else if (term && strstr(term, "emacsclient"))
>=20
> You need to check 'editor' here, not 'term', and you should do it
> before the "not dumb" terminal check, otherwise you'll never get this
> far.

Ouch. That happens if I try to do two things at once. Embarrassing.

Thanks,
Lars


>=20
>> +                               /*
>> +                                * `emacsclient` (or `emacsclientw` =
on Windows) already prints
>> +                                * ("Waiting for Emacs...") if a file =
is opened for editing.
>> +                                * Therefore, we don't need to print =
the editor launch info.
>> +                                */
>> +                               ;
>> +                       else
>> +                               /* otherwise, complete and waste the =
line */
>> +                               close_notice =3D _("done.\n");
>> +               }

