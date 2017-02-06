Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77BA1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 18:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbdBFSx6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 13:53:58 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35108 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdBFSx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 13:53:57 -0500
Received: by mail-pg0-f68.google.com with SMTP id 204so9773538pge.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 10:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BkUWWHx9NQ5C+nuSgdV/8YCSMVvs0qchSl9+sS8zJW4=;
        b=McSeLs1G7osHr6m0gwcXlHUl+q1tzoAyyNeP6l1zP3PLREuEC2TuMuiigCs7GHO9bb
         3C707TuIUMV7yTETJ+VS5eb2M/0rQhq1fwi4qLllPBWW7QIQ+1vpiYs6Eo0iZd6v3vlD
         r364CaTB0c4+F1+R4VWfd9gees3bE4DuWMpVhuOhAoSozNZA1408X5mJ61lUbUyfnRZg
         rl+/TqYnsh198hbVwgJIfh9Gk3XsnYthtCvMTNga/5p3xbUJJ4xBK1iB2oKrLPxNOY03
         9r7KHUnFHF2VmJiNbOoEt73BTN3YsOgSPFd67spO4IXSazemqdKppoLXkq9SgQHmj795
         epyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BkUWWHx9NQ5C+nuSgdV/8YCSMVvs0qchSl9+sS8zJW4=;
        b=MgH7nxSgC9e+8ELc58gOXfioq7ff5A8WyeXR2WwqnZmYxDlteYS6JmJbAc40l7+wXU
         yMZeeI2dVYpyKS+UvXx6fVj64gZFPsHp1PNc8IJxZwqtbVo3P5NADS8e6uiUJVKIio5k
         S2aWEY3ko0fgRsuFqkq7cM6+QhNn5qf6lUSt77LYDQNGBi54kBK+kjKrsWeBKnJTI7i7
         qPvQ8B3vkdB9c/CmQYUcnuoZP1jNrti55xK0LpwpRFLTpq/tvtwLrSvq1J8qbxcytdZk
         aO6Evc4jp/eX7W1b01CM4aw/7AOQPtqJ6y67/qP0OxYxVb4SdE2DCiclSySi23uiXJHi
         YSOw==
X-Gm-Message-State: AIkVDXKEXmhIrOP0DgP5GINtRrOKoHi9h30+UfwIreB/Tk/yU98zl9OghSepu4Mqc39zCQ==
X-Received: by 10.84.254.15 with SMTP id b15mr19662561plm.114.1486407231496;
        Mon, 06 Feb 2017 10:53:51 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id b7sm4500366pfg.53.2017.02.06.10.53.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 10:53:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, davvid@gmail.com
Subject: Re: [PATCH] Document the --no-gui option in difftool
References: <20170206034118.GA29517@arch-attack.localdomain>
Date:   Mon, 06 Feb 2017 10:53:50 -0800
In-Reply-To: <20170206034118.GA29517@arch-attack.localdomain> (Denton Liu's
        message of "Sun, 5 Feb 2017 19:41:18 -0800")
Message-ID: <xmqqa89z2ls1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index 224fb3090..a2661d9cc 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -87,9 +87,11 @@ instead.  `--no-symlinks` is the default on Windows.
>  
>  -g::
>  --gui::
> +--no-gui::
>  	When 'git-difftool' is invoked with the `-g` or `--gui` option
>  	the default diff tool will be read from the configured
> -	`diff.guitool` variable instead of `diff.tool`.
> +	`diff.guitool` variable instead of `diff.tool`. The `--no-gui`
> +	option can be used to override this setting.
>  
>  --[no-]trust-exit-code::
>  	'git-difftool' invokes a diff tool individually on each file.

Reading the whole of this file before applying this patch, I notice
that we have descriptions of negative forms only for some but not
all options. "--[no-]symlinks" and "--[no-]trust-exit-code" are
already there, but not this one.  

Shouldn't the patch be more like

    ---gui::
    +--[no-]gui::

to be consistent with its existing friends, though?

