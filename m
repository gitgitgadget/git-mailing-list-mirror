From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 1/2] Do not output whitespace on blank lines
Date: Sun, 29 May 2016 18:06:37 +0100
Message-ID: <20160529170637.GC2286@hank>
References: <01020154fd28aa12-f536bf3e-58df-4d1f-b903-929b429954d3-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Nicolson <david.nicolson@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 19:06:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b74AQ-0000Km-7Y
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 19:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbcE2RGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 13:06:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35641 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbcE2RGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 13:06:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id e3so15522479wme.2
        for <git@vger.kernel.org>; Sun, 29 May 2016 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wIWrixkPytfyvnXNFkFLNNv0fAF/+lWnVOZqUK/uC4w=;
        b=VXuqjJjeF9lM+NyZGkg2bAtcgy581sR5UYtGXOLQNvA5IQgHzW+X4p9G2tSwWOqICQ
         eXIah8eAyGyFb0k3Sc0u96b+GmkhsG7tfXhUlpHzchcuu+r9zTcFeAg0h84RMaE5bdDJ
         AeSBZWnLplF9/NMkuo3LSwQsFpGYmCiZtZRjk4wyL2cgKEmJU7IT9Iw1/GpR2Su9++n/
         41N9jFhSKTAzLOJ0puEhMuMPVdeYW910a3nrD8EgEYpQX7K0Mp0PR3Lc7GVOShgwJqTf
         Gybi8QilR3IWYOJFmu9wQsB/Nkt8KJOtPhSHer1Gjkh2pOmuv2ioICZMLAgRstpEY+HM
         /4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wIWrixkPytfyvnXNFkFLNNv0fAF/+lWnVOZqUK/uC4w=;
        b=AmOT0/42xWyRqXHEah2GUzXd6Ijq4B6N9IBBtUToHD3wr2xFuNY7m0BcMxEDAuR1mI
         bNHprkAqipecLda1WxqKukzusAtjZGFKZJ416gad+kk1ZdduAV73lj+bDzCfkpiYl7xV
         7IJmqy6ZxaK3ERrsAkFCtx0pPeO9f8fnu8gKtqLk0VOOQrSPbD0N7RQzbsMrSBtyKcPd
         bNq3dMN1JHv4pFZ4N3paZv5nhzmxjjE8d24GqzKtcAGowEkcR7kEBTRNK5TWLr9NabGc
         dThASgAHvQkTNPCy2qjuL3fFQW6p0EP83x9cuJzRjqB9X4c/Adg/ztWipbMCBqinvQfb
         Ixfg==
X-Gm-Message-State: ALyK8tLIDuYYSVSrdh+97EcXBLzrsU6caHXitxzntF9ovYbzZQYsZRKJ5k/+Jpq77QKFGA==
X-Received: by 10.28.25.129 with SMTP id 123mr7367530wmz.10.1464541576168;
        Sun, 29 May 2016 10:06:16 -0700 (PDT)
Received: from localhost (97e49f40.skybroadband.com. [151.228.159.64])
        by smtp.gmail.com with ESMTPSA id q125sm19448359wmd.19.2016.05.29.10.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 May 2016 10:06:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <01020154fd28aa12-f536bf3e-58df-4d1f-b903-929b429954d3-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295836>

On 05/29, Dave Nicolson wrote:
> ---

The commit message should describe why you think this is a good
change.  Without the commit message I don't see how this is a
improvement.  It is also missing your Sign-off (see
Documentation/SubmittingPatches section 5).

The test changes you sent in Patch 2/2 should be in this commit,
otherwise the git bisect is broken when it hits this patch, which is
something we want to avoid.

>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/diff.c b/diff.c
> index d3734d3..459b36a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -471,7 +471,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
>  		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
>  		if (has_trailing_carriage_return)
>  			len--;
> -		nofirst = 0;
> +		nofirst = len == 0 && (char)first == ' ' ? 1 : 0;
>  	}
>  
>  	if (len || !nofirst) {
> 
> --
> https://github.com/git/git/pull/245
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Thomas
