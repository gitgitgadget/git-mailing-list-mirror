Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 576CA1FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 18:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbcHTSU7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 14:20:59 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36720 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbcHTSU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 14:20:58 -0400
Received: by mail-wm0-f53.google.com with SMTP id q128so71354361wma.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-transfer-encoding;
        bh=rWg8QlvW/Snx1OT4P7JBJ/yXtE7Ic3HUULwCUQMVnxs=;
        b=lHTVb1J+pke3VwKniT4+R3kYEnvwb1uXhX5Z3JQ1Jo1OJ92ZXRabVFPqdAiMP8y+nN
         OgHKbchveOnc8qEQz3tHSreQjvP7l+7/JCJVwn1eA9UxQW8qTQfkvp10+NmWzqBan1BC
         TgaXHYnTv58yItyT2HGNG+7gtJj4fgcFVhrENoRrY62m99i3Lah/wqgNEMfu3Brl7VvU
         XL/sliax/GRAjZ/MVazWZvMYgDR0ikVe8UhSQMUPYKGeLfGibJlrwFwtn5sZl77FXq/b
         pUcNw8c2TjpHWAWXWqbdgMVlUGcUq2h4REeep+ATM2U7W/zGFZWHPvRQYLdeAtD8nBTO
         epbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-transfer-encoding;
        bh=rWg8QlvW/Snx1OT4P7JBJ/yXtE7Ic3HUULwCUQMVnxs=;
        b=QsoAO8YIqo36UcCBjK4kUJiDnBCwjQ0QpgLZUo6ygVF6gk05EPdO9lNKkzgWuQqi5O
         sGArrOcYltxZmV+jKfoQyMmBH894rQDcpTuIMXpZT1AUIPp7OUAAuwOLUbxYHRRHQsqL
         6i1eA2qXA9BNrhKpqizsKkSjLNWyWQP0gILU6psGCLcv3EPTbL+WNp+/GazLwn/CxHuW
         lFrLoQkqMJggkk7x5W4yJMzrdKeC+0zPIEA43d2euxMuKWTzusJPIRkaPtY8KxTIVYCq
         kHxcz2Zq8mBd+bgUoVNWvROnFhBhLdLoa8Wo+yxPVytL0yZaQ1X3WXLFQSh3psujBBKg
         Mllw==
X-Gm-Message-State: AEkooutBjxjR2VjXHcd+xziZ8Nx10xx7nh/qag//eaZbZ8OH9ynkx8xi9mggqkzwTGq6zw==
X-Received: by 10.194.63.39 with SMTP id d7mr10712505wjs.13.1471717256659;
        Sat, 20 Aug 2016 11:20:56 -0700 (PDT)
Received: from [192.168.89.2] ([104.131.203.210])
        by smtp.gmail.com with ESMTPSA id c139sm10666777wme.4.2016.08.20.11.20.55
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Aug 2016 11:20:56 -0700 (PDT)
Message-ID: <57B89F83.8060001@gmail.com>
Date:   Sat, 20 Aug 2016 21:20:51 +0300
From:   vi0oss <vi0oss@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Icedove/24.8.1
MIME-Version: 1.0
To:     git@vger.kernel.org
Subject: Proposal to add a shortcut for --force-with-lease
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"--force" have currently two shortcuts: "-f" and "+", hence more ergonomic.
But I expect it's better for users to use "--force-with-lease" by 
default for overriding
remote branches (e.g. cleaning up a pull request), as it rarely fails in 
normal situations.

I propose adding some shortcut for "--force-with-lease".

Options for a shortcut:

* git push origin =HEAD:master
         "=" is like "+", but weaker ('+' being typed as shift+'=')
* git push -l origin HEAD:master
* git fpush origin HEAD:master

Unfortunately hijacking "-f" to mean "--force-with-lease" is not an 
option due to scripts.
"-F" is also bad choice because of it looks like "-f" with even less 
checks (like "git checkout -B" instead of "-b").

Additionally, message when doing "git push -l" or "git push -nl" may 
show the range of commits being "thrown away".
