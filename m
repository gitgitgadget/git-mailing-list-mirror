Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CAF202AE
	for <e@80x24.org>; Fri,  7 Jul 2017 01:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbdGGB66 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 21:58:58 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36740 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbdGGB65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 21:58:57 -0400
Received: by mail-pg0-f65.google.com with SMTP id u36so2210625pgn.3
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 18:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=mw1Rgqsy3aPAknPMC3DVsmD1cNDWKUQqEciKCbXmIMg=;
        b=D/VjvEMndkmpB+RtSegopuhD/v7NTsrD6DqVOgIyKoPAqEosdN5T3bojFwUmvt1bvx
         VerD8bulmY6ZkVdyRWXWcX4p19Ys5soz4Y6VPNVSqKTCf7tEE0llV1L6R7OT1b4Qxd2u
         Dr65eKqVGZ5SHnct4yWNa1pSNgKolphbZQNkwUUDocmY25rnH+psEt/oDLLp68bKTZht
         9vgLcPDgADcHx4Pz7sYpgGTeFQ9iLKPWDwPSDvJTJCDLe1kU6i53WgxGyLY6/9D36iMW
         AoNW0lE1RSj5U4RQLjwYDpPUvqSaQJELNfwplxhXQRs9omtwyXGKdXoy4wngbAMnWmdd
         fZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=mw1Rgqsy3aPAknPMC3DVsmD1cNDWKUQqEciKCbXmIMg=;
        b=MfiofwP/2BZuxWgol1GlZxt/2Isay+NKkNvvIf5eKQ8RRTls53ECIcI/rxoSH7jE2Z
         XNhmfw0z0nIhBXLaGc+Ern8iQZz7YNRdVs/7gkz1xA0C1urRxT4uBZMYGfcPILgWpeyJ
         7KHZrv+EJ+/uEI7Qq2dQjqlr2cbBgXHnUfywr3nBFN6hK+nPeKqmfPzdL+5KCcRwCL++
         U1m4IYK80H5+NEV4W6mYRjsDtLJaj440gULnlMQLAoqRWQYn9HBmOHdEJVMs5OHcrr1I
         UA04zTlaZqayhK71SvVd/lHBMQz4sNVF2uhsEyMa/NQOF+yqm67P/43MVpb7A5Mli7ZO
         6kRg==
X-Gm-Message-State: AIVw1112EwkhQFw7DBKY/WxfpE75vhN61MPjpe9M2kHUICOyTA9zpEc1
        5CLe+0TSsHBqKQ==
X-Received: by 10.98.107.133 with SMTP id g127mr28629034pfc.202.1499392736909;
        Thu, 06 Jul 2017 18:58:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id v205sm2584677pgb.51.2017.07.06.18.58.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 18:58:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: [RFPR] please ping me with materials for upcoming 2.14
Date:   Thu, 06 Jul 2017 18:58:53 -0700
Message-ID: <xmqqfue9dn36.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I want to start the pre-release stabilization period for the
upcoming Git 2.14 sometime next week, please throw me a pull request
soonish if you have updates meant for it.

Thanks.


