Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E5C207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 16:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935781AbcIPQTU (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 12:19:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33047 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933244AbcIPQTS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 12:19:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so4455771wme.0
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=3VSJQv+viKafGEnptcSjpH/q7DWNB+xigxPjVTSJG9c=;
        b=EVwstfgXw0fUKkupq7mcGNxkjdAzS5oNmBgrUOdUGa5XIE7vNJ7FVJty5y766I2bid
         fhHTMmRw669B3dZBLwvf/vhQG4fraWoQFvSpZv0TmYijSZHJLVcd991MhdTLcTVJxEt6
         GerJXI8Djwsb5Vh8oUkqgZumr7YOwAqO6uJ1/0kUArf7dgGXfcSvzz7+lW9wb1dMFLDS
         D6K28OzOa/0B9fRXv4bQSTTiwhv8s3b7oUa695wG9uYVZ8QTRYqgCdTXSprzVafdqJXl
         kfVhbNpQdG7g30Tb5ydTsEA+3ASgBcMmF9/Xs9tf+JkoPU4UgL4re3IqXd9eb0IeERJL
         bnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=3VSJQv+viKafGEnptcSjpH/q7DWNB+xigxPjVTSJG9c=;
        b=OS4L4UnI5n5496Q5qVNKfKnEakGLpi5f8Fodcg71FMglhgYBypWrnfXtyu2toQ9JH/
         vGa4NY4ybb70fGDGiixCsFiGnGaQKCJ+HkLFOdSHqTIya8cC7VdNzD/Y4nrQpJO9zqxc
         R4homzcSfnvey9Ne7QB/HrP8Sv6vRRJoekvaC2+AxSwzCFvDJYbU45+W6vnRy5YixJTm
         pM5AJvaGKAS8LQ6lF1O3+Rb2KRuzRS4AD5nDF1t+RHjETS8sOpJEAXOBFwVF9BPzJE2w
         LEEaisZ6AlzVVL2Wt2yR5r/htdMFWyb8nZyTv7rYt6iJYHDJ52BXSUKhoKp/rQisscky
         W2oA==
X-Gm-Message-State: AE9vXwPpQbFjbhGpT1IDc2cWcjGjxzSr1h81TTGkHK1csOZSWUi5vo3rNV0UEUnVaYcZIA==
X-Received: by 10.194.216.233 with SMTP id ot9mr13758145wjc.166.1474042757401;
        Fri, 16 Sep 2016 09:19:17 -0700 (PDT)
Received: from [10.53.167.131] ([88.128.80.82])
        by smtp.gmail.com with ESMTPSA id xb6sm9084376wjb.30.2016.09.16.09.19.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Sep 2016 09:19:16 -0700 (PDT)
References: <cover.9c54bbdd9f054215b5432c4ba3081110e2e91724.1473973732.git-series.orirawlings@gmail.com> <728dfb8e2bf4aa9f6297eada7b8e8a107fd382e6.1473973732.git-series.orirawlings@gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <728dfb8e2bf4aa9f6297eada7b8e8a107fd382e6.1473973732.git-series.orirawlings@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A490197-3220-4AF9-95DA-89B726A91F92@gmail.com>
Cc:     git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
X-Mailer: iPhone Mail (13G36)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 1/1] git-p4: Add --checkpoint-period option to sync/clone
Date:   Fri, 16 Sep 2016 18:19:15 +0200
To:     Ori Rawlings <orirawlings@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Sep 2016, at 23:17, Ori Rawlings <orirawlings@gmail.com> wrote:
>=20
> Importing a long history from Perforce into git using the git-p4 tool
> can be especially challenging. The `git p4 clone` operation is based
> on an all-or-nothing transactionality guarantee. Under real-world
> conditions like network unreliability or a busy Perforce server,
> `git p4 clone` and  `git p4 sync` operations can easily fail, forcing a
> user to restart the import process from the beginning. The longer the
> history being imported, the more likely a fault occurs during the
> process. Long enough imports thus become statistically unlikely to ever
> succeed.
>=20
> The underlying git fast-import protocol supports an explicit checkpoint
> command. The idea here is to optionally allow the user to force an
> explicit checkpoint every <x> seconds. If the sync/clone operation fails
> branches are left updated at the appropriate commit available during the
> latest checkpoint. This allows a user to resume importing Perforce
> history while only having to repeat at most approximately <x> seconds
> worth of import activity.

This looks interesting! I ran into the same issue and added a parameter to t=
he p4 commands to retry (patch not yet proposed to the mailing list):
https://github.com/autodesk-forks/git/commit/fcfc96a7814935ee6cefb9d69e44def=
30a90eabb

Would it make sense to print the "git-p4 resume command" in case an error ha=
ppens and checkpoints are written?

Cheers,
Lars=
