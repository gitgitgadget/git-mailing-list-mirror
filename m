Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154561F404
	for <e@80x24.org>; Fri, 14 Sep 2018 12:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeINRpe (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 13:45:34 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:55087 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeINRpe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 13:45:34 -0400
Received: by mail-it0-f41.google.com with SMTP id f14-v6so2277904ita.4
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iuCMbil8fKtg53QFCf1XdwKFk6PidpyT1wbEkwZ7n8E=;
        b=tsz8Et0w1ga8cf3PTwZ9O0i6vBRIkWiTDoVbKnaE2CAH9Ac7XV0NrJZIJrGOMeThoL
         dS7iFDV53A6OigUSK+ctE9B5jExUda1q8HLfICg/ZU9nAudxzVo+48NrBPrRj/ybNkZc
         sFet5fHTIM05uh+7MfanW+WcgOpYrswqUfUbTmZIPA4POD/R3brRZftfwhpPbaxxzzch
         YfXoN6aJsXOGrEp3opfjcMHC0QwKXZXi+c4jGCtTE7d4VKLxPlgxHJeKu8nv47nFFmjH
         fglQmA3ztqBjCopuPZnVRGaf+zrTD8JuJ7+rddEKk07bcGwMtqpspPG62GTsvTJE0eht
         JOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iuCMbil8fKtg53QFCf1XdwKFk6PidpyT1wbEkwZ7n8E=;
        b=R6hDN2/+OLPiWsGqIJalGWtJ9TN4Ml70ktxbKeYMnlhEnjXGubCkXrCVpst2vzUXPj
         d+OmESHDrHv3ZB5AMw6q0qFuw2iUn9Nab/47YRaFLF1qDN6BJxHVrv+BcBxRqEsIfveL
         e/a+oeDQ8mxu+fQ1GjaF8C17bamweoiS9sfiInLxvziujeJkAjn1GgGQWl5QuTLxtZla
         DoFbFNJq+LH+mavvwTfKaLHzo6rOzxGOkRNxg3Cxz8awvne5/+4OrKbKME/mYDlTeX5J
         JkTipmB5bj3++7pmz/C8S8AQC0lJb6qNzAgBj6pRhYO6eixHV6R0LFr6WN0SevHiUbmy
         Waiw==
X-Gm-Message-State: APzg51AHFMHDu6EbB7Y7xYcEESk9JJFIe3CSy4JyurcThDYyeuxZC0rE
        Iyu6m39StDnISw3l88h3JQkdEjbviUcd4fJGBZfwJw==
X-Google-Smtp-Source: ANB0VdZLUbcb3evDuhf69Oqf2+TJM0inqTZCMikSAE4mANvwZVWEyyetBWbB+qsme+LPWUOU+Tqgpm4/2+RaF6wNhV4=
X-Received: by 2002:a24:5d4a:: with SMTP id w71-v6mr1980556ita.118.1536928277026;
 Fri, 14 Sep 2018 05:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-YsNbX-23+LMR_Zd5Z0Ln64vz-HQRU_YkFSnODBWuAvcRW2g@mail.gmail.com>
In-Reply-To: <CAG-YsNbX-23+LMR_Zd5Z0Ln64vz-HQRU_YkFSnODBWuAvcRW2g@mail.gmail.com>
From:   Mikkel Hofstedt Juul <mikkel.hofstedt@gmail.com>
Date:   Fri, 14 Sep 2018 14:31:04 +0200
Message-ID: <CAG-YsNbh1AQvf3FCQscNDviQqyC4FFqx-VruXrpeCgjL953agQ@mail.gmail.com>
Subject: Fwd: spelling mistake 'rerere' on docs/git-gc
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

retry -- plain text mode

---------- Forwarded message ---------
From: Mikkel Hofstedt Juul <mikkel.hofstedt@gmail.com>
Date: Fri, 14 Sep 2018 at 14:28
Subject: spelling mistake 'rerere' on docs/git-gc
To: <git@vger.kernel.org>


Hi

See title
in sentence:
...invocations of git add, packing refs, pruning reflog, rerere
metadata or stale working trees.

Thanks, keep up the good work!

regards
Mikkel
