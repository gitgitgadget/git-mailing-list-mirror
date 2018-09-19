Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471661F453
	for <e@80x24.org>; Wed, 19 Sep 2018 17:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbeISX0X (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 19:26:23 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:45837 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbeISX0X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 19:26:23 -0400
Received: by mail-lj1-f175.google.com with SMTP id u83-v6so5836186lje.12
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KSznKSjsMfSHucip/SfPo+IBFk8sS1LFEpxaGZBxCPg=;
        b=Yu6eoMVhdparolOb0FVMAJP/6h9adh50QeXpjFoRhPzP6RX/eHYX01tNaWYOk0p/Cq
         vGhNTmyn4y+8fRET3tUPD9nftT1ZPCM6zoHcPsqI9xBXIpSSPjF/afcFYV9EwCc0LDq9
         6vtVLHd2bRnHJz0wluaI8BeLfJRvgP9qh+wEQfYaedofmxee86ZJSkLLbNtBNSFmlyTQ
         xZXs1meVdl2C/pSnfyM9Ihx4frlB+fV9iz3rYBjxYZqCvGrUG++ust2yMAH3GbZs+Mrl
         ThDeDD9jIt67S5PysKvSLq6D2gVEsef40eJCD0tgP9yh2TUx/8z/fMncrlS7JY+Fx/KZ
         GzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KSznKSjsMfSHucip/SfPo+IBFk8sS1LFEpxaGZBxCPg=;
        b=PGiN2Dtz3qMweWqs1m2UoxdRQirdQQ0y/XUyr8RhJ1b6BCJnQ5lgjr9H2X5alXsCEC
         hbrSvV89KK6EZnWg5rj+m7igTUeky/95627UFtZ6B6b1UBYtdhMmuspoaDkOCezLb5Ik
         VI5Hw4P6btQdq2eALFB5V4ityPZxJmQWIWeXzjsia/SSARzmEKATKJtobJIF0RzmGq5B
         qT/5wTGeuvh9fJ1hsMykYdSgIMz2ZOgGDlbRqgaVjpFEdYp12bYb/N9eNIvRvfF6N4U0
         rR2VT5R/t2E2YavSOw+z6+UO3iPaB71f9OEvc+lCoz6zQeQN8HwWuF66Rf3H+BUUE8ve
         zo9Q==
X-Gm-Message-State: APzg51Dg8GejTXyb0s7rLxtUQRPifB6RUK4RCTS5+hknIXWVdsEaY6ej
        X2Psz2Z0f52x4thxu6nKJzvlt4KJ2k+zBMRlItURdKPo
X-Google-Smtp-Source: ANB0VdZAP6UDr7w7mN7yvN8pXlTIJa7/zgGu1K7XKaEysHJYHJAnNL2nrJlO/o+h0UNMtEG494rmPg6Hw6imYLxIhTA=
X-Received: by 2002:a2e:1652:: with SMTP id 18-v6mr11319185ljw.56.1537379241005;
 Wed, 19 Sep 2018 10:47:21 -0700 (PDT)
MIME-Version: 1.0
From:   Leonardo Bozzi <leonardobozzi@gmail.com>
Date:   Wed, 19 Sep 2018 14:47:09 -0300
Message-ID: <CACrY0PAM=Ek5T_3oYkT0zMoAsULDfu9JAYm3xJdEqaxvxpQiwQ@mail.gmail.com>
Subject: Access Git ssh on port 8822 ?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good afternoon, I'm trying to set up a git server, but I want to use
ssh access to connect clients on my server, but because of a
limitation in my internet provider it blocks access from outside on
port 22, so I changed the same from ssh to 8822. But when I give the
command:

$git remote add origin bozzi@bozzi.net:/opt/gitcurso

The server blocks me because I would have to access via port 8822. How
do I make the connection correctly?

I'm Debian user.
