Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05EFA1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 14:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeINT6p (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 15:58:45 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:34768 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeINT6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 15:58:45 -0400
Received: by mail-qk1-f180.google.com with SMTP id d15-v6so5303661qkc.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 07:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RRPetPtohznB2FWiSME+snWfucYPu/Smay5d9bYMWcg=;
        b=cC95aoDQ+DvunZ2RRZ4tUt3tdVo2ff7sHdVUAYD+Mn3Gq4EZM6t6IVOzpSLM5S9bYk
         zekjUbTpGbBTiaZorAn/WjwPSAJt+Al8TZMOjK1cVuwCuDV5iiq847fPTVYiPsRjDU4l
         G05SXx50OJyKwRI4uxyBaqEbSCPD8AEEJBF8m+46DcoAbBt3P8NZ8Vqz9y1kHvWgVeIn
         gafk/FIjNNuNFilIER4c8vcU3XWniBe4e8botCp+4jnIVZ7NIXFO45eTjCdDg4jlwhg8
         QsCAu0maFQktSwoLHJnSgKCKIOP4efj2819ezxOXuyflllnwjMOFfDySLZ1oL7p9o4MZ
         xN6w==
X-Gm-Message-State: APzg51CE26yMfm3gyuX4wO3MEdC8EIjv8iiaI70E90BlfyToWv/aUN37
        GOekXCaXupJtox3pZNxEACieDXE4BLY=
X-Google-Smtp-Source: ANB0VdYs9ChafvCmAd+uza8HHCG/SU7O8m/ERSKS2eFNNyE5/UW8OakK7cibm8XS1pjalyK7+LcLyg==
X-Received: by 2002:a37:7607:: with SMTP id r7-v6mr9048325qkc.133.1536936235227;
        Fri, 14 Sep 2018 07:43:55 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id v50-v6sm4846664qtc.28.2018.09.14.07.43.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:43:54 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id f62-v6so5292784qke.2
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 07:43:54 -0700 (PDT)
X-Received: by 2002:a37:1968:: with SMTP id k101-v6mr8747415qkh.270.1536936234862;
 Fri, 14 Sep 2018 07:43:54 -0700 (PDT)
MIME-Version: 1.0
From:   Zachary Bryant <Zachary@admiralfeb.net>
Date:   Fri, 14 Sep 2018 09:43:43 -0500
X-Gmail-Original-Message-ID: <CANrLuF4aTda+WDEZSc1MmTM0u9M04ZsWruXD-GDW6wXVVX2EJA@mail.gmail.com>
Message-ID: <CANrLuF4aTda+WDEZSc1MmTM0u9M04ZsWruXD-GDW6wXVVX2EJA@mail.gmail.com>
Subject: v2.19.0 Git install doesn't allow VS Code as an editor
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I received the notification to update to the latest 2.19.0.

When the installer asks for a default editor, it defaults to vim and
when I select either VS Code option, it won't allow me to proceed.

I've reproduced this on two machines.
VS Code is up to date on both machines.

Both machines:
Windows 10
Latest VS Code (production)
