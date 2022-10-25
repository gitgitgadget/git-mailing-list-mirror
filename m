Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026EDC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 01:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJYBwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiJYBvo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 21:51:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D00B2D
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 18:51:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a14so15843650wru.5
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 18:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pS33pjqYtIokc+Fi7WxDAKYRMQ1P7ysoqSvu4iOskIE=;
        b=oXgNyKcWgib3kXANYAfTPW/XZ7y5XCMHi25M3gUmx8xIzj058cVclDucLMYeoNFxkG
         AQDdI5EfhfWFFcUKGL/kVOVA750HPqqr8BwBfQELeeS5rqurDPx723miQDjE7LUhK5Z6
         Tyk6eqKBpHZaLmROyJPYq2BfJvEZyXyeinAiLvBwm+21a2lx+EesZJrlVXIE77PuOA2z
         OYAcnog1c7e+2LW2dZl7gmiwwCuZ3UxQeaTNuOyrNLR3bIBDFoeAtUpUGq8ZaCSV8WlQ
         oKWu50DKMK8fgsQOMeP9gCSHtpw+IQXTAYFBrI7DiKN8FwYCARoS8W23CfkZBgUrKLUi
         b8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pS33pjqYtIokc+Fi7WxDAKYRMQ1P7ysoqSvu4iOskIE=;
        b=NnlchXP0E6wGVL2I8vgVijTpqTS1o4LYfEMDI+79pMU6OWnw7B5f5Qy7yZ3EjjQIzP
         pIONtelXKrnZuuKhnaNFdqodQjxlRqcvT5NJsa4sI9ANz0MvCxNd7ZH3PkvNBSh67aYz
         ULD6Qpdx4ddQtOBX51WOWwzMex76fkD8pdrU4iEF6lplUMcr1eg+6jE6Ayc/amy75NPz
         yxynIAMtTbPx2pdXp6OOq5T5X9PfQTgpmmoHZTZJ6NsUri2cLf9VMI5dREt/Hfa7BoJB
         5GbJq5wH6pRjccNYYwGIaCtwd7AVfnqQ2b6daCyob06qaKOb9rBEHNdKTL8IXSvfE23i
         Uwkw==
X-Gm-Message-State: ACrzQf0Ej5O2FNHgu8EJMIIr6iJeaXnPbm90ScxS8cIE/BsNRKAgIury
        oVG90HdYNjsgifEz2OV0sSM=
X-Google-Smtp-Source: AMsMyM7m0vmOltrC2t34he6OGXcJCFDGvA6YQ1zJkKnrIgIlC9T2h4jPptfyLQd+eerKRIWQ8YtN6g==
X-Received: by 2002:adf:e7c7:0:b0:236:6994:a0b4 with SMTP id e7-20020adfe7c7000000b002366994a0b4mr7908742wrn.610.1666662677406;
        Mon, 24 Oct 2022 18:51:17 -0700 (PDT)
Received: from penguin.lxd ([95.146.54.42])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4565000000b0022ae401e9e0sm1064726wrc.78.2022.10.24.18.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 18:51:17 -0700 (PDT)
From:   M Hickford <mirth.hickford@gmail.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        mirth.hickford@gmail.com
Subject: Thanks
Date:   Tue, 25 Oct 2022 02:51:16 +0100
Message-Id: <20221025015116.4730-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
References: <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jeff for your reply. This is helpful to understand the background.

(first message using git send-email, hopefully I followed the instructions correctly)
