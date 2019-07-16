Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF081F461
	for <e@80x24.org>; Tue, 16 Jul 2019 18:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbfGPSsP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 14:48:15 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44237 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPSsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 14:48:15 -0400
Received: by mail-yw1-f68.google.com with SMTP id l79so9342692ywe.11
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3Nj7ywVqIgMXKie2FINECyL580Bk6qtYnYGwP4sPF0=;
        b=XFKpfRKaD8CZ2WngjA5Ff/Lr/5fFdS5xmhT2GijRBCH+smflp1TUUJwxYXKO8AyWXh
         lJD8oRcIJBwKrhOiLg/4/kvEybZ0dVzseW/IiJ/BmMckkxxWfDQJ0ume1cE85CQydfer
         bvDafGRoaqez55PKbMOvin+i7RnQEZ+xX5HWuGmrN+s0oFk/2ME9ZxQX4Hq4v+8Q2oYL
         ijviUYdTDhjDUr72Vltm0d9XbdEp/ItzQ41+pIxX5SGa9kN9bMLu7dj5iJDXxqKIVMGl
         P4tOBZjw/o8vbuZbtld4bp35ckmmDhnzKxmDToT8RKVneJabuoldBWShnnImRn+WCEey
         WA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3Nj7ywVqIgMXKie2FINECyL580Bk6qtYnYGwP4sPF0=;
        b=GHxb8otikaFWJ0rx08KczaQ69Qv/lSRuIBkAuZ7/6ecy3ptx/J6aSF5uA0jHbJWok+
         9vR/YLM1vlC7YaaUneXeb6TzuMeKrS4W1DhBfPlRfWXom1TgyS6GugaUwVnWrzxtQONH
         LM1nYuDyqm4j98vpmX/JJjWWoAJ9l2OCS5GW/I+SM/ZwMTCgfA3puEau1KOuo0Cd32wm
         62Td+KW2CN7vjIEcXoOXX1OleunNFUTOrkocQUjG76PJxFJeOqNe/YSFceeGv0ukENxC
         RUJD6sqjOQSQLCuSpUJRtwcFNzLiIVfYZCVGm7b/suwQyYM1XYONYva2114GVJWhabKe
         c5OQ==
X-Gm-Message-State: APjAAAVpg91Nf3gsPBi4cs+C1IDbWwuJk66hhRHLpYGg2++FJ2/DnT/1
        ZtR5JrO3geK4zmXBXIRsXi5drLJmPEK6iKBHD6A5aw==
X-Google-Smtp-Source: APXvYqw8BVGwFjspPVA/GgSfd+2OtTYnFQ+OQmz1SR2hiBpkPFuOaR9l91eS36tYFFpJ3wra36MLeMHuQUtaoc6XSvE=
X-Received: by 2002:a0d:c301:: with SMTP id f1mr19641828ywd.494.1563302894146;
 Tue, 16 Jul 2019 11:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGP0GoYviFHhFzhqEimEw+ebd=DJx9JucG4BNvSvPuDudoWxw@mail.gmail.com>
 <xmqqsgr53kov.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgr53kov.fsf@gitster-ct.c.googlers.com>
From:   Steven Roberts <fenderq@gmail.com>
Date:   Tue, 16 Jul 2019 11:47:37 -0700
Message-ID: <CAOGP0Gp6zUVeBZjMaCuoHcoHhGJZyC1T1SFNtZSDTL1rXA8eCw@mail.gmail.com>
Subject: Re: git segfault in tag verify (patch included)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000af0112058dd0d115"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000af0112058dd0d115
Content-Type: text/plain; charset="UTF-8"

Thanks. I hope this works ok for you (see attached).

On Tue, Jul 16, 2019 at 11:20 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Steven Roberts <fenderq@gmail.com> writes:
>
> > I believe I have found an off-by-one error in git.
> >
> > Please see https://marc.info/?l=openbsd-ports&m=156326783610123&w=2
>
> That is this thing.
>
>         static void parse_gpg_output(struct signature_check *sigc)
>         {
>                 const char *buf = sigc->gpg_status;
>                 const char *line, *next;
>                 int i, j;
>                 int seen_exclusive_status = 0;
>
>                 /* Iterate over all lines */
>                 for (line = buf; *line; line = strchrnul(line+1, '\n')) {
>                         while (*line == '\n')
>                                 line++;
>                         /* Skip lines that don't start with GNUPG status */
>                         if (!skip_prefix(line, "[GNUPG:] ", &line))
>                                 continue;
>
> If the GPG output ends with a trailing blank line, we skip and get
> to the terminating NUL, then find that it does not begin with
> the "[GNUPG:] " prefix, and hit the continue.  We try to scan and
> look for LF (or stop at the end of the string) for the next round,
> starting at one past where we are, which is already the terminating
> NUL.  Ouch.
>
> Good finding.
>
> We need your sign-off (see Documentation/SubmittingPatches).
>
> Thanks.
>
>
> -- >8 --
> From: Steven Roberts <fenderq@gmail.com>
> Subject: gpg-interface: do not scan past the end of buffer
>
> If the GPG output ends with trailing blank lines, after skipping
> them over inside the loop to find the terminating NUL at the end,
> the loop ends up looking for the next line, starting past the end.
>
> ---
>  gpg-interface.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 8ed274533f..eb55d46ea4 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -116,6 +116,9 @@ static void parse_gpg_output(struct signature_check *sigc)
>         for (line = buf; *line; line = strchrnul(line+1, '\n')) {
>                 while (*line == '\n')
>                         line++;
> +               if (!*line)
> +                       break;
> +
>                 /* Skip lines that don't start with GNUPG status */
>                 if (!skip_prefix(line, "[GNUPG:] ", &line))
>                         continue;
>


-- 
Steven Roberts | https://www.fenderq.com/

--000000000000af0112058dd0d115
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-gpg-interface-do-not-scan-past-the-end-of-buffer.patch"
Content-Disposition: attachment; 
	filename="0001-gpg-interface-do-not-scan-past-the-end-of-buffer.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jy664d8u0>
X-Attachment-Id: f_jy664d8u0

RnJvbSBkNDg4MTQyNzNhNTBjZjBiMjkzMTQ4Y2M0MGE2YTVjYzdjMTM2ODZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZW4gUm9iZXJ0cyA8c3JvYmVydHNAZmVuZGVycS5jb20+
CkRhdGU6IFR1ZSwgMTYgSnVsIDIwMTkgMTE6NDA6NDYgLTA3MDAKU3ViamVjdDogW1BBVENIXSBn
cGctaW50ZXJmYWNlOiBkbyBub3Qgc2NhbiBwYXN0IHRoZSBlbmQgb2YgYnVmZmVyCgpTaWduZWQt
b2ZmLWJ5OiBTdGV2ZW4gUm9iZXJ0cyA8c3JvYmVydHNAZmVuZGVycS5jb20+Ci0tLQogZ3BnLWlu
dGVyZmFjZS5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2dwZy1pbnRlcmZhY2UuYyBiL2dwZy1pbnRlcmZhY2UuYwppbmRleCA4ZWQyNzQ1
MzNmLi43NzU0NzUxMzFkIDEwMDY0NAotLS0gYS9ncGctaW50ZXJmYWNlLmMKKysrIGIvZ3BnLWlu
dGVyZmFjZS5jCkBAIC0xMTYsNiArMTE2LDExIEBAIHN0YXRpYyB2b2lkIHBhcnNlX2dwZ19vdXRw
dXQoc3RydWN0IHNpZ25hdHVyZV9jaGVjayAqc2lnYykKIAlmb3IgKGxpbmUgPSBidWY7ICpsaW5l
OyBsaW5lID0gc3RyY2hybnVsKGxpbmUrMSwgJ1xuJykpIHsKIAkJd2hpbGUgKCpsaW5lID09ICdc
bicpCiAJCQlsaW5lKys7CisKKwkJLyogQnJlYWsgb3V0IG9mIHRyYWlsaW5nICdcbicgKi8KKwkJ
aWYgKCEqbGluZSkKKwkJCWJyZWFrOworCiAJCS8qIFNraXAgbGluZXMgdGhhdCBkb24ndCBzdGFy
dCB3aXRoIEdOVVBHIHN0YXR1cyAqLwogCQlpZiAoIXNraXBfcHJlZml4KGxpbmUsICJbR05VUEc6
XSAiLCAmbGluZSkpCiAJCQljb250aW51ZTsKLS0gCjIuMjEuMAoK
--000000000000af0112058dd0d115--
