Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0601A20954
	for <e@80x24.org>; Wed, 22 Nov 2017 18:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdKVSCp (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 13:02:45 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:32994 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdKVSCo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 13:02:44 -0500
Received: by mail-io0-f193.google.com with SMTP id i184so16681012ioa.0
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EM+98tg3njP4CH+J/qhBr3VqaVKo4/WqGWubgo87/AU=;
        b=oyrkHBk8W/7tbsfHAldG6xrrllqPBj4tZt4Gr9C6XOhcRfX1N/F3RlJUFT12jEglkF
         qSQdY4VJVmzlU66K79kNyAtAuhQr0MqL6smZGhARQG0cE16/Pco5g6BiCTj6vlLvxHrF
         rXgxGUmwCXP3aI2bL2HKteLi0dIdeKzBrtyTVFc7q9rlIHxUOke+nfbkXDtPoxsNuNsy
         VaTK6jtMEgPlTlwngz/gSd++2L0/WNSP2C5mI0dESiZ/ddVOjCVp1SAXvvZ5jcVONyRd
         3a9NcImwNn1IEsgPhUWJ7ZL4ZoqqrbeAVSS7/lz+L+jWt8UzEJEK32vmAlmiOo0xagwL
         B+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EM+98tg3njP4CH+J/qhBr3VqaVKo4/WqGWubgo87/AU=;
        b=ckc9WC5mZgZfVKW0BiIkmuXfBFI1Hu6tCoT15c6uQ+AV9rUrVBofZdBRM0DTGjL4fv
         2MTtQpzBeIVHdABbWzp2EFWMKjGLV/jxVTmaMoeMULgoX2u3fUJAXZwAri4orYByrLiA
         6lRIgMtI6TJFbEB0SQUVDgxuHzBiXiyRcPWeXAXI66dtWlvQyp701v5hIVxXPfaO3BpH
         61q8GGxx1w6yRWQBib/DFCoriRkwBxxK4FgnW/TiZuY31DQ2EfosLt2KUKyrP4Jpe/cG
         T5gNAWBu99IeHtype9aF411edfK/3haWt2froUD40OSiG9BB6y0HXLK/jfoX0cIzpIM8
         8org==
X-Gm-Message-State: AJaThX6adZV21BOQT9QgHCSWIDJTH1RtEGiMCN1szi+xv7vWC9yxZWkB
        2fCpAJPyMeM9DAt0evdWmlQ=
X-Google-Smtp-Source: AGs4zMbTgInw158bf9mqcniZkweU4IWsb6D4BnMg9N+9wmK7bOK5m1Ev/3bqUKSIzHv5TNz1+AmJVQ==
X-Received: by 10.107.201.78 with SMTP id z75mr24390380iof.123.1511373763608;
        Wed, 22 Nov 2017 10:02:43 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 16sm2280229itw.38.2017.11.22.10.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 10:02:43 -0800 (PST)
Date:   Wed, 22 Nov 2017 10:02:36 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Louis Bettens <louis@bettens.info>
Cc:     git@vger.kernel.org, jn.avila@free.fr, worldhello.net@gmail.com,
        Nicolas Cornu <nicolac76@yahoo.fr>
Subject: Re: [PATCH][l10n-fr] list translated to prune in command
Message-ID: <20171122180236.GA11671@aiede.mtv.corp.google.com>
References: <20171122172440.15106-1-louis@bettens.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122172440.15106-1-louis@bettens.info>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Louis Bettens wrote:

> "$ git worktree" when in a french locale shows an incorrect usage
> summary.  This comes down to this trivial issue in the i18n.

Good catch.  This comes from v2.7.0-rc3~4^2~7^2~2^2 (l10n: fr v2.7.0
round 1 (2477t), 2015-12-18).

For next time, you can send these three emails in a single email:

	Subject: l10n: fr.po: "worktree list" mistranslated as prune

	"$ git worktree" when in a french locale shows an incorrect usage
	summary.  This comes down to this trivial issue in the i18n.

	Signed-off-by: ...
	---
	Also it seems this is the only .po that has this particular quirk:

	$ grep -c "worktree prune" po/*.po
	po/bg.po:2
	po/ca.po:2
	po/de.po:2
	po/es.po:2
	po/fr.po:3  # outlier
	po/is.po:0
	po/it.po:0
	po/ko.po:2
	po/pt_PT.po:2
	po/ru.po:2
	po/sv.po:2
	po/vi.po:2
	po/zh_CN.po:2

	zero lines -> translation missing, OK
	two lines -> msgid and msgstr, OK
	three lines -> something wrong. In this case, the present issue.

	 po/fr.po | 2 +-
	 1 file changed, 1 insertion(+), 1 deletion(-)

	diff --git a/po/fr.po b/po/fr.po
	index 4deae3318..a12a2ae37 100644
	--- a/po/fr.po
	+++ b/po/fr.po
[...]

That way, Jean-Noel Avila or Jiang Xin can apply the patch with a
single "git am" command and the explanation (above the "---" line)
shows up in "git log".

I assume they can handle this one fine as-is.  Just pointing it out
for the future.

See the DISCUSSION section in "git help format-patch" for more details.

Thanks,
Jonathan
