Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09FFC2101D
	for <e@80x24.org>; Mon,  4 Jul 2016 23:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbcGDXar (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 19:30:47 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35528 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbcGDXar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 19:30:47 -0400
Received: by mail-pf0-f176.google.com with SMTP id c2so64549845pfa.2
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 16:30:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Thni7N5Ok13mpyysVC72Fv2YgNwVJgo+SaULQCFUTM8=;
        b=iUMn/KcysOyz8lKgZ3pay/UhS+dsImge0GP6HV/z7W/ol8Wo5Mj2aFTJOfbMG81YB2
         qP11Fqqkq4uXZj5uN8Lf2qYqfKhcm629yEUmY2BAmuLuREoJ9EUtUi35aSuHXiK5QpzN
         7/MjXiGEDzLFmI3+n1KKG2zkedqDwYx9UJOAVsQJj6uIAI6SY6kb/oYHt4VgzFGT+3G+
         6FhZ0/hKk1kUvOKf0hK59xkc/Pn3XHFi9P1DFiwNd/duyyVZeQYqhLtyw5ZxUuB8u49x
         cZ+fe11levyrq95C9foaGSPNxIr9oXsATANsbQ4yov3cIPk24DPfHqKCNVAUacW1Oy6f
         PUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Thni7N5Ok13mpyysVC72Fv2YgNwVJgo+SaULQCFUTM8=;
        b=VxRFrlp8Uu84RuUOS7rOQLtBJzagh2uu3G3eMVBtR8BsOoSlTZypc9SHNzd/ft5Fo2
         7u6Klyil2XUQD5cUOFPyT82mfqHbHTkhs0g4TQHutqqS7exP2sPPwG0rh7HFdOOjBkfJ
         ZiGwJKJoG9nZY6hKipBJAEejTUOQYOMV41PruXUeRAg7h1Zq2RFox7jyWTiDsRhtMwHt
         BmCAsPqCo+3+zuFhnUJ/d/6oONjGWCWig0+HYbLQ0hIMl9LOHgn7e/W2cErV6yCinU/q
         daTQXFZiPl8F2FNbLK29fxjut1b7uiDv+VqrK6lgpNDZZ+QrepTK+a+5AkNddQW5J7lp
         58Eg==
X-Gm-Message-State: ALyK8tJPYYMYHcD3AOecDTvT75DXkaK3kDhPbMCtPn/5fniwqUvXwRmJ/g6amZProgJ4QR3Llg0f6Q8ncg786A==
X-Received: by 10.98.59.150 with SMTP id w22mr27158100pfj.4.1467675046370;
 Mon, 04 Jul 2016 16:30:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.66.126.147 with HTTP; Mon, 4 Jul 2016 16:30:26 -0700 (PDT)
In-Reply-To: <87eg79qcld.fsf@linux-m68k.org>
References: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
 <20160704203946.3ac8d3205c08bfaee9a93a46@domain007.com> <CAH_OBie4dUB8WXfmKhLaezVKi0=LhnFw=wKJO1c3oUMA7VkYdw@mail.gmail.com>
 <20160704212926.919a267706a6fa5791c47726@domain007.com> <CAH_OBieUYZTi+8W-m1TVVDstzF2vg1VuYQsd9Ka_uDoRYRY5rg@mail.gmail.com>
 <87eg79qcld.fsf@linux-m68k.org>
From:	shawn wilson <ag4ve.us@gmail.com>
Date:	Mon, 4 Jul 2016 19:30:26 -0400
Message-ID: <CAH_OBieNO-fSW-ncsezZ5KG2c80fY-rUU6OPGgw0RJMGcpi+KQ@mail.gmail.com>
Subject: Re: split directories into branches
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 4, 2016 at 6:10 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> shawn wilson <ag4ve.us@gmail.com> writes:
>
>> $ git filter-branch --tree-filter "shopt -s extglob && mkdir -p
>> cookbooks/base_sys && mv !(cookbooks) cookbooks/base_sys"
>
> extglob changes the parser, you need to set that on a separate line.
>

by "separate line", I'm guessing you mean outside of the filter-branch
eval? Something like this?
shopt -s extglob; declare -a f=(!(cookbooks)); git filter-branch
--tree-filter "mkdir -p cookbooks/base_sys && mv $f
cookbooks/base_sys"

(don't have access to the repo atm and am curious if this is what you mean)
