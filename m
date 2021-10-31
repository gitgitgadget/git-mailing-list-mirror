Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7AFC433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675DD60F58
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhJaTBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhJaTBd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 15:01:33 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C28C061570
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 11:59:01 -0700 (PDT)
Message-ID: <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635706739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7FiNSphO0A/CTEXBKtcrMbsgxzW+GaHoO6AaZqhK0Q=;
        b=pRNnHW42m1a76iot4yvjK4Wx7O0LMEPM5lu9Xv1BLENgAvA7V1kJbE3ulgpRJBf3XL7uIX
        sH+rFOL88d+bpf+L1eu1WS/TOvKqKMgDIqMx4gSZEpxanY2letCRz+mQDEvTkRVgHv9Zlc
        DM6NPhuO978fWNunhUslFV9B2LUX8IcIZnA3ppFET8/TMx75mlu69VK3LzuqMRfZV3uSxA
        3oJYB7sdLuPxknW2f8iWyaPqfNWNiMdmM++5KXLZBLuK76H9MstMqAHb7sXoQjxggbnUWS
        TI0G7dgfYd4Ii+aeISC/0zFCxS0ZHBduoGvgwIXnQc6E0zqQc9TdLqw1+oL2qMW79M4gvM
        VU2HtVm3iOHxwUL+8SE1a0tgcFdbJzwp641i0GlOeL/DyeWhC0kReakMpd8GuE2QIcbFJM
        icTmKFZg4fnx8clSYVWIyo2TzQIaS7BpY26QH/cZV1DcC8MI1F/BvyDyW/jgKJbtZ6/aic
        /kKd+DuYFHs9cKJpqubeyhvNV9YX5uJ0Bl1O74NM2tSO2kYEo6r2PiyN7JO9eOFlM0eEx+
        BTf07iuXVyZUZ8KkzCEhAUaGq8cE+yvfRKYR4gwvwqGtSM6qhoSciHEXPu0EH6AKrh8o3W
        VuKplVZhCdklylZ0bARBQD3FFx6p4beTa/m6XhvTranc8jkW3I934=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635706739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7FiNSphO0A/CTEXBKtcrMbsgxzW+GaHoO6AaZqhK0Q=;
        b=CtXfmOqWgJsDIn+/0WYWTh0uCJy2Jx0mb6Y4ORgD2hGMcqyUG1YKYKzlhxBO3RY/ArI+uu
        IAjYPJ8CkoiEJiDw==
Date:   Sun, 31 Oct 2021 14:58:56 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
Content-Language: en-US-large
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
 <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/28/21 12:21 PM, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> According to CodingGuidelines, spaces and underscores are not
> allowed in placeholders.


I have a patch under review that touches the same files you are
modifying here. As I've been pointed to these changes, I'd like to make
a quick observation.


> @@ -101,9 +101,9 @@ commits are displayed, but not the way the diff is shown e.g. with
>  `git log --raw`. To get full object names in a raw diff format,
>  use `--no-abbrev`.
>  
> -* 'format:<string>'
> +* 'format:<format-string>'
>  +
> -The 'format:<string>' format allows you to specify which information
> +The 'format:<format-string>' format allows you to specify which information
>  you want to show. It works a little bit like printf format,
>  with the notable exception that you get a newline with '%n'
>  instead of '\n'.
> @@ -273,12 +273,12 @@ endif::git-rev-list[]
>  			  If any option is provided multiple times the
>  			  last occurrence wins.
>  +
> -The boolean options accept an optional value `[=<BOOL>]`. The values
> +The boolean options accept an optional value `[=<value>]`. The values


Here you change "BOOL" to "value", below you change it to "bool-value".


>  `true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
>  sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
>  option is given with no value, it's enabled.
>  +
> -** 'key=<K>': only show trailers with specified key. Matching is done
> +** 'key=<key>': only show trailers with specified <key>. Matching is done
>     case-insensitively and trailing colon is optional. If option is
>     given multiple times trailer lines matching any of the keys are
>     shown. This option automatically enables the `only` option so that
> @@ -286,9 +286,9 @@ option is given with no value, it's enabled.
>     desired it can be disabled with `only=false`.  E.g.,
>     `%(trailers:key=Reviewed-by)` shows trailer lines with key
>     `Reviewed-by`.
> -** 'only[=<BOOL>]': select whether non-trailer lines from the trailer
> +** 'only[=<bool-value>]': select whether non-trailer lines from the trailer
>     block should be included.
> -** 'separator=<SEP>': specify a separator inserted between trailer
> +** 'separator=<sep>': specify a separator inserted between trailer
>     lines. When this option is not given each trailer line is
>     terminated with a line feed character. The string SEP may contain
>     the literal formatting codes described above. To use comma as
> @@ -296,15 +296,15 @@ option is given with no value, it's enabled.
>     next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
>     shows all trailer lines whose key is "Ticket" separated by a comma
>     and a space.
> -** 'unfold[=<BOOL>]': make it behave as if interpret-trailer's `--unfold`
> +** 'unfold[=<bool-value>]': make it behave as if interpret-trailer's `--unfold`
>     option was given. E.g.,
>     `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
> -** 'keyonly[=<BOOL>]': only show the key part of the trailer.
> -** 'valueonly[=<BOOL>]': only show the value part of the trailer.
> -** 'key_value_separator=<SEP>': specify a separator inserted between
> +** 'keyonly[=<bool-value>]': only show the key part of the trailer.
> +** 'valueonly[=<bool-value>]': only show the value part of the trailer.
> +** 'key_value_separator=<sep>': specify a separator inserted between
>     trailer lines. When this option is not given each trailer key-value
>     pair is separated by ": ". Otherwise it shares the same semantics
> -   as 'separator=<SEP>' above.
> +   as 'separator=<sep>' above.
>  
>  NOTE: Some placeholders may depend on other options given to the
>  revision traversal engine. For example, the `%g*` reflog options will


These changes over here are contrary to the statement in the commit
message. In addition to switching to hyphens, they:

- switch casing (okay, makes sense, you point this out in the cover
  letter but maybe it's worth mentioning it in the commit message too?
  idk)

- change the terms used -- and this I don't understand. I'm not really
  bothered by switching <n> to <number> or <k> to <key>, as these
  changes seem reasonable (though again, they are not mentioned in the
  commit message). However, "bool-value" seems odd. Why that and not
  "number-value"? IMHO the "value" is redundant here, let it be "bool"
  and "number".

  Similarly "the 'format:<format-string>' format" feels highly
  redundant, I expect the reader knows that <string> contains a format
  inside it as it's mentioned immediately before *and* after.

-- 
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User
