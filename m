Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A677A20401
	for <e@80x24.org>; Fri, 23 Jun 2017 09:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbdFWJnr (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 05:43:47 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35421 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbdFWJnq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 05:43:46 -0400
Received: by mail-wr0-f173.google.com with SMTP id k67so57659511wrc.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t6fQYcAGT2IFbGJrWKGaIJWNq5edzZTnZrH91jQIWiM=;
        b=WT4vgqbZxAWpbfAV4qKKdLl/ZBp9fDXIkCoki6Z91tVxTDcaydRdHWuOXSXhhN6Zw0
         sMgAkVOCZ1va+860AGK6D1dAHtWLMaFLHUzwtltobPEpszY6wNNF3q7fpzQhvCFZwbdN
         rDK5yK4ANtMuYWj520oNDPaaAxCjD+hURnhXBsmWk8h3LfpzfRUR7lmcLA4ouImCEoJ/
         0BHMPZvJlK5JsJAwMaR8S69HEr6ry+vdYG/CvjCnQaUc5Q+4h/iCdJyIs+UJ+l8PPJb1
         N3wLdifSMBpKWQzmbbBJzmyfsxFzM5G5px+Yn7hEhM8aMMo5Eopetihz6NsdMCM22vUX
         Eemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t6fQYcAGT2IFbGJrWKGaIJWNq5edzZTnZrH91jQIWiM=;
        b=Cnnr1e6Yc6HcURjc0xgNSp0P8dfeetxzpyDXSbRyu8VM1XotFfSAUajhCxoLfJziFk
         pfG8nl4GHVX5aeej2YyUlmdUusmLrQlIEERkuzdUv5jX/7ruQNzvXt0AcbSLa64uxoTu
         2blsOI01E+wLvIXzkKYvySeHC4BZ+pwY2tliy+dTfcsVX4lSV0Jd8ZVhvGXXt0FakM6p
         6SVrfBrYbHMAjCAIqwHqztR1jKXKmv1HZcxJa73EQDWvvGTkHqHDu4KdfgNKXUeSVALQ
         ufKIbzYz8XfJiemAnFwtY6ZeUFw8V/+ryNpdcDpiyF+6zYxwnRplVgfCKNYbXDftE80t
         g+dA==
X-Gm-Message-State: AKS2vOyEQUWndIN9IRWu/sNdb6uilV0TCQNesY39jMXmszK0Z2RsipXf
        VGxgj5kVQMHkRR2SoD8=
X-Received: by 10.28.140.212 with SMTP id o203mr120154wmd.66.1498211024651;
        Fri, 23 Jun 2017 02:43:44 -0700 (PDT)
Received: from birpc0l19ww.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id r40sm5007436wrb.37.2017.06.23.02.43.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 02:43:43 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 23 Jun 2017 11:43:41 +0200
Cc:     Git Mailinglist <git@vger.kernel.org>, phillip.wood@dunelm.org.uk
Content-Transfer-Encoding: 7bit
Message-Id: <AEBB93E7-7D91-4D0D-96C9-F2AB1AE079FD@gmail.com>
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Jun 2017, at 00:35, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>    http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------
> 
...

> 
> * ls/filter-process-delayed (2017-06-01) 5 commits
> - convert: add "status=delayed" to filter process protocol
> - convert: move multiple file filter error handling to separate function
> - t0021: write "OUT" only on success
> - t0021: make debug log file name configurable
> - t0021: keep filter log files on comparison
> 
> The filter-process interface learned to allow a process with long
> latency give a "delayed" response.
> 
> Needs review.

I am still desperately looking for reviewers!
It would be awesome if this feature would have a chance 
to go into 2.14 :-)


> * pw/rebase-i-regression-fix-tests (2017-06-19) 4 commits
>  (merged to 'next' on 2017-06-22 at d1dde1672a)
> + rebase: add more regression tests for console output
> + rebase: add regression tests for console output
> + rebase -i: add test for reflog message
> + sequencer: print autostash messages to stderr
> 
> Fix a recent regression to "git rebase -i" and add tests that would
> have caught it and others.
> 
> Will merge to 'master'.

I think this series breaks t3420-rebase-autostash.sh 
with GETTEXT_POISON=YesPlease

See: https://travis-ci.org/git/git/jobs/245990993


- Lars

