Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5496F20D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756719AbdDPWGp (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:06:45 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35241 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756638AbdDPWGn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:06:43 -0400
Received: by mail-wm0-f47.google.com with SMTP id w64so24206361wma.0
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SabZluLcsOO9p0P8ILub6d8rIQZNx3REPvEZKnriXds=;
        b=al55BhiL6xSWGMjaRadnvys6wA3tum1rU6vZdeBWtiOf7bIWiZ7wKauOTLB+QFmIfx
         V33JMyVObA++vw50fujQajuO7YsCMgEAKiKP9UueZq/pT8VCMVw7BIH6FXAwescqZOFk
         haETx5FNqi+mnBPfXHLP9Gwf6w0/mCuUcdKNQnA3pmr6BomW7XF9UF6j7DO0clVgq+6J
         BQJR25CeJ5i8uHIRSu0MYdLEaf6U23HRyPxhlxqkY1LD6y5vx7VyB7J/pDryo0Tl9KYq
         3kL7biENyEpmpX8RDMrmmTaIw87BWCuIxoRKlOSdYSPylQybec68eJ0FDNbameQt1V7l
         Pwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SabZluLcsOO9p0P8ILub6d8rIQZNx3REPvEZKnriXds=;
        b=KTN27iLPV+T35fP9/4F3gXNk1Bhb6Iu8I3mEeCDPUBlsDaP8bh538dT2XEnwzhv+WE
         VRxjZqmG2ZeMw792h4C+8kickm3+Y34UjwzCZD6Af+h1KR+ptM9JJgJXktfDGjBvHbtz
         NOImIrj2LFtTartjkXdaLLum5Ys5AV2cRoGeb1VeDW1LPFZCwAwVV/1VVa8hn+13Mz27
         qf3pAgzbwwjQh6mMPLOUHJKErkkCRu9UZscikBebi4qlOv++5uXatmC0tAqGPD2rtxCR
         xSDkLnJNevWfFIm3Q9qmdkxag+jiLDsQfyNit9TQT5NJHts5P46piETDsGv3ZlsvEImO
         RQFw==
X-Gm-Message-State: AN3rC/5so59Sz6VaIagRbzQ8LmoFQyRFQfR/Q8Q6TxoWNkDGyADDQR/e
        7HyR75XM2Qke+zkI
X-Received: by 10.28.214.3 with SMTP id n3mr6521456wmg.67.1492380402327;
        Sun, 16 Apr 2017 15:06:42 -0700 (PDT)
Received: from christoph-laptop-16-04-2.fritz.box (p5DD30ACA.dip0.t-ipconnect.de. [93.211.10.202])
        by smtp.googlemail.com with ESMTPSA id p101sm11748822wrb.64.2017.04.16.15.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:06:41 -0700 (PDT)
Message-ID: <1492380399.19991.13.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Date:   Mon, 17 Apr 2017 00:06:39 +0200
In-Reply-To: <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
References: <1492287435.14812.2.camel@gmail.com>
                         <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
                 <1492347718.19687.14.camel@gmail.com>
                 <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
         <1492368692.22852.9.camel@gmail.com>
         <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-04-16 at 22:25 +0100, Philip Oakley wrote:
> From: "Christoph Michelbach" <michelbach94@gmail.com>
> > It's: git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...
> The one I quoted is direct from the Synopsis, which does indicate
> there are 
> potentially more aspects to resolve, such as the influence of using
> the 
> [-p|--patch] options.

Oh, you are right. I didn't even notice the one in the synopsis doesn't
match the one further down. The one in the synopsis is wrong because
after removing the optional parameters, it's the same as the first one
in the synopsis, yet we expect very different behavior from them.


> It maybe that the paragraph / sentence that needs adjusting is;
> 
> 'git checkout' with <paths> or `--patch` is used to restore modified
> or
> deleted paths to their original contents from the index or replace
> paths
> with the contents from a named <tree-ish> (most often a commit-ish).
> 
> and split it at the "or replace paths" option to pick out your
> specific 
> case.

This one is confusing, too: Paths can lead to folders, yet folders whose
contents have been modified are not restored to their original contents
when executing that command. Only files are.

After reading the documentation and having never used the command
before, one would expect

    #!/bin/bash
    rm -Rf repo
    mkdir repo
    cd repo
    git init &> /dev/null
    mkdir folder
    echo a > folder/a
    git add -A
    git commit -m "Commit 1." &> /dev/null
    echo b > folder/b
    git add -A
    git commit -m "Commit 2." &> /dev/null
    echo c > folder/c
    git add -A
    git commit -m "Commit 3." &> /dev/null
    git checkout `git log --pretty=format:%H | tail -1` folder
    ls folder

to print `a`. However, it prints `a b c` because all of the files inside
`folder` which have been modified or deleted since (here: none) are
reset to their original state after the first commit, but `folder`
itself isn't. Yet, the only path which was passed to the command in
question is `folder`.

In my opinion, this command needs improved documentation (and the
synopsis needs to be fixed).


--
Christoph

