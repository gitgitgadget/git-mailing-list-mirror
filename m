Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371CB1F462
	for <e@80x24.org>; Sat, 25 May 2019 21:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfEYVsn (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 17:48:43 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:34902 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfEYVsn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 17:48:43 -0400
Received: by mail-vs1-f45.google.com with SMTP id q13so8239552vso.2
        for <git@vger.kernel.org>; Sat, 25 May 2019 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7vAN42/JIyFdqpFTwLvSPjFlZrHCSOL+W6mr7USndSE=;
        b=YRRacIOC6ddZj2I0ajPIFGiKbL26JiY3nvpkJdTiBCDu0HO2FDVIWq15tPVDXJjx1N
         ymN4ZmwlcGSJZYtWOXc6HaVX7JKfdPXxAUM2E709GBTjgAeqhpzy14N84mprsgPA8MfI
         ddBc+pX90jNMRmJFma0I7svekAQh6wOVrxQqBPztMh8MqQJ4/Nmx8iel2SZiwxi+Qjfc
         wdrq/tY5hTyim/RSerPtNNyOgJO4pQTItJsUanzvZtSEWhPNqyVFP6CZoKMlUsBnNlad
         lLdIEEZldGsmZsQgvmjUp96QXOavMOL5t86h/9/ouO6TrRJUDtdiU1ElUFIYgpmdQjEJ
         /g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7vAN42/JIyFdqpFTwLvSPjFlZrHCSOL+W6mr7USndSE=;
        b=kwxOD/Dkilzr775N/KugBpWHCu6RaSCW5kMz3gaBkTDqM9cTOAsRcQKpbfY42NhkIW
         IKxnlnsCEixBUDCKfgQWcHJGTgP85NLDMK2ZgoeYRQ8+WqezGYqNZ/CaPv7W2CkkEQq9
         mCtMm5q/g47JwiEfsrvwQwWKojIgETr/gVjGq+upl/Q2Ovo9sFBM/6ASxy31tPbo/UTE
         jpSIdpqHyfabyTeJ8Jhz8sCaBmwCSrQjD3CgXJ1XZ2x9fR5v3vM632Vv6p2evB3tOAHQ
         f3Tk3JeDLyH6dq+UjgnMigGTOY709lDOVU8T6FIWMLTrLlB2AuJHjaf4dTEZwusQlI9h
         n3lQ==
X-Gm-Message-State: APjAAAUI+pYarCPtXU7Xfebdgp2JDGaq1LyZNhlNcok8YUwNccAXzyt8
        p6stS44FeqxVTb6DGUg/+Hg3l2vojJmrDs7rNcDi3MCKLqw=
X-Google-Smtp-Source: APXvYqw3FkLwnIUVL195+sw/+MIcjS0CDwBEBvzYUBe/atuVYQiXYuJcPJuVd3FvFCe0pCFpAqLicuBl95zT5uWkK9o=
X-Received: by 2002:a05:6102:c7:: with SMTP id u7mr46326761vsp.226.1558820921889;
 Sat, 25 May 2019 14:48:41 -0700 (PDT)
MIME-Version: 1.0
From:   Shawn Landden <slandden@gmail.com>
Date:   Sat, 25 May 2019 16:48:30 -0500
Message-ID: <CA+49okox4CfSWgQrdAYrM=R3ZNThWgkEY9RZtDzOMxAVs5b7Dw@mail.gmail.com>
Subject: receive.denyCurrentBranch that allows pushing data, just not changing branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would be nice if when pushing to a checked out repo you could get
up git to still push the commits, just not update the branch's HEAD.

-Shawn Landden
