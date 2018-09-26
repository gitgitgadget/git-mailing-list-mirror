Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC531F454
	for <e@80x24.org>; Wed, 26 Sep 2018 20:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeI0CTj (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:19:39 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45315 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeI0CTj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:19:39 -0400
Received: by mail-oi1-f170.google.com with SMTP id d63-v6so169469oic.12
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=q/+A327P5ml3tTDLAneySen4BoRQtUx3IKzX2UQ0iYc=;
        b=paroYOA0GTXY77bmD4JRj/o9zx0wqNOulr6Jl0e0ywqCMDMawRKierPyI8cNF5uTk5
         no2xPcpXG2/b7Mqc98ESeuUcZOEsk+d2jtWYQ3TFWgmXVZTo56kuU56aaz89BnsywtWJ
         dDhBpRT/R2UVs4XLTLdj7yiZ0T4/taUnm9IcReA/PZWJcXTWTgeiltloGtGzuD4VmzmQ
         1T8JTQFDHXZ4jw4iX9AqGNkDQ8tPet/1gWYM29nde7YMvo4JxFlrUmHtkfSQrT2Rgtjt
         8Sl1euZcYsMT5dcriMD/RDkrUYz+z1uAtv6m3HAyUU3utQcOb7RJIFqYfgiGQ1LPpjtb
         ajsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=q/+A327P5ml3tTDLAneySen4BoRQtUx3IKzX2UQ0iYc=;
        b=qlVKy8nBQTz/Ez0+BddzqXDkD8eSKlVnJGVrnO09A/egXDSZI+LxFZot/3iAbg2e6X
         w7wlKev1W8bohShwnjZXAt1JpdBEllvAVs7AB8htvDlMTEb2Q/JJ00NUrf6uwzAFN278
         MagVLfSDhV3He2gZ+O9yJrZqtKM5Hzv5eu7EirTOt5j5eVnR11nIg2/eIk008/g77YN3
         y3REIWhRza1QARS75uyDIrasfd5x+U/krXulhaQLAsoLGshoXxWkXKw+c6pLv3o6Mcjh
         a/bMnSGQum/1EBBpIirhFLKN8GCATbVETWQ12p2oqE2gyBN1aypFEuikvdm84l4p/+IL
         mkXQ==
X-Gm-Message-State: ABuFfoi022i0xQls6AErDNurqM59GUvk3+vQX5J8nByxFAJI3HeM1j/W
        ElQIDdDIrAKZg5npNlACJ7MIwaM5vz2oQ3AM7Ai2sxPo
X-Google-Smtp-Source: ACcGV61ZEOreabV8MKusMcgDOhotA5x3Jn+hy2sbQy5NjKAZS3c98IE+yV0QWK1OaZxHzXBa0W35PyEkP33HmQbQhSM=
X-Received: by 2002:aca:3d83:: with SMTP id k125-v6mr1557642oia.86.1537992302821;
 Wed, 26 Sep 2018 13:05:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:40c1:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 13:05:02
 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 26 Sep 2018 16:05:02 -0400
Message-ID: <CAH8yC8ngjy_NGhgepRu+331L_=QQ4bpvMe5T4OtjLXJR3OZ-NQ@mail.gmail.com>
Subject: GPG signing is bent on WIndows
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several weeks ago I updated to the latest Git for Windows (when
prompted by the version check). At the time I noticed:

$ git commit -S -am "Fix unset MAKE variable in test scripts"
gpg: signing failed: No pinentry
gpg: signing failed: No pinentry
error: gpg failed to sign the data
fatal: failed to write commit object

I got to look at it today. On Windows:

$ cat ~/.gnupg/gpg-agent.conf
pinentry-program
/usr/local/MacGPG2/libexec/pinentry-mac.app/Contents/MacOS/pinentry-mac

Jeff
