Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BC9A1F855
	for <e@80x24.org>; Wed,  3 Aug 2016 10:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536AbcHCK0n (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 06:26:43 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35120 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbcHCK0m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 06:26:42 -0400
Received: by mail-wm0-f45.google.com with SMTP id f65so441945283wmi.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 03:26:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vrnjAfbaX3q9T7JTF6UhX42KCDj9TW80aZNXUVVSl1M=;
        b=P84rA1Zxg3UqB3JLlb1nGa38+4t5KD+/b2o6HkKP7BC6WROaYJEJ+z6G5uFTq/MtWa
         GSmFKFTj4O0z1rA3JkDdoWxN0H8WLymJh4utzgj8pMl+Df5kwpA4fEz4mQwr/kOZkS01
         aXNbl4Pwu82L+yx4az/2cqlAgCKOOaHUP5dAVO0tto1j+CvJy3mXkkzV/1TCCo7f3GgS
         ScKaM5v77g3zpMJrB7PtI2s508fJpCloWWkbFBfoMgq4rd3NmIXNHZnAvauF6Yuqxe1X
         d7jaHbKmJF3AvoE9SQdN7kcqKGloh0NUr61sorRI6xY2LGHkKOOqsoJrcViLOJxu8cVu
         /qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vrnjAfbaX3q9T7JTF6UhX42KCDj9TW80aZNXUVVSl1M=;
        b=gaabr1S5OAxFzZ19qGQNX62+bCO3ilNS0spl/dW6R9WMZhBLPTHBH1VnsiU0Ty+xEJ
         Q4RBSTjPA+2dPI6JNfUFoZwNVQG/hHTLQpoESND0LT2JJwrrU6jgsEPFX9/8MxbPqchT
         bUu6fgqfvh30ZbwkQ3B4je1fHmNTxs2GqbGlU6MPXN+M9pVKZR5KI6WokZSP3TdsFvoq
         HZ1vo4rSqEPgXJTTAnIJiTrQK35sf3HRfz9Mh1hdqdY901fUUUMYYKpdmieOTzj/lbIr
         c7i3ikgBdSKgmleBTb0+5oxSh1NXJ2MOmth2o5lnbIa6mjMWVaVwzCrG6hRLFIUCWWzY
         Blig==
X-Gm-Message-State: AEkoouvObIojYaR+XwRPSfvVOmZ4K/UilsS8JyXaQuC7+YTBoNy9Va3HdH8bktkh+uAvNA==
X-Received: by 10.194.83.98 with SMTP id p2mr59900693wjy.134.1470219519384;
        Wed, 03 Aug 2016 03:18:39 -0700 (PDT)
Received: from [10.146.248.58] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e10sm6970017wjc.21.2016.08.03.03.18.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 03:18:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: 2.9.2 test failures on macOS
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <C4207508-629B-41DF-8E89-CDD1989BCF2E@macports.org>
Date:	Wed, 3 Aug 2016 12:18:37 +0200
Cc:	git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <88BA92D6-305F-4B23-ABD2-55A6145F22D9@gmail.com>
References: <C4207508-629B-41DF-8E89-CDD1989BCF2E@macports.org>
To:	Jeremy Huddleston Sequoia <jeremyhu@macports.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 09:35, Jeremy Huddleston Sequoia <jeremyhu@macports.org> wrote:
> 
> I have two test failures to report in git 2.9.2 on macOS:
> 
> 
> t3210-pack-refs.sh has not changed between 2.8.4 and 2.9.2.  This test passed fine with 2.8.4, but it now fails with 2.9.2 at:
> 
> not ok 26 - retry acquiring packed-refs.lock
> #	
> #		LOCK=.git/packed-refs.lock &&
> #		>"$LOCK" &&
> #		test_when_finished "wait; rm -f $LOCK" &&
> #		{
> #			( sleep 1 ; rm -f $LOCK ) &
> #		} &&
> #		git -c core.packedrefstimeout=3000 pack-refs --all --prune
> #	
> 
> ===
> 
> t3700-add.sh recently added the 'git add --chmod=-x stages an executable file with -x' test.  This test passes when run as a normal user but fails when run as root:
> 
> $ ./t3700-add.sh
> ...
> # passed all 40 test(s)
> 1..40
> 
> $ sudo ./t3700-add.sh
> ...
> not ok 39 - git add --chmod=-x stages an executable file with -x
> #	
> #		echo foo >xfoo1 &&
> #		chmod 755 xfoo1 &&
> #		git add --chmod=-x xfoo1 &&
> #		case "$(git ls-files --stage xfoo1)" in
> #		100644" "*xfoo1) echo pass;;
> #		*) echo fail; git ls-files --stage xfoo1; (exit 1);;
> #		esac
> #	
> # failed 1 among 40 test(s)
> 1..40
> 

What OS version do you use? Can you run `sw_vers` in your terminal and share the result?

Thanks,
Lars

