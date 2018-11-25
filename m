Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D770E1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 22:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeKZJPA (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 04:15:00 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39832 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZJPA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 04:15:00 -0500
Received: by mail-wm1-f48.google.com with SMTP id u13-v6so16489455wmc.4
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 14:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jPv5rXQyQi4slz2HhN6R3aDy5Y0FWbQnseY0IbSNzuk=;
        b=Lt0H/I1vx+53P0s/r2Rj59fv1NFGvPZKPhBjq4t7n8l6MXXRFhGlXFBEs+6PDt2iB4
         ikC6sgoA/6vGnQi2/zsxsanRi1rlbOkh06dKc38qDQjbbWDzyDo/t6L43Zd7BDpOvtpr
         /EThyYmk4PcJGyM4bHQz+YRhDmKGKoOAOP7SLGU/3MjG76ZkDZDx5v+UZsO+cnS0DQ/e
         YkYrd+1vNILi64c4odnh3zPCimiZWlL8E80PWg4wFyFodsogSz/zHN3EFyL5IFj/LPTg
         oCdCSWlXzYtL5QKoMUe6/vsX20VWy5XEnmun7e+VeDjbVsC9aNp9RQ+6S7Ky6HeBKUYK
         Rieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jPv5rXQyQi4slz2HhN6R3aDy5Y0FWbQnseY0IbSNzuk=;
        b=ap6VVcU8gjz1pT65O4gQhrxZ57tovN7FXRByG69o7Ga3WymxT+XORfv7O29hd45Ggr
         e72IzcuX7v8sNjW8vaj01S41AbtT1Jv3WzHnWyo1kDquacujdtkt/YY9YZPoGzugE0Z0
         9mYyRRT/Kq0jFDZsHjf5WVmx/mnfC242oRXMsxIhdkCnxuFptbXzEYw/nTnSjKWrWTaO
         X9QS3qHUU2XDz5LM8bMBkILl6JBdL2bO8uebrW76MF1pwtmXqVNBtUha25M68C4btaPn
         cXeT7Fee/YgpzJPcIuA669G5Wp+ZZcDq+B/8UAR/Up7tCMwOyPOrTAsixFODe3W6AdPU
         LP4w==
X-Gm-Message-State: AGRZ1gIGSBulbO2TRNhtesxrTQronrGtuZ/JqH0q6BWe735tWYpERlao
        ap4RChYRiiU3UUkLBgTb0yc=
X-Google-Smtp-Source: AJdET5dJbb0lizb9Yg3T083zgOwj6TomMBDE5i2PbZGtK/mI+SAjjBxhSUmmq1C8fp4DJZXREmhq4Q==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr21455505wmi.61.1543184569829;
        Sun, 25 Nov 2018 14:22:49 -0800 (PST)
Received: from szeder.dev (x4db1dd4b.dyn.telefonica.de. [77.177.221.75])
        by smtp.gmail.com with ESMTPSA id x77sm19692944wme.19.2018.11.25.14.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 14:22:48 -0800 (PST)
Date:   Sun, 25 Nov 2018 23:22:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: t5570 shaky for anyone ?
Message-ID: <20181125222247.GD30222@szeder.dev>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 25, 2018 at 09:52:23PM +0100, Torsten Bögershausen wrote:
> After running the  "Git 2.20-rc1" testsuite here on a raspi,
> the only TC that failed was t5570.
> When the "grep" was run on daemon.log, the file was empty (?).
> When inspecting it later, it was filled, and grep would have found
> the "extended.attribute" it was looking for.

I think I saw the same failure on Travis CI already before 2.19, so
it's not a new issue.  Here's the test's verbose output:

  + cat
  + 
  + GIT_OVERRIDE_VIRTUAL_HOST=localhost git -c protocol.version=1 ls-remote git://127.0.0.1:5570/interp.git
  b6752e52dd867264d12240028003f21e3e1dccab        HEAD
  b6752e52dd867264d12240028003f21e3e1dccab        refs/heads/master
  + cut -d  -f2-
  + grep -i extended.attribute daemon.log
  + test_cmp expect actual
  + diff -u expect actual
  --- expect      2018-06-12 10:06:50.758357927 +0000
  +++ actual      2018-06-12 10:06:50.774365936 +0000
  @@ -1,2 +0,0 @@
  -Extended attribute "host": localhost
  -Extended attribute "protocol": version=1
  [10579] Connection from 127.0.0.1:45836
  [10579] Extended attribute "host": localhost
  [10579] Extended attribute "protocol": version=1
  error: last command exited with $?=1
  [10579] Request upload-pack for '/interp.git'
  [10579] Interpolated dir '/usr/src/git/t/trash
  dir.t5570/repo/localhost/interp.git'
  [10462] [10579] Disconnected
  not ok 21 - daemon log records all attributes

The thing is that 'git daemon's log is not written to 'daemon.log'
directly, but it goes through a fifo, which is read by a shell loop,
which then sends all log messages both to 'daemon.log' and to the test
script's standard error.  So there is certainly a race between log
messages going through the fifo and the loop before reaching
'daemon.log' and 'git ls-remote' exiting and 'grep' opening
'daemon.log'.

> The following fixes it, but I am not sure if this is the ideal
> solution.

Currently this is the only test that looks at 'daemon.log', but if we
ever going to add another one, then that will be prone to the same
issue.

I wonder whether it's really that useful to have the daemon log in the
test script's output...  if the log was sent directly to daemon log,
then the window for this race would be smaller, but still not
completely closed.

Anyway, I added Peff to Cc, since he added that whole fifo-shell-loop
thing.

> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index 7466aad111..e259fee0ed 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -192,6 +192,7 @@ test_expect_success 'daemon log records all attributes' '
>  	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
>  		git -c protocol.version=1 \
>  			ls-remote "$GIT_DAEMON_URL/interp.git" &&
> +	sleep 1 &&
>  	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
>  	test_cmp expect actual
>  '
> ----------------
> A slightly better approach may be to use a "sleep on demand":
> 
> +	( grep -i -q extended.attribute daemon.log || sleep 1 ) &&
> 
