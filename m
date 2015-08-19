From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] Documentation/git-send-pack.txt: Flow long synopsis line
Date: Wed, 19 Aug 2015 12:56:47 -0700
Message-ID: <xmqqtwrv8328.fsf@gitster.dls.corp.google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
	<1439998007-28719-3-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:56:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9Tj-0004pk-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 21:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbbHST4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 15:56:50 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36818 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbbHST4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 15:56:49 -0400
Received: by pawq9 with SMTP id q9so9945391paw.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2urCPpTyjyq0e531fSix4hHo8tYuDJDNzmA49pxL3U4=;
        b=n5Qxb8O2veIcgN5U9P6NztowpilxqnGDXHNXvW2YRl5htBkBYPIVnnxwfNXLACzQAI
         mL7M9DHmI9PF1bSVecvcgdJs4SIaoZDrX5e+mZDVHKSEfY1AsFtcRznDFzOtg8jnMjQJ
         +qg77CjbnR9Zv+e6DPdxIoyytVriMY1eNkMjobpDyYkzFH6OI5qmY4v+XWMFkRqHNDAh
         UPCaHCjpFT6Cfob31kAgVUNH2qORuyJCqDaTHUVhnLubUyM6iTHRsePFdGzmDJhJ0fTr
         NaSli3if05i3SLBWtN+F6Ame2zdSDS6rwgB0uJxi1MeRJVzBK7RkMn7CowMOXn2iPVxS
         FPOg==
X-Received: by 10.66.118.39 with SMTP id kj7mr28150333pab.115.1440014209294;
        Wed, 19 Aug 2015 12:56:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id au10sm1766382pbd.81.2015.08.19.12.56.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 12:56:48 -0700 (PDT)
In-Reply-To: <1439998007-28719-3-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Wed, 19 Aug 2015 11:26:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276218>

Dave Borowitz <dborowitz@google.com> writes:

> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---
>  Documentation/git-send-pack.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
> index b5d09f7..6affff6 100644
> --- a/Documentation/git-send-pack.txt
> +++ b/Documentation/git-send-pack.txt
> @@ -9,7 +9,8 @@ git-send-pack - Push objects over Git protocol to another repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git send-pack' [--all] [--dry-run] [--force]
> [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic]
> [<host>:]<directory> [<ref>...]
> +'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
> +		[--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]
>  
>  DESCRIPTION
>  -----------

As can be expected from the Subject: line, this patch is
line-wrapped and does not apply ;-)

I've done a trivial fix-up and took the liberty of making the result
of this step into three lines, not two.  That would make 3/9 look
more trivial.

Thanks.
