Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1BE3207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980131AbdDYC5s (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:57:48 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34383 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980113AbdDYC5q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:57:46 -0400
Received: by mail-io0-f196.google.com with SMTP id h41so52288814ioi.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHJKD+1ZnQpslCvBHuE+YLxLsYiAWo+pvI1des9nta4=;
        b=ty7fOrsgUyIhYW9H9Cd3ZObUsIH8EjDx4DjPsnT9T5osV2ZRdm0pBgn9T2wPgrjc/l
         N0aOvsGq677X2gddbXYKm/hpvlqVELtnxlV5C4r4Dqdz9LlETW9dl+gOjnD8VaY8mTAy
         rnjPNAzsjFArKVKW1TBT1ZGL6z6kwWhy3yCRdL0X2GQzzda2NMiyIdocp7yXf+Innbqt
         wJOMcTUVj3uc2ptq1O/GvTlRD88X3aKs1QBiNCyZrd0o4yONWWEiLk6oTl+wf3E+m2gC
         fP869ekEPUF4Mp6UMWxgQh/wCDtBDnfN0k0ZuMcjkqzdYI58cykk4YsWktT+SNeCZoy7
         nWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHJKD+1ZnQpslCvBHuE+YLxLsYiAWo+pvI1des9nta4=;
        b=FT2UHZjIbLQ9gQ2NB+7FgV4pGlasGQrRjMqwDgg2jO/DyarJbHX6z17kXiee5UvIfE
         yBqtryIh/+eAjaboq8F92j/FjWQoXp3YZWeR4d84OnhJbDgJZ8qrWAQAkOWALTioc0Ex
         nDW/vcscnLnyUSWJ+RukNmEw9UGjKnNd5WeuSF567fx4ZtUO11r4v5wTNYr+ZO0sNZzs
         qvsNmlfbSUMMSL6BP3PRJhe3MkaSVYBNf+E5xrBd5QKh0WIVPuYvGJzYval8rx6ksITE
         uhWhQSjKZ40qpy9YFGLZrmQM+LN6K7PPB5KPHB+q52LXeojd5UfWrwmhjN6drGcga2wI
         scuA==
X-Gm-Message-State: AN3rC/6yS1X+VYDol1pBvs+hIFehMDJMAkhQ82l7LHOTnTJiwfJ4xnsU
        6U42ShaK+lwFpHmGReU=
X-Received: by 10.107.168.230 with SMTP id e99mr13157478ioj.23.1493089065918;
        Mon, 24 Apr 2017 19:57:45 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id u191sm852653ita.15.2017.04.24.19.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Apr 2017 19:57:45 -0700 (PDT)
Message-ID: <1493089056.29673.21.camel@gmail.com>
Subject: Re: [PATCH] rebase -i: add config to abbreviate command name
From:   liam BEGUIN <liambeguin@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Date:   Mon, 24 Apr 2017 22:57:36 -0400
In-Reply-To: <alpine.DEB.2.20.1704241225300.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com>
         <alpine.DEB.2.20.1704241225300.3480@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 (3.22.5-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Mon, 2017-04-24 at 12:26 +0200, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Sun, 23 Apr 2017, Liam Beguin wrote:
> 
> > Add the 'rebase.abbrevCmd' boolean config option to allow
> > the user to abbreviate the default command name while editing
> > the 'git-rebase-todo' file.
> 
> This patch does not handle the `git rebase --edit-todo` subcommand.
> Intentional?

After a little more investigation, I'm not sure what should be added for
the `git rebase --edit-todo` subcommand. It seems like it uses the same 
text that was added the first time (with `git rebase -i`). 
Do you have a bit more information about what you meant? 
I don't use this subcommand very often, I'm most likely missing something.

> 
> Ciao,
> Johannes

Thanks, 
Liam 
