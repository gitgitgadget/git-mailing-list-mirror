Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0432070C
	for <e@80x24.org>; Tue,  5 Jul 2016 21:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbcGEVzp (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 17:55:45 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37008 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803AbcGEVzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 17:55:44 -0400
Received: by mail-it0-f48.google.com with SMTP id f6so93086981ith.0
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 14:55:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=AgqzeDGZ/+Qtm/madl/GFESoqBgYDmD8mwsbQ44xwI0=;
        b=Qk1tBjdRjgWgKQM01O4I6R5PjIpNdnpDM8YTbORbFrqcK+fMlZ/YURQ7okzz1QvEQt
         BtUS8lc0Iy9EAB6lQLMRb840psTSL1b/cHtuPCv5rpv9OCQJ/ZY/+bxeFoOTJNYNMnIS
         2m3FT958AydQ+cR9cz26IyppXwyTpoD6LaJvef7rEOwxH0IE0+gzPYQjHfs67KELKw3k
         evHZu1aPVUW5vTNpIqy65pY691wB4H9qrN6Whm6NyW3DD3BEYnvJQr/1qg/8UKVFfzqd
         u95ewmBpF2y5SEPqyhWds55ysnPyqH1gWgDxoQj40Q36FgypldqeVEjpB7dNtVjpMQM5
         nwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=AgqzeDGZ/+Qtm/madl/GFESoqBgYDmD8mwsbQ44xwI0=;
        b=ky794LjtbtbBSMBGoFBBBaXWjdNk8O+pW15EO7GWNzxzi5zcoz/eSeE+c1/E5rgfiS
         DImntyOBIVOIzKUFXQfDumJ7CfEGXpvc1mfBoDglKuRga4dNdWJ8ONCOzeFqUNZut2Ps
         FBeew6nKKRlyriyfjYq+JVX1aIe57MMozjHBO5kslFc4QHrj+GrTdnom+3WMMat5lEng
         a5r5KmGSbpyd5WK6YGHaQ/sFLS7yaMChfFAI9ZoZ831jPjx1dIJ9UsZnXXjXFjJ16Xd8
         BHtJS9ztx4LLsqA1g6CpCywGTe9Kz2cBAupx/84wiebCGdLIMQM4zMXj4Mq1fuv0qjue
         vtUQ==
X-Gm-Message-State: ALyK8tJGPJcNLJ35WlxsoGJCbRIsOt7+5IDJlM2JR9u1iID5IZZ3SSaZsOrcx2GKWC3UgTT0BBJsp4r+tbi8zg==
X-Received: by 10.36.65.29 with SMTP id x29mr211541ita.21.1467755743828; Tue,
 05 Jul 2016 14:55:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.12.216 with HTTP; Tue, 5 Jul 2016 14:55:24 -0700 (PDT)
In-Reply-To: <CAK8tuqiZjfrvHCoxkFUqoDx0+9=FUxfE93aMhUkYYZAAWm-u_w@mail.gmail.com>
References: <CAK8tuqiZjfrvHCoxkFUqoDx0+9=FUxfE93aMhUkYYZAAWm-u_w@mail.gmail.com>
From:	Peter <peter.mx@gmail.com>
Date:	Tue, 5 Jul 2016 23:55:24 +0200
Message-ID: <CAK8tuqhMiHqPoK4gk7onT+VXsLJE5ogcpu7dc=_8am+ifL=5yQ@mail.gmail.com>
Subject: Fwd: git rm
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Greetings to the community of this wonderful piece of software!


I am a lightweigt git user so by all means not a reference, but I was
wondering why exactly does "git rm" also delete the file (remove it
from the working tree). I see it as an unintended behaviour as git is
written in a way that it preserves the most data. Usually git commands
are very basic and the usual workflow requires more consecutive
commands, it even has its own shell. But "git rm" does everything in
one step even though there are lots of scenarios where the file should
be kept. I am aware of the "git rm --cache" command, but from my
perspective "git rm --delete" is the one that is needed...

GUI users and some CLI users (by using trash-put or similar tool) also
use trash before removing the file completely. Does "git rm" support
freedesktop.org trash specification?


Thank you for your answers in advance,
Peter
