Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2F41F405
	for <e@80x24.org>; Sat, 15 Dec 2018 13:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeLONCJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 08:02:09 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37865 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbeLONCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 08:02:09 -0500
Received: by mail-wr1-f49.google.com with SMTP id s12so7502329wrt.4
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 05:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wvIek5unEBqNtWKCSrM173JUdcTIol9PK9sMq5q4fJo=;
        b=ZvYu+a+GUQCtvX9brG+2zpvNeCFFzoJlGwyCV17jAhVwhGNll/MEsZilRgTFUUu9vQ
         RZFfKwukvWrA0BzuF6x0Ofj0mE/7uTSBP5CbGvy2N6y1rJT1sq5EQUv/+pKNc/OujY12
         VtT3AhtoC7gefAAHsv5a8sT42JNEexzWwaWycRpBqomXDVob23Zql3TgSKoItRv5JxlQ
         Zo4W0qxlYfV90cKJHYJ9ZUH7Ed6uV0JGves9Ja47iITVkyiBxD9ojanfFni5o8hRqH3+
         sk5O6AoY1IG9EkhmhhY/YddatnIZE0nx0AtO8EM7Mw9l8XqEWhj4PI2lnxLwrMUYOyQ2
         j7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvIek5unEBqNtWKCSrM173JUdcTIol9PK9sMq5q4fJo=;
        b=KTurj9ju8Qc5woerljcK3Fh5EGg5OGl36ntH/37nEQ57tEIqCW/zk0HFbiTt3Nen5t
         owqAOa9h8MHOpn2QhlWLbIB27uhRJ8LryvlcJtoF3OuCsusnl1szDbFjGhLBduGF+0LE
         eZFB5+6IeVY2U7KhQxib4Xx9X6T4AhLlY1W2CBsRSygS9Iz3MygGeVftD1FjtDOmneP8
         2SsPY6y+pAZ8+6b629hHbMzHOVWnVtG6Gb/zMWlXT2B4Z/yWLxTEr9u85h56mUUwrAue
         9L4apuDOltKbdk5QI7TM0Mx85aTHOJipLyq4bY+DqTCnfHIM9ymVAbjkZB2wlY+g0/bn
         4Kmw==
X-Gm-Message-State: AA+aEWZHT5wB1IZR8TZINQw1T/XQAVb5WWSgJ+u65r65lW2s5PdhxqH/
        a8Fxa703IJoGK1IQ1rTq8kW/cqlK
X-Google-Smtp-Source: AFSGD/XpLq0T8mA69i7Ee3ZFKwcAyJ6iVSM/YXGU1FRlfUrswK9ll09LNY4KOzxe5kW25OTHm41EbA==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr5210042wrs.86.1544878927303;
        Sat, 15 Dec 2018 05:02:07 -0800 (PST)
Received: from szeder.dev (x4db07a7f.dyn.telefonica.de. [77.176.122.127])
        by smtp.gmail.com with ESMTPSA id l37sm11103215wre.69.2018.12.15.05.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 05:02:06 -0800 (PST)
Date:   Sat, 15 Dec 2018 14:02:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Gennady Uraltsev <gennady.uraltsev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug in git-remote
Message-ID: <20181215130204.GZ30222@szeder.dev>
References: <650b15f4-5e13-7a83-9f2e-072efc4815e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <650b15f4-5e13-7a83-9f2e-072efc4815e4@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 02:14:56AM -0500, Gennady Uraltsev wrote:
> I am on git version 2.20.0
> 
> $ git remote
> 
> does not show remotes configured in named files in $GIT_DIR/remotes/
>
> I do not think that this is the intended behavior.

It's a known bug.  When 'git remote' was rewritten as a builtin
command in C in commit 211c89682e (Make git-remote a builtin,
2008-02-29) the parts dealing with remotes under 'GIT_DIR/remotes/'
were not rewritten.  I don't know whether that was intended or not,
but storing remote information as configuration was about two years
old back then.  Given that since then '$GIT_DIR/remotes/' got marked
as "This mechanism is legacy and not likely to be found in modern
repositories", I'm not sure it's worth fixing.  Perhaps it's time for
calling it deprecated.


> In particular:
> 
> $ git init --bare test.git
> Initialized empty Git repository in /home/guraltsev/admin/test/git/test.git/
> 
> $ cd test.git
> 
> $ mkdir -p remotes
> mkdir: created directory 'remotes'
> 
> $ echo -e "URL: /testremote.git \n Push: *:* \n Pull:
> refs/heads/*:refs/remotes/testremote/* " > remotes/testremote
> 
> $ git remote
> 
> $ git remote show testremote
> fatal: '/testremote.git' does not appear to be a git repository
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.
> 
> 
> 
> The second to last command should show testremote as a remote.
> 
> 
> Best,
> 
> Gennady
> 



