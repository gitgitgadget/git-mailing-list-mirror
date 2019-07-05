Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324EA1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 22:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGEWCL (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 18:02:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38501 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGEWCL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 18:02:11 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so22046630ioa.5
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HcSGL+RC5GP/MYyMZIgpbw9fsFMvPKZrXfdBp+GB9pk=;
        b=r9a383L2HdvCETTrQuSoHW076eH0Lhc/c+iQLvyV1l1F5O4P0I2DfQPsTUvSsMrqoZ
         ehLajivsbI4aRPT4NlWzHRFHJmIS9gVSr43/ZO9Xr4db/gF+fXV5ttmK6fMIuJ3b0UBO
         mXEwfp+7xTKrWpfdvJ8WtqFkJYFok0G5AC7Jr+wtNxjXT1+d69Ah+UH26nRwHpUzcgpW
         TflSCXDIyB5TLKHdnMcHr5lZ4MgqpfIhD0jwXRC2RHep0H92f7kOR7Q7ojmDN6eExige
         8fsGMfiwVHQx2cDwFAw+UlTH94VCEScReH0IHuY5sPjZxIiUSXB15v62rZq2RIuqRqw4
         emYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=HcSGL+RC5GP/MYyMZIgpbw9fsFMvPKZrXfdBp+GB9pk=;
        b=BOw2TnDHTHRlukL8mJW52FPb0Hkd96Kq3KeLtf9IyNQo7eBf0OB05LTAGodzMdJYJC
         SW8NZyWTNcICjZ9sQsOxLBnyuIHkeeo9eFvmRAsPtJREcM5wJ67IdDiz7dnA0LNJzsYo
         Llelb8B6DT/XR3CYdesuvCis/QyBACQcm9NpP8TmWCK8hxpzIeU7GhVqyjShtDEU8dQQ
         8byoyrujFuJopQLAhpJQBLQgxgjjLc02UWxoQMFHsbm7o9gQtefwLYwmcqvK/vEbG6Lr
         Vck64rfK2hp9Cs2Qc0TeFr3fAMztCiSw0LwT2fM0rw9jOAzq1z8LfFb7IbyjGbSFUxka
         pvEg==
X-Gm-Message-State: APjAAAXw2anZKgniYBuh8p7cNjv4r/+C7K9auCGBkQPDvPcW/ap7Bn6n
        OajxvERPL2ZK+xlLqjXDS8+kdugQwgc4HZyNfi/lqg==
X-Google-Smtp-Source: APXvYqxsIW7Q2CZsGliWQU+3GrM47nIefQ0OpGYGgUBx0wncibgI6FUJOoXlZmTMA9rQdecd0a3J/f6gNU+wUWV1a1A=
X-Received: by 2002:a02:cc76:: with SMTP id j22mr7396442jaq.9.1562364130139;
 Fri, 05 Jul 2019 15:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOqHT5KUFOY9g-PDDq=PaXdqS41ZGYGMAUuBkU-UrPiSumqhTQ@mail.gmail.com>
In-Reply-To: <CAOqHT5KUFOY9g-PDDq=PaXdqS41ZGYGMAUuBkU-UrPiSumqhTQ@mail.gmail.com>
From:   scott douglass <scott0douglass@gmail.com>
Date:   Fri, 5 Jul 2019 23:01:59 +0100
Message-ID: <CAOqHT5K_JZDZ1agEL4ceVdYY=4YYO715v+j_bNbJWOoV=KNqQQ@mail.gmail.com>
Subject: Fwd: Discovering the new parents in commit hooks
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I=E2=80=99d like to be able to discover the new parents-to-be SHA-1s during
the hooks that run before a commit*.  Essentially I=E2=80=99d like be able =
to
distinguish the =E2=80=98git commit=E2=80=99 case from =E2=80=98git commit =
=E2=80=94amend=E2=80=99. Is there
already a way to do this that I have overlooked? (I=E2=80=99ve read =E2=80=
=98man
githooks=E2=80=99 and searched the wiki and various other places.)

If not, I would propose that perhaps the hooks could be passed a
GIT_PARENTS (or perhaps GIT_NEW_PARENTS) environment variable which in
the =E2=80=98not amend=E2=80=99 case would contain the SHA-1 for HEAD and M=
ERGE_HEAD
(if appropriate) and in the =E2=80=98=E2=80=94amend' case would contain HEA=
D^@ (all of
the parents of HEAD).

[*] Specifically, it seems a useful thing to be able to find out in
these hooks:  applypatch-msg, pre-applypatch, commit-msg,
prepare-commit-msg, commit-msg

Thanks.
