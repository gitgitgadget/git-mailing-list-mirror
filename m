From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/7] pack-protocol.txt: Mark LF in command-list as optional
Date: Wed, 1 Jul 2015 11:21:10 -0700
Message-ID: <CAGZ79kY-T8k7GjCUxKh5p_bf_t1+M8jRoBPDFp0hpExYmE8y=g@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-3-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 20:21:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMdI-00027G-NQ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbbGASVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:21:13 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35106 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbGASVL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:21:11 -0400
Received: by ykdy1 with SMTP id y1so46804495ykd.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z+H1IQvNui1TNFQpJzNkMQW+uYlWrFBip1Tm+tJU81A=;
        b=BPMYjZHzjeAeq2AjRm3J6IJhCIgKvxxl5ze8c8FPCXJFeNRQvqu4kBBSjycAtN23M0
         YB56E0Y/at0yMrm6rqQFqUg3UK9wfrBKPPccemgSBBcE1w48U0Zb6Ax0vwu3kqs1FPMD
         jzMWCBkIW/aDyE5i7yzpl+Vto3zz2pGtvfVEDhzSYbjrF+uRHs9ekhYksT+++iIyT1He
         M5/ubdSuRNmdjM1ndKJ4gsAGMO8agzVNtrQmThM6BTQxszxK+4yTdpfKq2foFQ37W03K
         INYFtxRw5OwO/InCFgYMctBbWJa7QIeMa+1xYEG+9/jjwb3kkUDf8kC7dsayQuVL+8d9
         LRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=z+H1IQvNui1TNFQpJzNkMQW+uYlWrFBip1Tm+tJU81A=;
        b=KbgR0s++9knhML8Yx2zKMaLMOF8ZKL7N1gfTC++jIYDlK41A0iTo0y4TTEaIUsgx2t
         q84JOw9D413lHfieptHjC1JazJQ1TA3jwl/u09+At2ItyjOFhh5EGnyFPESaAFX4ucrq
         qGIBU5OBQRNCJDh+IJi7Q5QXA5by15jXSnV0/f7viiskFFKHQH2qtXa2YgYFZ5zfQV5w
         mLZn3U9Z5KgjldsfUvMUMqxZiacxXBd6HmK7X65F1lYRahFzBInr/as7jIY9HpH5f4jk
         BoCgQa9tOuwInI+85G+VI15c/DHeLVhOz1ug4FuDlcyi0rtFZ3EyCIy3BsPz4ir4BzFk
         39rg==
X-Gm-Message-State: ALoCoQkXzlTI9sY1Ly3upRQo64kM4Alyumhqo1f6fqrctalr/yxIafgPFT+x76N3vnq0oAmE+Td5
X-Received: by 10.13.213.212 with SMTP id x203mr34049400ywd.174.1435774870453;
 Wed, 01 Jul 2015 11:21:10 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Wed, 1 Jul 2015 11:21:10 -0700 (PDT)
In-Reply-To: <1435774099-21260-3-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273177>

On Wed, Jul 1, 2015 at 11:08 AM, Dave Borowitz <dborowitz@google.com> wrote:
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---
>  Documentation/technical/pack-protocol.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 66d2d95..1386840 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -481,7 +481,7 @@ references.
>    shallow           =  PKT-LINE("shallow" SP obj-id LF)
>
>    command-list      =  PKT-LINE(command NUL capability-list LF)

We may also want to mark it in this line above as well as in the shallow line?

I think the problem with this part of the documentation is its ambiguity on
what exactly we want to document. The sender SHOULD put an LF, while
the receiver MUST NOT assume the LF is there always, so I guess it's best
to mark it optional from a receivers point of view.

> -                      *PKT-LINE(command LF)
> +                      *PKT-LINE(command LF?)
>                        flush-pkt
>
>    command           =  create / delete / update
> --
> 2.4.3.573.g4eafbef
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
