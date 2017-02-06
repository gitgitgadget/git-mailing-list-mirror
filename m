Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA971FC46
	for <e@80x24.org>; Mon,  6 Feb 2017 08:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdBFIuJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 03:50:09 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:38567 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdBFIsh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 03:48:37 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so52405764itd.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 00:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wZz8yyZtONMEaP68or0JfZQ7gX/7ebv5VdYFnG4i5L4=;
        b=BOaYUx9nKx1EO6N8zsEjai1DkZy8wdOTS7+VCazxDIva8ihs+ZWi6iUZeThlOLxinU
         gQvD6IInlnzEYfLqQxuCJtbPvsv0yRSv1ET8XCzQJmArHx/pUwhMbC90NyRgkVK5Ziqt
         VgiUJzuEB8lzIhDaynwRNJJR3epNDFqkReSMtIiQIT7kyC/NJAKupxZ3NmG3Pno+1uLZ
         8am/uqDUYDzoETGMa+W1ekWIw74fhbKCUAUMgI2MfBU2n6w3KUSYJN6jHT14t9hlfZNC
         2DJK99yf/qqOqtndQUc+ZIAYMnGIAIV1kSj8dcXzPSP4ylFMCEV+YJcq2e1uWrVSe9LL
         JC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wZz8yyZtONMEaP68or0JfZQ7gX/7ebv5VdYFnG4i5L4=;
        b=Q43Uy6eSe0em2C+3jqvPPRJ46rSpese0jUoM3QisRIo8zIG4q4JvAgmbqbdjFu571b
         cLmvxu55pp/4lCHZxycuSobUKYYWqTc1buL1JNI4nKY7J4NfU0o9O3Wv0RHHbjDVpb47
         76WvBC7k7NfD4w/Sk7QWAepGnHuCHzTC54jnjg9g6an8z6DIyy9hYFlYTio6sFs0YdM/
         Xl1J7cjy+b/lTPg+L9LJroCkhOi43crwdxnI+aJvK08p5Ukn1CLgzDDeFLJoJG2W9MpF
         KFM9+z7A0lNLcgsWTClDZ2s1bU1EhVW+IDOtf0Wv/IJmiJMNFxwj5UEVPPcQ2gmev2z6
         W/Pw==
X-Gm-Message-State: AIkVDXJQeZN+2C0TT7hzZvUbVb3fmI2kmg/Nn4s3X2FqncDfucWmTfkzK8DHzs9WObj3wyOMrBbo76kyEcGnaQ==
X-Received: by 10.36.189.200 with SMTP id x191mr6620417ite.123.1486370916979;
 Mon, 06 Feb 2017 00:48:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.12.223 with HTTP; Mon, 6 Feb 2017 00:48:36 -0800 (PST)
From:   Stavros Liaskos <st.liaskos@gmail.com>
Date:   Mon, 6 Feb 2017 09:48:36 +0100
Message-ID: <CAEXhnEDW_s5vGKmLA8ie63FivFYwtCASyaD_Sowjj3e5U9wp_Q@mail.gmail.com>
Subject: subtree merging fails
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Please check this issue for a description of the bug:
https://github.com/git/git-scm.com/issues/896#issuecomment-277587626

Regards,

Stavros
