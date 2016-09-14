Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896F8207DF
	for <e@80x24.org>; Wed, 14 Sep 2016 11:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761702AbcINL0W (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 07:26:22 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35040 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761690AbcINL0V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 07:26:21 -0400
Received: by mail-wm0-f51.google.com with SMTP id i130so43113961wmf.0
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdZ/z+K4RNgFTtw8B49lsw/zcE3l9Ay94BGmGRfvT+I=;
        b=0xEYsq5P6ITjoD8JbiDNDQ2nfT3kbzKa0K4RU8dcQLJsUecdQjdzABBTyxKWxMQXB5
         CYczyFbTbL9R138KxyOhU6t4I9bT05wW8VdBOH4AHyoQG8FrM7u5uVmSy50YygXtr8aG
         DH3rUyEZRsBKCLJxk5PDDpcuvAMBN4tlEmS5JQ4fR9USvXBmLk8VNXVttDUIt5hVJ/Xs
         piJ6AymU0oAYGBJKJGZ6kRIrHaoE1j1nOW+0D5kpFCpHPZPOdRJ9dZWcot+hWrgrmIPs
         jC0I0vVcZhyV4BRhmE0cAf8vxJXMcDr7yitaFa/LKtKA1YwoQNcTjtkTHsp3mc3E6Ou6
         WTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdZ/z+K4RNgFTtw8B49lsw/zcE3l9Ay94BGmGRfvT+I=;
        b=fc1Fo9yvyOSNwll0EDXemmKoLtyd/U1yDKROrInZEo2DJUI8uh2rBDT3wSVGvy8Pq6
         KyP+IZrUQr7ED5vEGY1EPo3/PJFmwbl1QJExXtxXYjwBuXM4Dic0HJx5FiPKk/8t5Jqw
         U/k/+UTeFBiRWonLbCFKfsdZQ+No3yx9dQ4DlNRJ/v8IFW6TH/q76z+hk71fh0SDfT9H
         5J4D21OBNQtAbshYZVwCCNGQ+/QjnSac7PTFCRr4zVL6NB1NnmkgMqAtjnQuo+HEQ7Qc
         xRrG2XDM5Hg5PLVN8tisHZpgC+MBujgWwZn6l+s6XZbErVEj8KZLxwRJ9I4fYQD1m8/I
         Qu+g==
X-Gm-Message-State: AE9vXwNYlQ/wxDXJjUf9FWq8bzd4O+nIlF158HUagyLJ265MqAPNbFWqv4QlTPRBCdwkgA==
X-Received: by 10.28.207.73 with SMTP id f70mr2466726wmg.29.1473852377968;
        Wed, 14 Sep 2016 04:26:17 -0700 (PDT)
Received: from [10.156.63.164] (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id u64sm10265144wmd.20.2016.09.14.04.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2016 04:26:17 -0700 (PDT)
Message-ID: <1473852376.30531.20.camel@kaarsemaker.net>
Subject: Re: Git Ignore Exception bug
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Nathan Williams <nwilliams@sofi.org>, git@vger.kernel.org
Cc:     Eric Severtson <esevertson@sofi.org>
Date:   Wed, 14 Sep 2016 13:26:16 +0200
In-Reply-To: <CAC5iUd2mS1n1=sRB=Bs6tn3L3raAXrZaEcs765UFtQZB9XZuYg@mail.gmail.com>
References: <CAC5iUd2mS1n1=sRB=Bs6tn3L3raAXrZaEcs765UFtQZB9XZuYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On vr, 2016-09-09 at 15:39 -0600, Nathan Williams wrote:
> it ignore doesn't seem to be working properly when adding exceptions.

>8 -- snip testcase

> Expected results
> % git st
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 
>         foo/bar/

That expectation is wrong, it should show foo/. And indeed it does
(tested with 2.9.0 and 2.10.0-rc1)

$ sh -x testscript
+ rm -rf repo
+ mkdir repo
+ cd repo
+ git init
Initialized empty Git repository in /home/dennis/code/git/repo/.git/
+ echo foo/*
+ echo !foo/bar
+ git add .gitignore
+ git commit -m Ignore file with exceptions
[master (root-commit) 7e1b82a] Ignore file with exceptions
 1 file changed, 2 insertions(+)
 create mode 100644 .gitignore
+ mkdir foo
+ mkdir foo/bar
+ touch foo/1
+ touch foo/2
+ touch foo/bar/a
+ touch foo/bar/b
+ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	foo/

nothing added to commit but untracked files present (use "git add" to track)
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net


