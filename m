Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60311F404
	for <e@80x24.org>; Tue, 10 Apr 2018 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeDJPAX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 11:00:23 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:40237 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbeDJPAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 11:00:22 -0400
Received: by mail-oi0-f44.google.com with SMTP id x9-v6so11434465oig.7
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iIoFTS381kPjmFniaJBsIlQzy9VV65XehHmtjJbmUj4=;
        b=Nz3rFWBY857HaCkaFXtacgtfHjX/XSYN6Q6ovcJvQPWwbJNmj9FvIdHboctLoA3nvx
         67rSi1bIfiwA8b+DPwrBTyoCs4+5OTCAbcFoyHudZlMvVbFZsTamxklMfGAZs4INWCDh
         8oEWASZqbdQpuTFQpAgVQRhMRnqCgDg/pAf+jJdrQZ9evP/rImPiHoB0hW91QlrzPEQE
         MGu1H8bGLbLW50OwgkUtTWXlg6EedsLycaKUMmbqQ3o1FeX9vCVaK1kgnSfmYeYKO6XN
         SS7enc14EVIi7siqpcSaqv/GmThUTAc1VYcxt37gLuVNmSODTnblo+AOtfpmSdZM6NaH
         boAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iIoFTS381kPjmFniaJBsIlQzy9VV65XehHmtjJbmUj4=;
        b=G6HQc4Hh4AOQ0K/PohGlo8+70upFTRq+k8LQ2fIcuK6srcABDcWfxz5aGo8ugdcm3S
         8yGYaudPfBEfsyTaCLjnwzZodfPuCH5EUhBOn1ByJ4MTxO0KXDfRyRkYKQgdEtq3EBHJ
         7TRo5YFcnJFbY06GZ6ql3W5iP+jh1uDQhQGyTrhcCmnJ44HFWi5r7M9f+QCnLjTnl5vS
         AS9a2Fc/uk7Gs7nARr7TXOic8byO6WdXoRwPEAMnTEHMM+PQdmGcEhjnfW0G3ad9WMAZ
         eXcK0mtqk9C+9nihgO9EINCk2iX9DsXibpsdlugJAf0fZC3sQxWSLTyERMsWF4/MkPlO
         qWkw==
X-Gm-Message-State: ALQs6tDUINKrk27lBwvg2p9MGbCGbMhhXpvnSokRLG/kCBcrr9mVHHwm
        RIRRY69hUANxdtWoOPgLd487ZnfFvLpmAeywAMg=
X-Google-Smtp-Source: AIpwx4+h110vjm0W/gyhu4CBq1AI+NVC5WnJ+I/D/b9M8l+7JCo2qBiuuQ3uHwON6gN1HzaKRiYLrNm369+f2ncN0JI=
X-Received: by 2002:aca:801:: with SMTP id 1-v6mr538727oii.152.1523372421089;
 Tue, 10 Apr 2018 08:00:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.56.25 with HTTP; Tue, 10 Apr 2018 08:00:00 -0700 (PDT)
In-Reply-To: <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
From:   Ben Toews <mastahyeti@gmail.com>
Date:   Tue, 10 Apr 2018 09:00:00 -0600
Message-ID: <CAE=pOyGnLBTJ7goduOu-bqTuqLxvwECVgaVGzFZRCx3RcuAWcQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 2:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 9, 2018 at 4:41 PM, Ben Toews <mastahyeti@gmail.com> wrote:
>> [...]
>> This patch introduces a set of configuration options for
>> defining a "signing tool", of which gpg may be just one.
>> With this patch you can:
>>
>>   - define a new tool "foo" with signingtool.foo.program
>>
>>   - map PEM strings to it for verification using
>>     signingtool.foo.pemtype
>>
>>   - set it as your default tool for creating signatures
>>     using using signingtool.default
>
> s/using using/using/
>
>> This subsumes the existing gpg config, as we have baked-in
>> config for signingtool.gpg that works just like the current
>> hard-coded behavior. And setting gpg.program becomes an
>> alias for signingtool.gpg.program.
>>
>> This is enough to plug in gpgsm like:
>>
>>   [signingtool "gpgsm"]
>>   program = gpgsm
>>   pemtype = "SIGNED MESSAGE"
>
> How confident are we that _all_ possible signing programs will conform
> to the "-----BEGIN %s-----" pattern? If we're not confident, then
> perhaps the user should be providing the full string here, not just
> the '%s' part?

These changes are only intended to work with PEM encoded signatures.
The new config format leaves room for working with other signature
formats in the future, though this would require further code changes.
Requiring the user to specify the whole PEM start/end markers in the
config doesn't make sense to me, since it assumes that non-PEM
encodings would have similarly simple start/end delimiters.

>
> Further, I can infer from PGP itself, as well as from reading the code
> that the 'pemtype' key can be specified multiple times; it would be
> nice to mention that in the commit message.
>
>> [...]
>> The implementation is still in gpg-interface.c, and most of
>> the code internally refers to this as "gpg". I've left it
>> this way to keep the diff sane, and to make it clear that
>> we're not breaking anything gpg-related. This is probably OK
>> for now, as our tools must be gpg-like anyway. But renaming
>> everything would be an obvious next-step refactoring if we
>> want to offer support for more exotic tools (e.g., people
>> have asked before on the list about using OpenBSD signify).
>
> I can't decide if this paragraph belongs in the commit message proper
> (as it currently is) or if it is commentary which should be placed
> below the "---" line just above the diffstat. It feels more like
> commentary, but not a big deal, and not itself worth a re-roll.
>
>> ---
>>  Documentation/config.txt |  40 +++++++++---
>>  builtin/fmt-merge-msg.c  |   6 +-
>>  builtin/receive-pack.c   |   7 +-
>>  builtin/tag.c            |   2 +-
>>  commit.c                 |   2 +-
>>  gpg-interface.c          | 165 ++++++++++++++++++++++++++++++++++++++++++-----
>>  gpg-interface.h          |  24 ++++++-
>>  log-tree.c               |   7 +-
>>  ref-filter.c             |   2 +-
>>  t/lib-gpg.sh             |  26 ++++++++
>>  t/t7510-signed-commit.sh |  32 ++++++++-
>>  tag.c                    |   2 +-
>>  12 files changed, 272 insertions(+), 43 deletions(-)
>
> Due to its length, this patch is painfully time-consuming to review,
> and asks reviewers to keep track of too many details at one time. As a
> consequence, it's likely to scare away potential reviewers and limit
> the quality of those reviews it does receive. If you break the changes
> down into a series of much smaller patches which hold the hands of
> reviewers, then you are likely to attract more and better reviews.
> Please consider doing so.
>
> Each patch should be reasonably small and easy to digest. Each patch
> should build logically upon the patch or patches preceding it, thus
> incrementally building up a picture of the complete change. A (very)
> rough idea of a series of smaller patches corresponding to this
> feature might be:
>
> 1. introduce 'struct signing_tool' and the bare machinery for managing them
>
> 2. convert PGP from a hard-coded signer to a 'signing_tool' signer
>
> 3. add support for the new configuration variables
>
> It's likely that these steps can be broken into even smaller, more
> reviewer-friendly ones; exactly how to do so may become apparent as
> you think about how the patch series should be structured. For
> instance, perhaps step 3 could be divided into:
>
> 3.1. add support for "signingtool.foo" variables
> 3.2. retrofit "gpg.program" to be alias of "signingtool.gpg.program"
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> @@ -1727,16 +1727,38 @@ grep.fallbackToNoIndex::
>> -gpg.program::
>> -       Use this custom program instead of "`gpg`" found on `$PATH` when
>> -       making or verifying a PGP signature. The program must support the
>> -       same command-line interface as GPG, namely, to verify a detached
>> -       signature, "`gpg --verify $file - <$signature`" is run, and the
>> -       program is expected to signal a good signature by exiting with
>> -       code 0, and to generate an ASCII-armored detached signature, the
>> -       standard input of "`gpg -bsau $key`" is fed with the contents to be
>> +signingtool.<name>.program::
>> +       The name of the program on `$PATH` to execute when making or
>
> Why does the program need to be on $PATH? That seems like an
> unnecessarily harsh limitation, one which wasn't shared by
> gpg.program. (Reading the code, it looks like 'program' does not in
> fact need to be on $PATH, so this documentation is wrong.)
>

Yep. It looks like this inaccuracy was carried over from the existing docs.

>> +       verifying a signature. This program will be used for making
>> +       signatures if `<name>` is configured as `signingtool.default`.
>> +       This program will be used for verifying signatures whose PEM
>> +       block type matches `signingtool.<name>.pemtype` (see below). The
>> +       program must support the same command-line interface as GPG.
>> [...]
>> +signingtool.<name>.pemtype::
>> +       The PEM block type associated with the signing tool named
>> +       `<name>`. For example, the block type of a GPG signature
>> +       starting with `-----BEGIN PGP SIGNATURE-----` is `PGP
>> +       SIGNATURE`. When verifying a signature with this PEM block type
>> +       the program specified in `signingtool.<name>.program` will be
>> +       used. By default `signingtool.gpg.pemtype` contains `PGP
>> +       SIGNATURE` and `PGP MESSAGE`.
>
> Although it's somewhat inferred for the PGP case, the documentation
> really needs to state explicitly that multiple 'pemtype's can be
> specified, and it needs to explain how to do so. Reading the code, I
> see that one does so by specifying 'pemtype' key multiple times, but
> the documentation should say this.
>
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> @@ -143,12 +216,43 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>>         if (!strcmp(var, "gpg.program")) {
>> +               struct signing_tool *tool = get_or_create_signing_tool("gpg");
>
> Not at all worth a re-roll, but the get_or_create_signing_tool()
> invocation could be moved below the "if (!value)" conditional. (The
> declaration of 'tool', of course, would remain here.)
>
>>                 if (!value)
>>                         return config_error_nonbool(var);
>> -               gpg_program = xstrdup(value);
>> +
>> +               free(tool->program);
>> +               tool->program = xstrdup(value);
>>                 return 0;
>>         }
>> @@ -200,15 +306,42 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>>  int verify_signed_buffer(const char *payload, size_t payload_size,
>>                          const char *signature, size_t signature_size,
>> -                        struct strbuf *gpg_output, struct strbuf *gpg_status)
>> +                        struct strbuf *gpg_output, struct strbuf *gpg_status,
>> +                        const struct signing_tool *tool)
>>  {
>>         [...]
>> +       if (!tool) {
>> +               parse_signature(signature, signature_size, &tool);
>> +               if (!tool) {
>> +                       /*
>> +                        * The caller didn't tell us which tool to use, and we
>> +                        * didn't recognize the format. Historically we've fed
>> +                        * these cases to blindly to gpg, so let's continue to
>
> s/to blindly/blindly/
>
>> +                        * do so.
>> +                        */
>> +                       tool = get_signing_tool("gpg");
>> +               }
>> +       }
>> diff --git a/gpg-interface.h b/gpg-interface.h
>> @@ -48,10 +60,16 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
>>   * Run "gpg" to see if the payload matches the detached signature.
>>   * gpg_output, when set, receives the diagnostic output from GPG.
>>   * gpg_status, when set, receives the status output from GPG.
>> + *
>> + * Typically the "tool" argument should come from a previous call to
>
> s/Typically/&,/
>
>> + * parse_signature(). If it's NULL, then verify_signed_buffer() will
>> + * try to choose the appropriate tool based on the contents of the
>> + * "signature" buffer.
>>   */
>> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>> @@ -56,3 +56,29 @@ sanitize_pgp() {
>> +create_fake_signer () {
>> +       write_script fake-signer <<-\EOF
>> +       if [ "$1 $2" = "--status-fd=2 -bsau" ]; then
>
> Style: This codebase uses 'test' rather than '['. Also, 'then' is
> placed on its own line and the semicolon omitted.
>
>> +               echo >&2 "[GNUPG:] BEGIN_SIGNING"
>> +               echo >&2 "[GNUPG:] SIG_CREATED D 1 SHA256 0 1513792449 4A7FF9E2330D22B19213A4E9E9C423BE17EFEE70"
>> +               # avoid "-" in echo arguments
>> +               printf "%s\n" \
>> +                 "-----BEGIN FAKE SIGNER SIGNATURE-----" \
>> +                 "fake-signature" \
>> +                 "-----END FAKE SIGNER SIGNATURE-----"
>
> If you use 'cat' with a here-doc, then you don't need the comment
> about avoiding "-".
>
>     cat <<-\END
>     -----BEGIN FAKE SIGNER SIGNATURE-----
>     fake-signature
>     -----END FAKE SIGNER SIGNATURE-----
>    END
>
>> +               exit 0
>> +
>> +       elif [ "$1 $2 $3" = "--status-fd=1 --keyid-format=long --verify" ]; then
>> +               echo "[GNUPG:] NEWSIG"
>> +               echo "[GNUPG:] GOODSIG 4A7FF9E2330D22B19213A4E9E9C423BE17EFEE70 /CN=Some User/EMail=some@user.email"
>> +               echo "[GNUPG:] TRUST_FULLY 0 shell"
>
> Another good place to use 'cat' with here-doc.
>
>> +               echo >&2 "Good signature from /CN=Some User/EMail=some@user.email"
>> +               exit 0
>> +
>> +       else
>> +               echo "bad arguments" 1>&2
>> +               exit 1
>> +       fi
>> +       EOF
>> +}
>> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
>> @@ -51,13 +55,33 @@ test_expect_success GPG 'create signed commits' '
>> +       git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree}) &&
>> +
>> +       git config signingtool.fake.program "$TRASH_DIRECTORY/fake-signer" &&
>> +       git config signingtool.fake.pemtype "FAKE SIGNER SIGNATURE" &&
>> +       echo 11 >file && test_tick && git commit -a -m eleventh &&
>
> It's normally frowned upon in tests to string together a bunch of
> &&-chained commands on a single line, but since this script is already
> full of this stylized 'commit' invocation, it may be okay. However...
>
>> +       git tag eleventh-pgp-signed &&
>> +       git cat-file -p eleventh-pgp-signed >actual &&
>> +       grep "PGP SIGNATURE" actual &&
>> +
>> +       git config gpg.program "$TRASH_DIRECTORY/fake-signer" &&
>> +       echo 12 >file && test_tick && git commit -a -m twelfth && test_unconfig gpg.program &&
>
> Place the test_unconfig() on its own line so it can be clearly seen by
> someone scanning an eye over the test; otherwise, the test_unconfig()
> is easily overlooked, with the result that the reader may get a false
> impression of what's going on.
>
>> +       git tag twelfth-fake-signed &&
>> +       git cat-file -p twelfth-fake-signed >actual &&
>> +       grep "FAKE SIGNER SIGNATURE" actual &&
>> +
>> +       git config signingtool.default fake &&
>> +       echo 13 >file && test_tick && git commit -a -m thirteenth && test_unconfig signingtool.default &&
>
> Ditto.
>
>> +       git tag thirteenth-fake-signed &&
>> +       git cat-file -p thirteenth-fake-signed >actual &&
>> +       grep "FAKE SIGNER SIGNATURE" actual
>>  '



-- 
-Ben Toews
