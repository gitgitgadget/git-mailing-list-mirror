Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878BE1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJ1PJT (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:09:19 -0400
Received: from mout.web.de ([212.227.15.3]:58837 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeJ1PJS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:09:18 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MejSy-1fwmAw2Cc4-00OIZo; Sun, 28
 Oct 2018 07:25:34 +0100
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MejSy-1fwmAw2Cc4-00OIZo; Sun, 28
 Oct 2018 07:25:34 +0100
Date:   Sun, 28 Oct 2018 07:25:33 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
        dana@dana.is
Subject: Re: [PATCH] wildmatch: change behavior of "foo**bar" in WM_PATHNAME
 mode
Message-ID: <20181028062533.GA15061@tor.lan>
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
 <20181027084823.23382-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027084823.23382-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:hzk3HPJh7SmRZb9TdRaK2vm8jTF2BO6oGOZGZOiJO0Gg0y4in2S
 jOUxvotaN9yCevsW/hMyzcOdkVov8TdYwF9rOA30ldLr/ZuG7IpxFVvjwpXIhkxIYzhVKnD
 galnqUPWiIjqwPybbMdJA7IEt8D41CnJChKezfnF0uapMxU8e04KP3f7UBX1IZQKFi01GOW
 I//5q13XxQs5FWzS/ULGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mEcnTLeY+Es=:KginknzSwkVJNLQAX6q1m1
 FdWLrq0d2KeUX3V7/1CwbwgNbBZlwrwqhwfNEe2xy5LCr2e4YZhCu6dKWzzkOCa7sM725iATk
 J5PYPgQuYUDAoDPIk1DMsEBg7I6ZC548B0DZn+U6r9hcE+pWQTpO8d9JtmLjn5bMKbr9fAUBP
 BSH287ql2iti1k48qm8XnRfYdyC09+EOF/csi053w0Fh8bxVQoxN7jCRSFHzDdiKceQd7bqiT
 0T+a/dQHShPhMsWxf69iBOZiIH2Bp/DoHVKtdn8J56SE6I7yiP0YY2/UmmLZi3KLwzU1jelmF
 Yw4PBZlk5ju8/F+7kqYb6WbIjC+ozbT6UMgkSjGE6LbuwetOCMGrXhYhvFPY25EMzGmWL+vh/
 JEGHCWMESgw5zJZs7fMhaVHkr+jNzqX5zL/uzLF1aWn/Mfu0WW2oH6bXyIpf8cEkUI7Bbr7m2
 k14kZtjlkl25gSf+ZTJRtOwGllv1z8GgY2xUQTNrUhxsdCYNrrEkcUoWCQ/pzKLqyGVGm8HB+
 MtdlFKzM9k+ZnVZPw2Tl0fUzeIKN2r/7kwzxIC5K3eUrqtkAsVQcfpwGwmakFoFHzr/jSYz3N
 WPt+nUCCGjSwuahqAnSmm95CHDKBEul4nDL9pMaNi8UX1y5oig6sudTodickywtilx7sn73z9
 iJ/uCe5knyeirhUtbRZfKnlTSzfsDs8i8WCWeeFR77q7hEUtI0HefaDKY4kmAU6eldvQPG/mH
 yREMAsvH/ujcxYZ7dJfVb8fmt+5EKp9sP3NXkZg6zG17OSd8YyIpYHZUJxL9jRE2S468d3yjz
 jjj5r+g6hydR4uTwldZxf1C+ErsUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 10:48:23AM +0200, Nguyễn Thái Ngọc Duy wrote:
> In WM_PATHNAME mode (or FNM_PATHNAME), '*' does not match '/' and '**'
> can but only in three patterns:
> 
> - '**/' matches zero or more leading directories
> - '/**/' matches zero or more directories in between
> - '/**' matches zero or more trailing directories/files
> 
> When '**' is present but not in one of these patterns, the current
> behavior is consider the pattern invalid and stop matching. In other
> words, 'foo**bar' never matches anything, whatever you throw at it.
> 
> This behavior is arguably a bit confusing partly because we can't
> really tell the user their pattern is invalid so that they can fix
> it. So instead, tolerate it and make '**' act like two regular '*'s
> (which is essentially the same as a single asterisk). This behavior
> seems more predictable.

Nice analyzes.
I have one question here:
If the user specifies '**' and nothhing is found,
would it be better to die() with a useful message
instead of silently correcting it ?

See the the patch below:
> -				} else
> -					return WM_ABORT_MALFORMED;

Would it be possible to put in the die() here?
As it is outlined so nicely above, a '**' must have either a '/'
before, or behind, or both, to make sense.
When there is no '/' then the user specified something wrong.
Either a '/' has been forgotten, or the '*' key may be bouncing.
I don't think that Git should assume anything here.
(but I didn't follow the previous discussions, so I may have missed
some arguments.)

[]
