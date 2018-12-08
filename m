Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4492220A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 00:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeLHAsr (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 19:48:47 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51458 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLHAsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 19:48:47 -0500
Received: by mail-it1-f193.google.com with SMTP id x19so9685119itl.1
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 16:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFsXRS9RfRdMzQkLM5Bq0dK0mzDWc3b1bNXK9y9RQlg=;
        b=kLsQnGpOEHn9fO2Styb7cwP4rYifQ987YXyx3t5vUT2Is3FJ/zLprD7wcPlaXlQ+Ra
         r09oFv3xW8b20k6tt5cKy5xhfxToj6RRtk/+Lt5bGxjJRilIhvZWzu4aWm2Gei3b/MtA
         H0zQJvbn/Sqsu5uVFAyi0VodFVsK2rW8qz4xOyLMnvF6QfG/fhYkCSnBtJ93BnLB/O7T
         yV6g/edR7/Dr8LDO3DjFuS1F0LM7st8uiaOKO4JyriG6a897TXg2oomHUcKF5WC9gOW7
         kzwLrCMa/S3n2Eq7eNVWnrhhg0Fudxj+UyDONyrY0/SMuEAPG5L3Tl8YIxJXjxd3ipDm
         Ve7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFsXRS9RfRdMzQkLM5Bq0dK0mzDWc3b1bNXK9y9RQlg=;
        b=tO4sNN6qoYsEgblEvwgaujDqdx1maqAgPpHlH9Dd4dLrqKSlP3DT7UF5jZQYC2cCjT
         Qp0v3TLcHYWJbGFqxFqXuWrya3flyzkM0QvZh4xlm1C8zhmO25tzH5+dFhO00uRQFwHS
         QJDQlZiLk57oxgmIeF2GNnhgKmJNw3H0o8x2rNr2AQx0u8FR09cpzU7VhszhB1UcCbSG
         D2+K9PiGQ43di7olD7ks+62H45JI+fqH5cEpeilNE5VuSC+wZXCeMrr56vLX+2Kcr/oa
         kc7wYdg3Q65AMnWkO2HXyubffT7j1l/iIbxsqP1+g4rlg4lTN9snnisb85VkEgvXofJh
         zCFg==
X-Gm-Message-State: AA+aEWagf3wDFsr9U2LDiKoUTrFm+M+XZDaV+0Ks1wihpSnTVq+jl7Ro
        jrOyyw1jCkLrwRmG0AJ/jujhcJZ1U4zOKsepoEQ=
X-Google-Smtp-Source: AFSGD/UZbuAiv2uvgQB8TamLxG05NRqmKKpzxOOBJ7jwftS8GNVbXFv+WXFRh3Wn55HglfqnSLHAT4GL80J7QtiXSMc=
X-Received: by 2002:a24:6b58:: with SMTP id v85mr1173395itc.11.1544230126140;
 Fri, 07 Dec 2018 16:48:46 -0800 (PST)
MIME-Version: 1.0
References: <010201678b350faa-868bbac4-9242-427a-9d3b-fc6f00a95270-000000@eu-west-1.amazonses.com>
 <20181208004504.GG73340@google.com>
In-Reply-To: <20181208004504.GG73340@google.com>
From:   FeRD <ferdnyc@gmail.com>
Date:   Fri, 7 Dec 2018 19:48:19 -0500
Message-ID: <CAN1OggV1Xx+LZcwun1CRHtgow7t_w7UWhDOFq3uaY4qM4JCdOQ@mail.gmail.com>
Subject: Re: [PATCH] docs/gitweb.conf: config variable typo
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 7:45 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>
> Thanks for fixing it.  May we forge your sign-off?

Yes please, guess I didn't read far enough down that document. My apologies.
Consider the previous patch email:

Signed-off-by: FeRD (Frank Dana) <ferdnyc@gmail.com>
