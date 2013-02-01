From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] fixup! fixup! fixup! Change 'git' to 'Git' whenever
 the whole system is referred to #1
Date: Fri, 1 Feb 2013 11:43:08 -0800
Message-ID: <20130201194308.GC12368@google.com>
References: <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
 <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <242116275.1090080.1359742076320.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 20:43:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1MWO-0002he-Es
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab3BATnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:43:15 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:57348 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab3BATnN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 14:43:13 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so1855102dak.0
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 11:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=013Dl7Cm8rb1FHhtQuJR4xukalQX+8dg2wkQ4W8825g=;
        b=SCwzcXWSAo3R4tABSo4zKOSVhRLUNdukcNNPuvTcd7dwY4HRFlYCiEeO5gHZlyct+E
         a5b9GyY5XHrg/LC+fpeS8ksdY1tCgeYQ/QnuqnHwEkImBv7EHjOITGY/9IB6jeHNZUUH
         AdnjqwvyTozUpRBlefapEJk+1Jl+5aA6UD4SSiIjpSK1BbdztoXGyeaiyPlCLwieAlej
         4OWNphfg1D2cLejAZVWaaXwYeZEom/K9YoPz0N2loQlYbbNqsXK9t38Sr0+tHcxwSMjw
         o04dnCRliymoaqFGMQYdVzMIbXpAdcDnqnhmfQxiH+m1UZIzdJq3hq7WZ8NhtvlgtB8Z
         5SEw==
X-Received: by 10.66.88.198 with SMTP id bi6mr32538707pab.54.1359747793376;
        Fri, 01 Feb 2013 11:43:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id l5sm10034390pax.10.2013.02.01.11.43.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 11:43:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <242116275.1090080.1359742076320.JavaMail.ngmail@webmail18.arcor-online.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215261>

Hi,

Thomas Ackermann wrote:

> Found by Junio:
> Change git-dir to $GIT_DIR and git-file to gitfile.
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/git-rev-parse.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index c743469..14386ed 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -187,9 +187,9 @@ print a message to stderr and exit with nonzero status.
>  	Flags and parameters to be parsed.
>  
>  --resolve-git-dir <path>::
> -	Check if <path> is a valid git-dir or a git-file pointing to a valid
> -	git-dir. If <path> is a valid git-dir the resolved path to git-dir will
> -	be printed.
> +	Check if <path> is a valid `$GIT_DIR` or a gitfile pointing to a valid
> +	`$GIT_DIR`. If <path> is a valid `$GIT_DIR` the resolved path to `$GIT_DIR`
> +	will be printed.

Hm, I don't find the old or the new version very easy to understand.  Perhaps the
idea is something like this?

	Check if <path> is a valid git repository (.git or <project>.git
	directory) or "gitdir:" file.  If <path> is a "gitdir:" file
	then the resolved path to the corresponding real git repository
	will be printed.

Thanks,
Jonathan
