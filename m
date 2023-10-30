Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E733DD
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHQI2w77"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DDE93
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:26:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-508126afb9bso6610493e87.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698686791; x=1699291591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msmucqEl5mzvgatR9YB9AlIVXje56OBKp4nWa8iyE/U=;
        b=DHQI2w77iNxCUK5CO+33hqmee35QQLGKrl7Xu8BII2KHZhgPsSX2SWGyOdRMci91AP
         tSPUm+aitmBJjC76i+fUcM0c1W+b4IGHNy+mlzmmZPoGkpD+2IL1BEfPZIm/WSRMbuM+
         xlGvUhSiYVJogD1XgG8oRXWld9GrPmtvB12DQHtls0Kn8jSiJ6Y0kdKen2ZM7T82vTW9
         9OOVszpQQW5x67Dt1eTgpl27IpkJ7FbgHfmxels/5k7yRszVQoQQN83UxIHdCNyfj3Lm
         s3wl1MMIr/syxbtbp+c5ECMGkKCTTwXM+EZx5J4KtIQg4ML4MDja0jpIoOkao9aDe+65
         MfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686791; x=1699291591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msmucqEl5mzvgatR9YB9AlIVXje56OBKp4nWa8iyE/U=;
        b=QnTZWTXIe8xEsm8EIZI028bf4fll9JZY4jvuCtvXdwopYiHBY7Nkp7lqFnhaQq2qG9
         jDenEer1LW37RPNjm8xncdGbAWL2sMKJ5GcIz4bNYVFVudMp3zDn2PN7huGuxyhHBzjM
         lOFcGxZ2M8XxOQ3A5VJfvFT7HkoKjh9P7tzM8E+w4Mbom/5AP4nhbMlwPkpCiMzpjdea
         ApZUqTZXE6WZY6Rl7U241Op2vtFxLRNYlxVN2SnWb+N7X2Ut3WaqWk9UNKnvvRcuIQss
         DnWq8xPSVm8Ih/vBcIz4rwncMWbLnuXOu4tCrnkJaaFKBjJEZcRYew5/eg88qQnfoXvM
         mCuQ==
X-Gm-Message-State: AOJu0Yxd0r5OvnP6Ctii2OHf/gD4X8jKMgxgtkjg3WF2T/fU4oz96mYH
	BqK1aTjz3GTKeDS/8APcgPKlKqhFk9AvqSv39VAeRije
X-Google-Smtp-Source: AGHT+IG45HGPEan3XSQ5HzfM4TgDlE37LJXj3EuJC0MHpuCyVnr7Klc7Cd37KRPwqSvhJPnH7PhVpljTxTT4Rm7I91Y=
X-Received: by 2002:ac2:4c82:0:b0:507:9a33:f105 with SMTP id
 d2-20020ac24c82000000b005079a33f105mr6791418lfl.69.1698686791449; Mon, 30 Oct
 2023 10:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com> <xmqq7cn4g3nx.fsf@gitster.g>
In-Reply-To: <xmqq7cn4g3nx.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 30 Oct 2023 10:26:18 -0700
Message-ID: <CABPp-BE6_nuMeiqOAMGwP8SH=d1+i57-STgTNKU8-Gnkv2jW=Q@mail.gmail.com>
Subject: Re: [PATCH] sequencer: remove use of comment character
To: Junio C Hamano <gitster@pobox.com>
Cc: Tony Tung via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Tony Tung <tonytung@merly.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 9:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Tony Tung via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Tony Tung <tonytung@merly.org>
> >
> > Instead of using the hardcoded `# `, use the
> > user-defined comment_line_char.  Adds a test
> > to prevent regressions.
>
> Good spotting.
>
> Two observations.
>
>  (1) There are a few more places that need similar treatment in the
>      same file; you may want to fix them all while at it.
>
>  (2) The second argument to strbuf_commented_addf() is always the
>      comment_line_char global variable, not just inside this file
>      but all callers across the codebase.  We probably should drop
>      it and have the strbuf_commented_addf() helper itself refer to
>      the global.  That way, if we ever want to change the global
>      variable reference to something else (e.g. function call), we
>      only have to touch a single place.
>
> The latter is meant as #leftoverbits and will be a lot wider
> clean-up that we may want to do long after this patch hits out
> codebase.  The "other places" I spotted for the former are the
> following, but needs to be taken with a huge grain of salt, as it
> has not even been compile tested.
>
> Thanks.
>
>  sequencer.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git c/sequencer.c w/sequencer.c
> index d584cac8ed..33208b1660 100644
> --- c/sequencer.c
> +++ w/sequencer.c
> @@ -1893,8 +1893,8 @@ static void update_squash_message_for_fixup(struct =
strbuf *msg)
>         size_t orig_msg_len;
>         int i =3D 1;
>
> -       strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
> -       strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));
> +       strbuf_addf(&buf1, comment_line_char, "%s\n", _(first_commit_msg_=
str));
> +       strbuf_addf(&buf2, comment_line_char, "%s\n", _(skip_first_commit=
_msg_str));
>         s =3D start =3D orig_msg =3D strbuf_detach(msg, &orig_msg_len);
>         while (s) {
>                 const char *next;
> @@ -2269,8 +2269,8 @@ static int do_pick_commit(struct repository *r,
>                 next =3D parent;
>                 next_label =3D msg.parent_label;
>                 if (opts->commit_use_reference) {
> -                       strbuf_addstr(&msgbuf,
> -                               "# *** SAY WHY WE ARE REVERTING ON THE TI=
TLE LINE ***");
> +                       strbuf_commented_addf(&msgbuf, comment_line_char,=
 "%s",
> +                               "*** SAY WHY WE ARE REVERTING ON THE TITL=
E LINE ***");
>                 } else if (skip_prefix(msg.subject, "Revert \"", &orig_su=
bject) &&
>                            /*
>                             * We don't touch pre-existing repeated revert=
s, because
>

I thought the point of the comment_line_char was so that commit
messages could have lines starting with '#'.  That rationale doesn't
apply to the TODO list generation or parsing, and I'm not sure if we
want to add the same complexity there.  If we do want to add the same
complexity there, I'm worried that making these changes are
insufficent; there are some other hardcoded '#' references in the code
(as a quick greps for '".*#' and "'#'" will turn up).  Since those
other references include parsing as well as generation, I think we
might actually be introducing bugs in the TODO list handling if we
only partially convert it, but someone would need to double check.
