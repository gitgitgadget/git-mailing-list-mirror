Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98E71F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeGTWSG (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:18:06 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:43245 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeGTWSG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:18:06 -0400
Received: by mail-lj1-f182.google.com with SMTP id r13-v6so12204013ljg.10
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1TzQXtQJyTKphXiYvq1eIceJGNlNQ3gs0g4mNzay740=;
        b=Iwd6TVb9jxyTo6F7Be48A8b/ZyjcYpiKwyLp3aJOQharIFhRjK/Mzi3COPQZcCMn5s
         2CXEhk7VRgK87pvJDrYF/bLdyvtSkJQ/5WEYIPTZP+TQpTjxK3VF66dE9JnPZPOswho8
         AYVryKnhSs/tPfisBPiYhdtMNygTXuA4Xzl0CKnjK22GGrnEOG+4oiC2ScXBSdUg4s+A
         QNNydoDS7ABIIRVnjUj/JTMFjr38XT846m0S631RWfUI7I9SXXZA8swVtQ6VfMbJBzde
         c/ksPWnie7YC5Fdk30o8PFJe1EAGlC5bzt3HiZ8rszTmMysvT2bbqCb9zKY+jR5SkvY9
         J2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1TzQXtQJyTKphXiYvq1eIceJGNlNQ3gs0g4mNzay740=;
        b=Ql9RJKdhNcWLNT45fwnp8PmFboS+V/cRa+B9ZJOvgQ/d8DYARtdQbHF0SLtVzZ1bCI
         efgVJOowQ3O4jnTgrtbKwImdR+qeuBh2TaD8f+Xl22p0C0yx6KG00ueCeCh0lrQXi4MB
         meAKCeRlDu0wFQyklRPQxoVTBoeK2YACN/2wzCbFBt7+g9a/kAVTPfQguQNp5Q9LVDBo
         MK3UQbjIGU2j/W0VGGXkMmcjpMzUwjYAFcgz9mPaeDIaj/klSLHutoa6+sA+9td9tupO
         XlkH8mZASzJTY7r7gcm6SAIAjyN6qgGWdAVJNPz6BQ+PtHQBKlvi+fSHgqVp1Ets9g4H
         k5BA==
X-Gm-Message-State: AOUpUlHS9V3vHzMHvI2XW79tNxVt+UjkagCQJ2u/CreK8mZDcyIHOyN3
        pTF2cXfJPQGQ4JRKSi9NKApfLWr/
X-Google-Smtp-Source: AAOMgpcdvzXNxQ7BIrp05ukdr0HFyyfRTkp5jjanwnhC+cdBd5kv9WVE7SFC/X0BRfNmNlyVYbxuJg==
X-Received: by 2002:a2e:5b4a:: with SMTP id p71-v6mr2567908ljb.91.1532122080169;
        Fri, 20 Jul 2018 14:28:00 -0700 (PDT)
Received: from [192.168.2.2] ([213.21.46.206])
        by smtp.googlemail.com with ESMTPSA id f93-v6sm533565lji.76.2018.07.20.14.27.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 14:27:59 -0700 (PDT)
To:     git@vger.kernel.org
From:   Basin Ilya <basinilya@gmail.com>
Subject: error: invalid key with file url insteadOf
Message-ID: <7ac8e749-0636-cac4-35c7-1226f340e72f@gmail.com>
Date:   Sat, 21 Jul 2018 00:27:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: ru
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I'm trying to make the Cygwin Git understand Mingw-style repo urls:

    git config --global \
      file:///cygdrive/c.insteadOf \
      file:///C:

But this fails with:

    error: invalid key: file:///cygdrive/c.insteadOf

Manually editing ~/.gitconfig works fine:

    [url "file:///cygdrive/c"]
            insteadOf = file:///C:


    il@MAR2 /cygdrive/c/progs/maven/maven-scm/maven-scm-providers/maven-scm-providers-git/maven-scm-provider-gitexe
    $ LANG=C cmd.exe /X /C "git clone file:///C:/progs/maven/maven-scm/maven-scm-providers/maven-scm-providers-git/maven-scm-provider-gitexe/target/git_copy checkin-nobranch"
    Cloning into 'checkin-nobranch'...
    warning: You appear to have cloned an empty repository.
