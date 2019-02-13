Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PYZOR_CHECK,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E953C1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 07:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbfBMHLn (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 02:11:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39245 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBMHLm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 02:11:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id f132so740732pfa.6
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 23:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=hq9yfIjTHLsWaagemMOpmrhXu0GY26d3QOaNMej/GC35bWs3O7Kj3tlEo9blMXkJOB
         ArYpZ1RWpqjqr1F3cYkKMYEN1YjkBioRm80nkZfDR19jk+EI+iAbHWHrd6nflgUqZbZk
         hdjmZb06dngjTP4jwKR6bdteJs6nbjrOxMW2vyeOAXc1MJzcdG1pXUploosuk/aVq/n0
         xCxOFjvIkDp1SZ8ufFExmWrC0lpjN8XsGzlWGSeU8H+oh/2XwQE0/QxtOOZqvD0hb7qX
         ruBSJ+qO+V2EUgFnsW7DSigoGNTWFtzvIo4thdW3Ftk7+3gx7HwNmZ/6wFpy+LGuiTeW
         B6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=l8/CwoRwpWwZ/7Yeb/i08AYpSgmvdKYS3aS/EG827nvNtYJKyTaZmgRvzzCuGis9jM
         mbpVwULr973TJGQT0qwMA9Y84gdxfhxcn/IwMHlahOzBPqkcD7Y6v5lfT/Gj8c2GPC8a
         gNBO/KvEsEoC8iNRA+tOyApaJfCdB+xnjcUOROuiu2vRNIAQ1ToWK/L83pipwwa2vpCc
         RhkfGWSHlSV0Zy7PwXP0YFfoPUgOj2jPqoNG+9jlfvSDD8vpnjXaejL0gxZdAk3RNcDD
         vtwaBfyip5F+3gc5/laacC5GuaAAmP2rNqkNH/eNftpvznZG4CQzqwUqrUBYkSA/PkJx
         2iAQ==
X-Gm-Message-State: AHQUAua0vQkZ8GzNj8+JWCQxkSZvghTx9CIIJg58YER7xddWd1MJIOLn
        Sz5R5N5n46yM8iGjPz2WPVI1TYbW9la0rg==
X-Google-Smtp-Source: AHgI3IYWfgZHSschJrz/VwYSXeQF7319Zx39s75dz2pCguwWRB3aBQCa6D0dF2kLyafG7uMRXW4aaQ==
X-Received: by 2002:aa7:8d01:: with SMTP id j1mr6311019pfe.81.1550041901296;
        Tue, 12 Feb 2019 23:11:41 -0800 (PST)
Received: from [192.168.12.146] ([47.52.151.19])
        by smtp.gmail.com with ESMTPSA id o126sm18003054pfb.126.2019.02.12.23.11.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 23:11:40 -0800 (PST)
From:   Junlong Gao <junlonga@umich.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: git mailing list
Message-Id: <F7A72F54-8FE4-4DA4-A2C8-CF7CB76C3992@umich.edu>
Date:   Wed, 13 Feb 2019 15:11:32 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

