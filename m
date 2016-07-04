Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2379220179
	for <e@80x24.org>; Mon,  4 Jul 2016 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbcGDVEJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 17:04:09 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33168 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbcGDVEH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 17:04:07 -0400
Received: by mail-pa0-f52.google.com with SMTP id b13so61348915pat.0
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 14:04:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=olgKsrX9PRUpdUCmJ3kaKq9wmeCOepj7fKVt2rTPH3s=;
        b=SiheBekYjlfkWY8u4qPQWa1QZiFzqi6DshtvAsojqqcmDIwGN09JOKa38Xpr2irbMH
         +u97IowiWl3tdTHjW4Nx2OuOH9wUJaGz5jaTgqeHVGcXYSbbAWmfS00b+tLHSjJtYH4b
         cubBCCsD+xuEKcWxJ41NSQdM5oOlSXTZRQ8K1h5C/V+X15EjFZsGq1xJuH3a1iLBKyP4
         JVB7OfN88d8SrwFxFq1HLHXQCP4KEaB1G2WkfArkKB2VC4lGccWpwrXfcmPO9lMWvrcL
         DiC7nXBDqXh5QFk1kcVANyvJOfdD6BrHznjjQ9L5QP70SoFzVmDgNQfwA8gYFQUhmufr
         H2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=olgKsrX9PRUpdUCmJ3kaKq9wmeCOepj7fKVt2rTPH3s=;
        b=X78I4d/ZAii3hl7uijgZvC6Jo0HtCpzMh5JaRfFjIUnhh+Grwmha0F7AbDbTCLQJv3
         fG2tE/j9p+b1x0Ub5Gqv6iLD1u8AJ2qUQ/pWzVDF7s/+FMFmNyCrRKhRhHH/KYMVMmsC
         DhsYqMKFaneZMAVDlsKByCucON4u4vOaqZDtJZTxom5YsFmQrqVbXgEilsAAtMOvr6mk
         OiGm9gaKc+dMx4zbxrVJC3VFIKpL+wPa4ZjX5sTY+ke0moyKOtPH28I6E9Wj12tbjFHE
         yNz09PwO5HdjNPlwHMJQ0sGqauw0Q3mXJ6cK1alIrhAjFmHEB7Tx8pTgn7RwB4DcnNNk
         oOAQ==
X-Gm-Message-State: ALyK8tISGtqh7UJ9ljbJa8wRco11NrQ8LfhnmPMLwbVSa+1XeQoEVnoQDNUBhi2ED/sZSddsflyvboZnu71CjA==
X-Received: by 10.66.139.133 with SMTP id qy5mr25774097pab.4.1467666245897;
 Mon, 04 Jul 2016 14:04:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.66.126.147 with HTTP; Mon, 4 Jul 2016 14:03:46 -0700 (PDT)
In-Reply-To: <20160704212926.919a267706a6fa5791c47726@domain007.com>
References: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
 <20160704203946.3ac8d3205c08bfaee9a93a46@domain007.com> <CAH_OBie4dUB8WXfmKhLaezVKi0=LhnFw=wKJO1c3oUMA7VkYdw@mail.gmail.com>
 <20160704212926.919a267706a6fa5791c47726@domain007.com>
From:	shawn wilson <ag4ve.us@gmail.com>
Date:	Mon, 4 Jul 2016 17:03:46 -0400
Message-ID: <CAH_OBieUYZTi+8W-m1TVVDstzF2vg1VuYQsd9Ka_uDoRYRY5rg@mail.gmail.com>
Subject: Re: split directories into branches
To:	Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 4, 2016 at 2:29 PM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> On Mon, 4 Jul 2016 14:15:58 -0400
> shawn wilson <ag4ve.us@gmail.com> wrote:
>

> I don't possess the official stance on this topic but AFAIK user-level
> questions are fine on this list.

In that case :)
... still having issues w/ filter-branch:

$ git filter-branch --tree-filter "shopt -s extglob && mkdir -p
cookbooks/base_sys && mv !(cookbooks) cookbooks/base_sys"
Rewrite a90fb34230e02d9494934e5549f36bdbdd1b6ce6 (1/6) (0 seconds
passed, remaining 0 predicted)
/usr/local/libexec/git-core/git-filter-branch: eval: line 360: syntax
error near unexpected token `('
/usr/local/libexec/git-core/git-filter-branch: eval: line 360: `shopt
-s extglob && mkdir -p cookbooks/base_sys && mv !(cookbooks)
cookbooks/base_sys'
/usr/local/libexec/git-core/git-filter-branch: line 360: warning:
syntax errors in . or eval will cause future versions of the shell to
abort as Posix requires
tree filter failed: shopt -s extglob && mkdir -p cookbooks/base_sys &&
mv !(cookbooks) cookbooks/base_sys

I'm guessing it's because of how filter-branch is eval'ing stuff. But
if I do !\(cookbooks\) it interprets the '(' and ')' as text - ideas?
