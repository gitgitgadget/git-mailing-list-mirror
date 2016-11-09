Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4832021E
	for <e@80x24.org>; Wed,  9 Nov 2016 22:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbcKIWzV (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 17:55:21 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36531 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754615AbcKIWzU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 17:55:20 -0500
Received: by mail-yw0-f174.google.com with SMTP id l124so222701565ywb.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 14:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=sDFMr/G52DTNT81oBYE5V13J4+jVZtUX2Pvoj//Bfzw=;
        b=mmo2npUBLZk1juJft6gm4rntOK31S4km9qfDPaQX0DpL5rbxaTuy3ZHgHEaDc5XXi5
         fSKwgHW9bM6nmfTZQQ9g7p12gRVd6dXXFRS6Qapyj8v6LPc9fpUKnRaKrkSMLng1EAUG
         CkVIiLlXxtLsRst2HnBwsiOwp/z5h2U7XTXCG/TYVytRstUNzG0Qwe/VczWRR4/GKIHB
         vslVrNwcwT+02im3fiFWIn7jPNJDkCzPkqCx2qFjUm8NJ4eSxnREbpP6i5Ht0n57Qkbx
         o4p93VH6kA7hgfyzxIe6qMZFV73pxIxaPUXTat4WLas6NQi/+8LdEJ7ow12BgDlLy5Xf
         RWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sDFMr/G52DTNT81oBYE5V13J4+jVZtUX2Pvoj//Bfzw=;
        b=JIVTLPYYrL5ZlfkrXOTg1y/X0waS6RzeUegJ3J/S1EUiB3SaGogVX37SNRHKFjrfrQ
         Ta0diAxK6OM7hyRRqd4hK+JSWxarrgM0xlni+FGdbIZvPHMWsUBlCeezTK9FuQu1ylYV
         TMOGlrjH6rhNK6sjAXXEUSyrED/FtBHCOq3OoIn8vvfLki3sfBrNtG2vV/FYwJtX01yT
         IA0EZyr3FwPEBWfS5tN3sFNg8Qm/P+Aq8IFrHXVEJW/0nXkj480yMxQBz9Yk7Dnln88V
         5QIbQqEZXjzUOWVFjBwNo/5hWtUiSWm9/rU2pl0I0DYGxXV5gqtsnhSeMC36ykynjOMc
         NHPg==
X-Gm-Message-State: ABUngvc3H8PTJLnSL8qMSTBxrkwIqEaGkcmaDiz/HRSRHWVsYFKsZn1NZSlzTfIjTMMT+ln7RhbwKJgI6tOvkw==
X-Received: by 10.129.157.211 with SMTP id u202mr2126417ywg.178.1478732119902;
 Wed, 09 Nov 2016 14:55:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.50.18 with HTTP; Wed, 9 Nov 2016 14:54:59 -0800 (PST)
From:   Mike Dacre <mike.dacre@gmail.com>
Date:   Wed, 9 Nov 2016 14:54:59 -0800
Message-ID: <CAPd9ww_B7gCxvSuuBzH9AbnLsOF1bC_2+mfk0sVfLFF7YHWvNA@mail.gmail.com>
Subject: git mergetool indefinite hang on version 2.10+
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have no idea how to debug this. As of git version 2.10.0 git hangs
indefinitely when I run `git mergetool`, the result is the same if I
run `git mergetool --tool-help`.

The result is identical regardless of which version of vim I have
installed, or where vim in installed. It is also the same if I remove
my .gitconfig file.

I am on Arch Linux, with all of my software updated to the latest
versions as of this morning. git 2.9.3 and lower works perfectly.

Any ideas?

Thanks,

Mike
