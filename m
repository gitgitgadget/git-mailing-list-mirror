Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A404E1FF30
	for <e@80x24.org>; Wed, 24 May 2017 14:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764758AbdEXObJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 10:31:09 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33828 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdEXObI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 10:31:08 -0400
Received: by mail-vk0-f47.google.com with SMTP id y190so76485342vkc.1
        for <git@vger.kernel.org>; Wed, 24 May 2017 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=2a1lhxvaz4pOCoFLGjhlkh3JlXo6YA5XSb7kzgp+yrk=;
        b=I1jnM+QuAyEetv2vGC2jd8EUVFgoPr0CQr1JTkmgY5PburEHs8SjXGuzVCLhK9IdCY
         QA5BOGFuZG8vODFC3Se6hjDx0U9BrlsvrFvmQYQlxJV4GE85QvI2u9UEn0Pjsk1yJnQn
         TctCYPGuI3Pdwb7HySw/vPSJZR7xxIJ2KDDb7dGYET1HRfAhIqQIQak5Wff7swxq9y6U
         xYuwXjknW4GOJiVTR37xK3C/Q/JOl32VL3fqwIw299DkG9Fa6gXOrYHC2Fxn2NcbP6xC
         BOehBHFp/9K1ixng7hgC6LniGLkTjickqsJaGFoHhhoUfwF09k7kUWbDZ7jbMecutwhP
         jBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=2a1lhxvaz4pOCoFLGjhlkh3JlXo6YA5XSb7kzgp+yrk=;
        b=aBCS5hu7SfyEhqSEG3HL0KbawDNSXYAygz2HzbwR1UqHSnqphUxrzHakS751uvZH3O
         6G6Jbd3FbA2YjYZZSkVRuwcXd9FN4e1AzzkIKwrRewzzxS1C5UtK8A9d07J4KnrGTiyT
         zj8+GkyAmJdEjvo3UHlSSq9dO6Kip2DPCxI3L46n44cR5vbuiZUGTHNA6VhKMzCz8YNu
         szLyOX+VxmpC6dGT7eX4sCk60RayICZ4/xK1OjPYFNIInN3MN6342ia2a1dvaFtAwi4s
         etE1S3XaiaJkDQlldAPBFBIaAvf732ttPh07mh7r3mqwAW8U4CYH6PBGwX6/8f6sSVVD
         2WIA==
X-Gm-Message-State: AODbwcCgaLpfAkgB1LWszOSpZKiElD/GbRTYT6qP2aLUrcMdmxx74HHS
        aTniTzFTjZP5oQfOW96k1cXqCAYJHsVZqIA=
X-Received: by 10.31.238.143 with SMTP id m137mr11722703vkh.109.1495636266960;
 Wed, 24 May 2017 07:31:06 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.163 with HTTP; Wed, 24 May 2017 07:31:06 -0700 (PDT)
In-Reply-To: <CAHd499B+cyN=3XDqr7KgHSpyHLwi6bS=P_4beoS5fSkFhapAtw@mail.gmail.com>
References: <CAHd499B+cyN=3XDqr7KgHSpyHLwi6bS=P_4beoS5fSkFhapAtw@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 24 May 2017 09:31:06 -0500
X-Google-Sender-Auth: D_wZ2dA5nMM0dKFsp2AoV5qOQ_o
Message-ID: <CAHd499B83CORzZjRN2EMfHq5xTJgy6kXuCVce41jA_qqg80GGQ@mail.gmail.com>
Subject: Re: Hide decorations in git log
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 9:22 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> Hello,
>
> Is it possible to hide decorated refs in `git log` even if they are
> reachable from the refs I'm actually interested in seeing the logs of?
>
> For example, if I do `git log --graph --decorate --oneline --branches
> 'feature/*'`, I'd like to *only* see refnames that match the glob
> pattern. However, you'll see tags and other branches that do not match
> the glob if they are reachable from the result set.
>
> This is purely a visual thing, and shouldn't impact the search results
> I'd think.
>
> This is especially useful in cases where I do --simplify-by-decoration
> to get a better understanding of the topology of just a couple of
> select branches. Without some sort of "decoration exclusion", I am
> getting ton of results including tags, etc which obfuscates the
> information I'm really interested in.
>
> Thanks in advance.

Here is an even more concrete example:

$ git log --oneline --abbrev-commit --graph --simplify-by-decoration
--branches='hotfix'

I get the following results:

https://i.imgur.com/arHJss8.png

These results are incredibly confusing... I expected to see the first
line of the log results to be a branch matching 'hotfix' at the very
least. Maybe my question is more of a symptom of confusion about a
different problem. In any case, sorry for the confusion and hopefully
someone can clarify for me. I must be missing something basic.
