Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8FD20954
	for <e@80x24.org>; Sat, 25 Nov 2017 18:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbdKYSCt (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 13:02:49 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:41049 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdKYSCs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 13:02:48 -0500
Received: by mail-qt0-f177.google.com with SMTP id i40so23438210qti.8
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 10:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HtldAgN7E8WnZX7Ky4QVmRqxTSawUvyQTVCp6QnQQO4=;
        b=Bi0C0p2OdHRWkJN5QH1PLhQGl7NfR1oMttgVQNtfhk/pTvwIfzUjgXOml8EopuunjB
         nnbRgpgPmBpe5z89zSieUXmmpSYtAIOOv7gAmUJfakD1e8gPJrLy9t86wnx7CWYBEOJ2
         qe+ThFGSRaaW3GmYp3E/R1A4GSGjp8J86uw73myYg4RdU+AKjOtf8u/FdVLEUE6w0ofR
         OFDnnXVrCuWQ/iD7sYVeeOKPY4wbV2BEu3C5tAKUWM+KMlwq56cMywYstUARwuKnJoF8
         j3fAULFTSzCl1M3lEw+HPAPRX/ElQ3/BRAw2lpz2DF6CWUBmOzD1sE4XbfCrPz0BEFg0
         dUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HtldAgN7E8WnZX7Ky4QVmRqxTSawUvyQTVCp6QnQQO4=;
        b=L+Ci40zzR12b/s5oSLSQgSjB/4CidgtZ11SDYg2FjTJQA+o/E+3mJWViHgym8XyLN7
         Xm88igcZDGiKmvVOBuoGOjKRxgWJBQ+fY/Z4X2EOvMRE3huQZVGtCcObU3Rxe5nU8ud1
         CGP99KO45m0NMMSMaCdh0mTqmgktjyADTReYSv617vqpXjvGnoMv3mrJ6tB+TlRj+k8+
         B3NcBB/77mqGZBJFauJhIenA6oy3c43zR4Hs2rA9Gnbq4HBrIPlQY5yo3Z0tYY43nUdo
         5YWt5WQe3VWhreDkJIR0nOUYsRmEyu8t348QGJd13j4af6tgH3B9ocFfWTxXIYdCAfKV
         Tv6g==
X-Gm-Message-State: AJaThX58zX2NbP/0RcBc/khvOAtmngKW9UicwOf/o9IAeo6yHCkyKd9+
        wACTCedy+34SEji65x0yoiY=
X-Google-Smtp-Source: AGs4zMbwqfjVnXANmVDbsU0IQjkQh92thoKdTua/QcDfMD65zssR3I2Cq66OV8YE2U5SWQPtzH/16A==
X-Received: by 10.200.56.34 with SMTP id q31mr52568255qtb.64.1511632967196;
        Sat, 25 Nov 2017 10:02:47 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id e16sm16947982qtk.64.2017.11.25.10.02.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 10:02:46 -0800 (PST)
Date:   Sat, 25 Nov 2017 13:02:44 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: minor typo fixes in 2.15.1 draft
Message-ID: <20171125180243.GV3693@zaya.teonanacatl.net>
References: <20171125173345.17488-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171125173345.17488-1-tmz@pobox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the duplicate.  I used the `-n` option, mistakenly 
thinking it was a synonym for `--dry-run` and didn't pay enough 
attention to see that it sent.  (The only indication is s/OK./Dry &/ 
which I missed.)

It was mildly surprising that the script didn't warn or complain about 
an unknown option.  After a quick look, that seems to be due to the 
Getopt::Long pass_through option which sends unknown options to 
format-patch.

That doesn't remove the user-error on my part, of course. ;)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cogito cogito ergo cogito sum --
I think that I think, therefore I think that I am.
    -- Ambrose Bierce, "The Devil's Dictionary"

