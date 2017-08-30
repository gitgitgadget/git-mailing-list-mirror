Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE4F20285
	for <e@80x24.org>; Wed, 30 Aug 2017 14:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdH3OQD convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 30 Aug 2017 10:16:03 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32936 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdH3OQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 10:16:03 -0400
Received: by mail-oi0-f43.google.com with SMTP id r203so52143557oih.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 07:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cwn/ax/PeZ04s7YvvyhQHwKB7gErV/WdXdqw7qJCFJg=;
        b=tN+QJnV5Vww+xdm9ED9SX7VG8iNMZWyvOc/Jh4oTetPtQOgaCGSdOuf3CBFoU3WQDn
         6p51lFCZV0kl7+ykf8pQPUPou0+ucNNkHULIFFDChYua0TnybsVfusPtyli1ERTbjflC
         Frh92cdZstGsaqL0DBC0MQQcjlcnD40Fxws9vOlKwv9bueHWU9NT9RgARrVQpCP0IxjI
         aX4jqYmJHiuYW67t6jag8HX9nJohBVUgK0WC1sYsmVpUBX6s0HdPOj0ChJJQJiMHdQqV
         DlhwES+R5p9Kkcm4s7kHmxGblLD1zTXKxYFdYgSef/i5bizBVxy8bahuBpZnd9M9YCfK
         llBg==
X-Gm-Message-State: AHYfb5hX27v4RF2Ek1xAAJZWq5R412X01OO3A1MeaSOWExibr6rA1qjw
        QrPOzSs6jbw3AoOIyMLaR8xJ4FQce7i2
X-Received: by 10.202.81.200 with SMTP id f191mr1631546oib.172.1504102562272;
 Wed, 30 Aug 2017 07:16:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.45.88 with HTTP; Wed, 30 Aug 2017 07:15:21 -0700 (PDT)
In-Reply-To: <5a9e4efd-8c48-487e-4a9f-9362a944c992@redhat.com>
References: <5a9e4efd-8c48-487e-4a9f-9362a944c992@redhat.com>
From:   David Lloyd <david.lloyd@redhat.com>
Date:   Wed, 30 Aug 2017 09:15:21 -0500
Message-ID: <CANghgrS9hZyA4vWU=4PZuYue3iLsLx7ObbT_VgRGSXpACwNkcg@mail.gmail.com>
Subject: Re: Produce contents of index with existing directory as cache
To:     Florian Weimer <fweimer@redhat.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git reset --hard ?

On Wed, Aug 30, 2017 at 9:11 AM, Florian Weimer <fweimer@redhat.com> wrote:
> Is there a variant of “git checkout-index” which will produce the
> existing index contents, like “git checkout-index” would do with an
> empty directory, but can reuse an existing directory tree, to avoid
> writing all files from scratch?
>
> I'm writing some analysis scripts which need to change a checked-out
> working tree.  Right now I'm throwing away the tree after making the
> changes and create the next tree (which is expected to be quite similar
> in contents) from scratch, starting with an empty directory.  This is
> quite slow.
>
> Thanks,
> Florian



-- 
- DML
