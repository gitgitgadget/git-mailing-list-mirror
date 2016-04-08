From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] format-patch: allow --no-patch to disable patch output
Date: Fri, 8 Apr 2016 11:34:37 -0700
Message-ID: <CA+P7+xrYMqcohYpWUpgAu1K=0N-3TgQi0_1sQ+z4v7nCPGcYSQ@mail.gmail.com>
References: <1460047599-9267-1-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cRNCwFmGW-Zo+osjceA6nb=6t3+rJ2uEbnyYxGfSWQ-Uw@mail.gmail.com>
 <CA+P7+xoUi5H19zOCAiiwQZ0-j8yNZS9-2DzgoMmLSVOrC8Nbpw@mail.gmail.com> <xmqqh9fcvtqg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:35:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aobFL-0000EQ-Ht
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 20:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbcDHSe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 14:34:58 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34872 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbcDHSe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 14:34:57 -0400
Received: by mail-io0-f173.google.com with SMTP id g185so141920780ioa.2
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tJTxoZQxa+80OfpM95AniJjWKmhVo807r3gwfynkCJI=;
        b=tR6UwYmDKWDR7o5kCZDdQb54QQmMJu3jRFwaayqPuGq4c2P0FOklIow186xKDa91Qj
         WxHptTqOPopBRK6QEhMaB+8O3gs0nhfDQ4PGD3FDhNpFpjv3jRVWIZ2WSzxoh5qUf/Z5
         4nbc6opl0LZmD/F9UnRkYhQz1hWSGS4V7bD19reHlTAES3mSdd9G8UvcZzlQo8TNff/i
         g1sMrghCrAYcdqAdVXIinGzFbhDMTMoJ+QtmVdeyxjPWvggmzwQTjkqIbz6XQo5r0mXU
         U3P0pI8Y3ZRFYnsekYVrDPXHcqyT8+JCCg38xACgY7x9HDvXtId3LuXmXsva86EM4IDm
         h/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tJTxoZQxa+80OfpM95AniJjWKmhVo807r3gwfynkCJI=;
        b=WjMk8jQufFVJgn1jaSWXdidJP4x+BNEJfhQo9GGp7joBZTrVfv+R+cwKz9kCi+i3KL
         uLbg61DShQH0HTuW/BQ7c0R85ZaAkEDXIigOgXh4Fu3j8qbFQOW4xAZThCdORxc6F8p+
         gS0xYMSp4hjq6GpYV+o8n0Qr9baC7FvIGBaoD7ODA5nqqfyt/lGOVAKcSqOwZuJ4eYQR
         PJRTTPAxvEWbGul9T+nXyrqkFdbZyJUIiZPNA4hJGz52lLSsHPjZ2pfV6uYxV8/sU7jM
         U5U4dD1WFO44hJObq2Y1eHvubm8uJTrOc/AJqfpvCq0uG4EYWjrE/gjHy/CDvaIIB5po
         mnEA==
X-Gm-Message-State: AD7BkJI9Wm6q0Xh5dN0LlZk12NyOEmmoL99VoOrRlX/5DWmLFNRsMLW3HCfE0P27Z0sq1NfoDWzQWwU/q4Hl9w==
X-Received: by 10.107.166.195 with SMTP id p186mr11028146ioe.146.1460140496452;
 Fri, 08 Apr 2016 11:34:56 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 8 Apr 2016 11:34:37 -0700 (PDT)
In-Reply-To: <xmqqh9fcvtqg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291051>

On Fri, Apr 8, 2016 at 11:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> So if I want to get the summary of a patch out of a commit without the
>> actual diff what would you suggest?
>
> "git log --stat"?
>
> If you have a set of (discrete) commits, "git show --stat A B C"?
>
>> Basically, I have a process where we have post processed code, and I
>> want to be able to generate a "patch" that shows the diff only of the
>> post-processed code, ie:
>
> If you want to script and depend on the exact output, you cannot
> depend on "log" or "show", so you would likely be doing "cat-file
> commit" for log message part and "diff-tree" (with options like -p
> and --stat) for the patch part, I guess.
>

The diff is being done on separate post-processed code, I can do that
part. I just couldn't figure out how to get the same "header" as
format-patch, but without the diff, which is when I saw no-patch, and
then saw that it didn't work.

Thanks,
Jake
