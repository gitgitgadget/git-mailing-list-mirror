From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] There was a little inconsistancy in git prompt
Date: Tue, 12 Apr 2016 11:27:39 -0400
Message-ID: <20160412152739.GL15513@zaya.teonanacatl.net>
References: <01020154095436db-40246224-5586-4e95-b5f7-59b27928ffa8-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Rudy YAYON <ryayon@outlook.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:27:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq0EG-0003St-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 17:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965396AbcDLP1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 11:27:44 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36759 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965272AbcDLP1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 11:27:43 -0400
Received: by mail-yw0-f196.google.com with SMTP id i125so2767542ywe.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YWujjMegpml6r9U6Tzkizfe6sxIzf+UHDi0hUU/mwvo=;
        b=o7+U2jupe/I4UKReTE4cZsRMl+m3kl/Z7VtyCR/qHK/9LkxF8AkcGGGcmN44hukIq9
         syG7kr6MDv5HdBHBwKZolwLWAmaKxNqzY0JnL4hw6aU7y8jL0l8LNg/sdneS17JzdoQ7
         7J+La7Nx8O3jGisj7RWjN7aLDZNcdyXPiXitYYME2MRXe/5EIHyYCePXdeqov4E0UgpC
         8aGjMhGEVHJUaf26oIhBr6/4kYr8laM88KehfelryDsxn8+wUgDX4iEkKdQBWzlG22qm
         woNSKAnrm0ThezYwxDXUEh57YAI1oJbV6/pVDGeBe3qaKKzGOYzxIvpAdxyLa3uPhqd4
         X/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWujjMegpml6r9U6Tzkizfe6sxIzf+UHDi0hUU/mwvo=;
        b=K9RtL8Asqz2xYuL2DT/g76zfPp83cnU7PSsN8VIMx0BMVrUlqDk//yBiOjBPNAxvV6
         oIfnLYWT+6FFkZLXt4kbHIr8jIQz7T9cohtDB6kl3aBt2PHy0tsGHkduRlzhrDGTpqNW
         Eb3v1wTYqaMmYHUEXcCcDVYJsf58I1viiU0DEfjkElK2f/u0OdkerCJmbYaP6GDr8oGQ
         xlJWXP8pdv1TIrTf+18cQRT5ET1tYk4hgWacV3rHIu8MU+/5r0/MC9lJ/ZfWHrOhD4cZ
         r2hMS0hUbDwqucnnLPXtWukykFYg7rN/g3EKvqUA3GfFCQqaJdzhRW2P/qs7YxMNYtjr
         qMgg==
X-Gm-Message-State: AOPr4FXwiltgHoEmffW9PgKkhH9UMG2d8FhYXvzt/2Q/LBC/vhk89A1jt6yjhci3YEC7NQ==
X-Received: by 10.13.217.75 with SMTP id b72mr2167967ywe.118.1460474862959;
        Tue, 12 Apr 2016 08:27:42 -0700 (PDT)
Received: from zaya.teonanacatl.net (zaya.teonanacatl.net. [2001:470:5:873:862b:2bff:fe5e:698b])
        by smtp.gmail.com with ESMTPSA id i67sm17920477ywf.34.2016.04.12.08.27.42
        (version=TLS1_1 cipher=AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 08:27:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <01020154095436db-40246224-5586-4e95-b5f7-59b27928ffa8-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291267>

Hi Rudy,

I think the commit subject should include a bit more detail.  Ideally, 
the subject would start with 'bash prompt: ' to make it clear what 
area the commit involves.  Then you would want to describe what 
inconsistency is being fixed (and why).

Rudy YAYON wrote:
> ---
> contrib/completion/git-prompt.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 07b52be..18be99f 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -194,13 +194,13 @@ __git_ps1_show_upstream ()
> 		"") # no upstream
> 			p="" ;;
> 		"0	0") # equal to upstream
> -			p="=" ;;
> +			p=" =" ;;
> 		"0	"*) # ahead of upstream
> -			p=">" ;;
> +			p=" >" ;;
> 		*"	0") # behind upstream
> -			p="<" ;;
> +			p=" <" ;;
> 		*)	    # diverged from upstream
> -			p="<>" ;;
> +			p=" <>" ;;
> 		esac
> 	else
> 		case "$count" in

I attempted to solve this a while back (longer than I realized, now 
that I found the previous thread):

http://thread.gmane.org/gmane.comp.version-control.git/169330

Junio had some comments and suggestions, which I lacked time to follow 
up on, it appears. (I thought there was more discussion but it must 
have all been in my head. ;)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When I think about all the crap I learned in high school ... it's a
wonder I can think at all.
    -- Paul Simon
