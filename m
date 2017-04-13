Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0293F20960
	for <e@80x24.org>; Thu, 13 Apr 2017 16:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdDMQym (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 12:54:42 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35940 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdDMQyl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 12:54:41 -0400
Received: by mail-qt0-f179.google.com with SMTP id v3so50308934qtd.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=37YtxosGPUV13zpmzDKmkeVE+ZIVviXjbWm2I4gK6D8=;
        b=VRuvNPRmmU+tZg3D1OlH7sa1pFGRd1RqSFJZDboe5jTyo36DU4wIEeCJhteR6FgV+j
         tUefDQ28SQbKTZ0c0bij4zWlIjWXI5Js/1RdMaUwII9PvFu4eGyO7mcMK8FkBxVBKjPE
         /2v1Ef/mAUkiVXOnCCCM0hJRhJDDVEetkXkzePgcoP80k6s1r2Pic1FC+b1zWK4wdxeh
         w/4WP+qlwpYXH4ym3F+9JjpEzhB+qbwuDRRPy+RH9u2Yszz2SRnmj6gJZwmy6JD2WqWa
         HYuiyuYrA2GUS4OESfr+FaGBNSpTLcFuQuFxOTKdfKJUfao8lHKEqsy1KKbtBzI7zSob
         Abdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=37YtxosGPUV13zpmzDKmkeVE+ZIVviXjbWm2I4gK6D8=;
        b=TzhypgYyoSDMsUsVpKE/1qs/kEOTwSY0qxu7lnN1ep43m3MqC/Q+ULG/eWXVnodKrK
         thTXtSd/cGrpaLACqfRwlO+AgJUSL4BIh2YOS7XgKKCr759bG4SH9ROsdurvmsMkZoYS
         PCcl6NOJtb1a6VQb2b1mbTp6w0HdIVANWEj2kF++J/mRGGC9vEwrLVc1WW/Koef2sXiV
         ZsosAHEMpaN2sVQ4YZRp5w+XaYXC0WjS23FAc/baMm10I+JiJmw0hvdtwtGgLlAaXOE2
         6vFdnBuXnuomB2h31y0DgIvZtwebEY47GJAdwPMBUpvBcWZU0EVjvpovgHZR6GBvElEs
         PVmA==
X-Gm-Message-State: AN3rC/6kOC+fLEF7vAdSLa1kmJ6Y1+5fr6jS/giCKbkb8YZzf9f5rnHN
        Ow+xogXtnQ9tstMeyrx4UUJGW/BlAQHJ
X-Received: by 10.200.51.246 with SMTP id d51mr3436364qtb.119.1492102480074;
 Thu, 13 Apr 2017 09:54:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.40.50 with HTTP; Thu, 13 Apr 2017 09:54:39 -0700 (PDT)
In-Reply-To: <CA+-Lr-CGHLFJv0iBPNMQ-X_GWzurt1dZKeMhpYd_fw6ZQGywzw@mail.gmail.com>
References: <CA+-Lr-CGHLFJv0iBPNMQ-X_GWzurt1dZKeMhpYd_fw6ZQGywzw@mail.gmail.com>
From:   EvenEven Odd <oddeveneven@gmail.com>
Date:   Thu, 13 Apr 2017 19:54:39 +0300
Message-ID: <CA+-Lr-B9FXSwa7tTJEbBjRX6NmUu3mu8CbTsHCv+rKA-jBY_8Q@mail.gmail.com>
Subject: Fwd: Errors running gitk on OS X
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running gitk from the command line, while at the top level of a Git
working directory, produces the following error message, and gitk
fails to open:

> objc[1031]: Objective-C garbage collection is no longer supported.

> /usr/local/bin/wish: line 2:  1031 Abort trap: 6           "$(dirname $0)/../../../Library/Frameworks/Tk.framework/Versions/8.5/Resources/Wish.app/Contents/MacOS/Wish" "$@"

Additionally, the following error message pops up in a window:

> Wish quit unexpectedly.

> Click Reopen to open the application again. Click Report to see more detailed information and send a report to Apple.

> Ignore | Report... | Reopen

How can this be fixed?

***

OS: macOS Sierra, Version 10.12.4
Git version: 2.11.0 (Apple Git-81)
