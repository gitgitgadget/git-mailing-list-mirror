Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E98F1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeHXBAc (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 21:00:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38850 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeHXBAc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 21:00:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so5778296wrc.5
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=y2fexUy5s++5Qr9UZBptlkpa/yljp0tb6hf2zgkOwCk=;
        b=GG9nhNkky6vkMYAaRgoR6jUV+w9kRcPTVy8wkBcQPWjHw8TBnkX52R7q9w1glIk6pz
         hm983NWYes69h6hz/doZJad6I3cEGtznblyFKAtPXiH3XW2XV4Y1rTa23L/UWJYgZiI0
         N89U94RM2DJgPvxgGigDPl75VzgwmNJ0y+9R6toELFRifpblafOr2zgyt1nVxnfpa9RG
         q8zCmvb5hy80SrGbBtiDfa0jEfFjesxn0wBUsiGDn0vNfc4anUe+2gNZ+Bq0Yc5+BBBH
         yEB/iOnfNMLu/5VKZgMRk9spZI9+M81LLiJftWUsnz6yd8CwS2agBgoF7elmWVlljjrG
         KUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=y2fexUy5s++5Qr9UZBptlkpa/yljp0tb6hf2zgkOwCk=;
        b=BZQEZwe9NKzUI5K9GkL/1AhmIihT2r3v879IgzjW6KnienSM3Jc2d920fvFfxEZAo+
         TRjZ5EJqcytrmbkE+FGUDZF2YkNiEWHqgXx7ZsrdTfqCI9xaQdJSgcOXAjEocKr/RoOG
         bRQmbOpYokXvoPJ5Z38jb1sYlqHnsaDgMzPUDH3L5vjBIIKp3Xc7bn9a3enlZ+pigHVO
         88gEfwBuAI38+ZcCG1H9bGkwA1fY7iSO7iJY2sHhwv9DUosxCyz+zHSFGPcwJWFOUTMF
         BjjkrQlPnxBTfDFABgUkm3Ldn4uQMJoUkCq/SwVFSXn3e+KRwp4yMnDZb2/r0/DMH0W7
         f0yQ==
X-Gm-Message-State: APzg51A0OOlfxLR4PJ8reU8bWG4HPVTVOmbwsSwFTFWmB+fymagtkSSU
        GLi2QDI60eJ53aT6smq5ddw=
X-Google-Smtp-Source: ANB0VdYRdBH4069gprelDsKg0Un0bfSlXpmE31J0eNK/Xi8cDwgDkPQMP5gXR7buxclfVwUkmM1I4A==
X-Received: by 2002:adf:f648:: with SMTP id x8-v6mr10681047wrp.144.1535059736519;
        Thu, 23 Aug 2018 14:28:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 72-v6sm7182604wrb.48.2018.08.23.14.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 14:28:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] i18n: fix mistakes in translated strings
References: <20180823210056.27489-1-jn.avila@free.fr>
Date:   Thu, 23 Aug 2018 14:28:55 -0700
In-Reply-To: <20180823210056.27489-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Thu, 23 Aug 2018 23:00:56 +0200")
Message-ID: <xmqqwosghiw8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël Avila <jn.avila@free.fr> writes:

> -			die(_("run_command returned non-zero status while"
> +			die(_("run_command returned non-zero status while "
>  				"recursing in the nested submodules of %s\n."),

Obviously good.

> diff --git a/config.c b/config.c
> index 9a0b10d4bc..3461993f0a 100644
> --- a/config.c
> +++ b/config.c
> @@ -124,7 +124,7 @@ static const char include_depth_advice[] = N_(
>  "	%s\n"
>  "from\n"
>  "	%s\n"
> -"Do you have circular includes?");
> +"This might be due to circular includes.");

OK.

> diff --git a/sequencer.c b/sequencer.c
> index 65d371c746..84bf598c3e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -720,7 +720,7 @@ static const char *read_author_ident(struct strbuf *buf)
>  	/* dequote values and construct ident line in-place */
>  	for (in = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
>  		if (!skip_prefix(in, keys[i], (const char **)&in)) {
> -			warning(_("could not parse '%s' (looking for '%s'"),
> +			warning(_("could not parse '%s' (looking for '%s')"),

Good.  Thanks.
