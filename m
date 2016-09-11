Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBE51FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 19:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756237AbcIKTK3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 15:10:29 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35090 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756085AbcIKTK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 15:10:28 -0400
Received: by mail-oi0-f46.google.com with SMTP id d191so48616745oih.2
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=mgJeMaZi4CKnixnF/b2bK2hSdkrZamaU6mFwkxWvTHA=;
        b=lMuU2qvvUr72L3r66oi+L8W5ydGpTDEeMMqjqDl2+eW0S9vHCf4iQHBiq4okkjvyfy
         LQanmtGdR1TvcAe27WMs7Hg648M86nZexMjZdb2PTiMbMepP5pCvjyGC/vGyCjhCzbEL
         hkYBQImRaonFGeYYjTud9uWxZWTBqI/675UM/z4Y+X3YmZrVrLbB/91jXltBynTGqIED
         28iV52nXqvsPHrp1CpomM3dn6TSf4Bvf/zXzN1aINzm5RvF9/Miv+kfyIsRUa5UyDVLW
         ogX4QYgvboqTfpzJUwbNwt6MmNTXo8SIbyHIbKZXTkPR4zf1Ip7/BEkfRh/KQXB+HgK7
         9Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mgJeMaZi4CKnixnF/b2bK2hSdkrZamaU6mFwkxWvTHA=;
        b=ecCl+PIrSNkD7bjffY9k5zwzbjddaBE8RGGoTAnFY/AqW0qEn64hpfs8s6HaSInBiN
         fCXfM6qzQUPprC9rNtAylre1On70qBuKxtXFUEIR8L888bhUEEKl4YN/gE8+x3XXSA/1
         L27K71EKf2nOPRrQSZWu8vMHsI5aJ3rn3OKOIRC24VVurFE5EbgW7cHIzZrfEJ27vzQs
         ROCsloBhF6IpIc8yi0p5zUIaAiZcCuVgRYVO9MGFJcQunoMcJzqiMGE33Y3nC735RVBd
         /tyqMAG64ljwuvese3dRcl+18OvRIFGvpDFgaiPZbjdOxtxk7jWTD2a+lpxhP2Ebj9tI
         9eCA==
X-Gm-Message-State: AE9vXwMVeK3Mt9o1gtng8LJNk4sxeCJ+/hjB5+SguofCYVnpqlOOAR6zXOcN634aV5TQBngLr546Qbk8ItqjoA==
X-Received: by 10.157.14.72 with SMTP id n8mr8931050otd.55.1473621027840; Sun,
 11 Sep 2016 12:10:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.33.202 with HTTP; Sun, 11 Sep 2016 12:10:27 -0700 (PDT)
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 12 Sep 2016 00:40:27 +0530
Message-ID: <CAFZEwPPSiy1dxZgxWg1saPcw2QWgHtZKx26oSN3g1mCv25=0AA@mail.gmail.com>
Subject: Bug: git-add .* errors out
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

One of my friend was trying to add files using the command `git add
.*` and got an error that "fatal: ..: '..' is outside repository"
which did seem a little obvious to me. But then I tried to reproduce
it in my machine with `git add ".*"` and it didn't error out. I am
currently using git 2.9.3 on Ubuntu 15.04 while he is using git 1.9.1
on Ubuntu 16.04. What might have gone wrong?

Regards,
Pranit Bauva
