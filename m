Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25127C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 12:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiF0Mpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiF0Mpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 08:45:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C6EE2C
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 05:45:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q18so8042838pld.13
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgau/j1ltEkBZOfH1ZyvYg2QfWVXyzI9N5//L18EFAw=;
        b=ouq042uAxKPrKkRhVFj2Tnhov8++zC+RRQPW4tMEmInOpsupxPpRdWtA1phx+oU4b6
         sQ0GinPMQbz029lKn/nTaj0rypddeYe7n7zKJ74l2uFPAXc4SHOFqCSfl5VP9swTY/Vd
         SxtjA7L3E1NSWX7q3/aDSdC5dnYfPk8VWIVhF2ysM3syWFsSJb90WI5j1WHe0TP0oxkK
         fUnZhfE0WgEC+OWZ+94Jqv8+RZhbZMR860X5bzIXDnNxYrBdtM6fiIHK1yWhwlG69Qio
         4eG8b253REUIU1pozXP4IjyG7Dftnw/Tf91WhYacMKoPD7WDjCmZvxj56csB0BAe22uV
         wpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgau/j1ltEkBZOfH1ZyvYg2QfWVXyzI9N5//L18EFAw=;
        b=jyvd1eL6nlWUGExbWJj8jIYLdHb+rgF1Dfv6wSPcdl6vt7O/7qtGYlfoAMYuP2Ei4M
         dIX4pWGFibJUW34mD001pwsXvfjQbC7L6eclVx+p9eflz01etsUMW1TZVHd7DK6dWdhZ
         IyoX5QEdGvu8YBEY554QIxJs+RZUc+L0bBnU1qJIB+rUonG8B+j5vEeF70NNSkD52JiI
         rXTyVPyQN8duA3rsFo0Tvp5ZBlsv9HtdsrnWyyreBIphC9+ECMQR2ZiX+H1+0XOD1F1a
         pUHcYSimPrE40St41g5Lm/0ZDHzknbTLVzN0M0k9CT93pe8ejvrtPROlrDXwXTAiJMqt
         88VQ==
X-Gm-Message-State: AJIora8YolbFLYKoOAr24pr0aNs4WAeykxOzw0e1pMeCR0il80YB0pHE
        jD/m2WxvV4CxL7el2c468Bwu2I0cIX0=
X-Google-Smtp-Source: AGRyM1tWdk6HNdO/fbtZclmoSIph/DEGMfNg2L7wyiHcFZcwrL7b08UVpvHZT8J4m6x/+qmu/uQQqw==
X-Received: by 2002:a17:902:f78b:b0:16a:4ad:f359 with SMTP id q11-20020a170902f78b00b0016a04adf359mr14525968pln.99.1656333929842;
        Mon, 27 Jun 2022 05:45:29 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.81])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090a2dcb00b001e31fea8c85sm9314822pjm.14.2022.06.27.05.45.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 05:45:29 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [GSoC] Abhradeep's GSoC blogs (27 Jun, 2022 IST)
Date:   Mon, 27 Jun 2022 18:14:08 +0530
Message-Id: <20220627124408.15611-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello developers, this is the thread where you can know about
my weekly GSoC blog links.

My Project - Reachability bitmap improvements

Blog update
------------

Title - GSoC Week 2: redesign the table format
Blog link - https://medium.com/@abhra303/gsoc-week-2-redesign-the-table-format-829dae755a5

Summary - 

In the last week, I worked on the reviews. Some major requested
changes are (1) Use commit positions instead of commit oids in
the table. (2) Use 8 byte offset positions instead of 4 bytes
(3) use iterative approach for parsing xor bitmaps (4) Use
`<commit_pos, offset, xor_pos>` triplets.

While implementing these changes, I discovered some bugs in the
previous version. I faced errors during this time. But finally
managed to fixed those errors. Taylor helped me to get rid of
some errors.

I think that we can optimise the parsing of xor bitmaps further
by stopping stack filling loop when we get an already parsed
bitmap since we know that bitmaps having xor relations with it
has already been stored/parsed.


Previous blogs 
---------------

------------------------------------------------------- 
Title - GSoC Week 1: Let's Get started
Blog link - https://medium.com/@abhra303/gsoc-week-1-lets-get-started-fad78ec34dcf

Summary -

This is the first blog that I wrote for GSoC. Taylor
suggested that I should work on "integrating a lookup table
extension" first as it is smaller compared to other sub-projects.

The idea is to have a table at the end of .bitmap file which
will contain the offsets (and xor-offsets) of the bitmaps of
selected commits. Whenever git try to get the bitmap of a
particular commit, instead of loading each bitmaps one by one,
git will parse only the desired bitmap by using the offset and
xor-offset of the table. This will reduce the overhead of
loading each and every bitmap.
-------------------------------------------------------
