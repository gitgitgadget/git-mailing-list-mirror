Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_HEX
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E3B20A26
	for <e@80x24.org>; Tue, 26 Sep 2017 14:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031128AbdIZO6a (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 10:58:30 -0400
Received: from n2.nabble.com ([162.253.133.85]:57607 "EHLO n2.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031076AbdIZO63 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 10:58:29 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Sep 2017 10:58:29 EDT
Received: from static.162.253.133.85.macminivault.com (localhost [127.0.0.1])
        by n2.nabble.com (Postfix) with ESMTP id 44EAF1B5C15B
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 07:51:52 -0700 (MST)
Date:   Tue, 26 Sep 2017 07:51:52 -0700 (MST)
From:   bcampolo <bcampolo@mmm.com>
To:     git@vger.kernel.org
Message-ID: <1506437512234-0.post@n2.nabble.com>
In-Reply-To: <CADmzSDHbH-=bX=PFqvoe23iQPF7Mq6ogV7D9c0XjdXUsORgmBQ@mail.gmail.com>
References: <CADmzSDHbH-=bX=PFqvoe23iQPF7Mq6ogV7D9c0XjdXUsORgmBQ@mail.gmail.com>
Subject: Re: git config credential.helper with absolute path on windows not
 working properly
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My situation was a little different, but I was able to get this to work with
some interesting escaping.

helper = !"\"C:\\Path with spaces\\executable\"" --option1 value1
credential-helper $@

Notice the exclamation, quoted path of executable and extra escaped quotes
inside of that, plus escaped backslashes.






--
Sent from: http://git.661346.n2.nabble.com/
