Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1351F404
	for <e@80x24.org>; Sat, 27 Jan 2018 01:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeA0Bpf (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 20:45:35 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34835 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeA0Bpe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 20:45:34 -0500
Received: by mail-ot0-f195.google.com with SMTP id w26so2018483otj.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 17:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A6n6kjcv1BV6QSdCcjfDtWHzMhtxRunbnGGv9PMtYYk=;
        b=CC35tyknJYDp9srfLP+oMfvDVTI112RM6lAmXSf5KSc8z5/PxJX/wt0h2uUFJYre16
         yqa7j4MwAJ7Np195QupsmpnOSWGAF0Y9NKuqjubzIGcQpH7d8qNTGNY0TukuGfQRh8GS
         Zxt18j1OveLrAMoKfIAvI9Q53RteNGSttK72AAhA0xNZChAwx3FHdE0Zd0AOUsUhmkQ3
         PxEEXakBSZxlaXC3ppgGvR4jTIw0K/B1yVj93jii1bMSIFLMnb6rN+A91nFJjisvxOOh
         ngZ41av7V9rfNxYmmIGBC8MCY+PPcJDMtoBt6vt7dfQUoemfIjnKzTKn9ajRSwaNcEeS
         WNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=A6n6kjcv1BV6QSdCcjfDtWHzMhtxRunbnGGv9PMtYYk=;
        b=YjtNGSNUmspCjg//QEbf4L4awhA90Lb9m/6QrC/iXBmDme0ZNDwguJzx6/t7U3KCZG
         /r9hL4ANFeKWaCHl+XkBGI8+E4mu/4oE3HqQajhUUMQc69FcgZadBmr31z3TYVzRDnqa
         DG/RZbNonn/USaVRAgivJFDaoautJal0j0ufKQGnf00VX/DrqgwqHnR7gmsPTbjMJAlD
         UVlimEyg98OpEUE25Mxrswt1B1BE0kNUQ069KjQjQ2usqfZEG5ZiTwUftzEFa9hjU88i
         8qR8AzrAh3/XL7txfUnBrJ8xPPkWEmc6WVy0tLrHss3Ruym33Xhj/DZF6RAdePOakQ/U
         wylw==
X-Gm-Message-State: AKwxytf9Snfft6hEWW79CNAcMkOT2/qnAb3khztWpOsMKmUYFc+w0STx
        81pifX7MBzTC+qCo3BSX88AapZkeakf2SrTOvWY=
X-Google-Smtp-Source: AH8x226EeuFWjXbqgaz2802OHFFAqd0BVP8Hqs7DMWouIgLtBEuPf9MI5qNDV5CIQIAxYucLZGvnScQDN2p5hfz5sFg=
X-Received: by 10.157.53.12 with SMTP id o12mr15262152otc.181.1517017533782;
 Fri, 26 Jan 2018 17:45:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.8.133 with HTTP; Fri, 26 Jan 2018 17:45:03 -0800 (PST)
In-Reply-To: <87372s78zo.fsf@passepartout.tim-landscheidt.de>
References: <20180126095520.919-1-pclouds@gmail.com> <87372s78zo.fsf@passepartout.tim-landscheidt.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Jan 2018 08:45:03 +0700
Message-ID: <CACsJy8A=SDPEK7qeLRi_eLM+L5zszWWSiEQtbmQVuG1E2ENBig@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add "git rebase --show-patch"
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 27, 2018 at 1:47 AM, Tim Landscheidt <tim@tim-landscheidt.de> w=
rote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> wrote:
>
>> When a conflict happens during a rebase, you often need to look at the
>> original patch to see what the changes are. This requires opening your
>> favourite pager with some random path inside $GIT_DIR.
>
>> This series makes that experience a bit better, by providing a command
>> to read the patch. This is along the line of --edit-todo and --quit
>> where you can just tell git what to do and not bother with details.
>
>> My main focus is "git rebase", but because rebase uses "git am" behind
>> the scene, "git am" gains --show-patch option too.
>
>> There was something more I wanted to do, like coloring to the patch.
>> But that probably will come later. I'll try to merge these two
>> 21-months-old patches first.
>
>> [=E2=80=A6]
>
> I dislike the approach to use a separate command/option.
> The nice thing about rebase-apply/original-commit is that
> you can use it in /any/ git command, i. e. you can do "git
> log $whatever..rebase-apply/original-commit".
>
> What I would do instead is (besides documenting it :-)) to
> provide an alias that is more in line with ORIG_HEAD,
> FETCH_HEAD, etc.; i. e. something along the lines of (pseudo
> code, will probably not work):
>
> | --- a/builtin/am.c
> | +++ b/builtin/am.c
> | @@ -1110,6 +1110,7 @@ static void am_next(struct am_state *state)
> |
> |         oidclr(&state->orig_commit);
> |         unlink(am_path(state, "original-commit"));
> | +       delete_ref(NULL, "ORIG_COMMIT", NULL, 0);
> |
> |         if (!get_oid("HEAD", &head))
> |                 write_state_text(state, "abort-safety", oid_to_hex(&hea=
d));
> | @@ -1441,6 +1442,7 @@ static int parse_mail_rebase(struct am_state *sta=
te, const char *mail)
> |
> |         oidcpy(&state->orig_commit, &commit_oid);
> |         write_state_text(state, "original-commit", oid_to_hex(&commit_o=
id));
> | +       update_ref_oid("am", "ORIG_COMMIT", &commit_oid, NULL, 0, UPDAT=
E_REFS_DIE_ON_ERR);
> |
> |         return 0;
> |  }
>
> This (when working) would allow to use ORIG_COMMIT in place
> of the mouthful rebase-apply/original-commit.

Interesting. Taken out of context, I don't think it really works for
"git am" because the source patches are in text form and "git am" only
fails when it can't apply the patch (and won't be able to create a
commit). But for rebase I can see how this is a good thing. Thanks.
Let me sleep on it for a bit. It works for cherry-pick too.
--=20
Duy
