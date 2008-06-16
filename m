From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-am: head -1 is obsolete and doesn't work on some new systems
Date: Mon, 16 Jun 2008 13:26:42 -0700 (PDT)
Message-ID: <m3tzftnn28.fsf@localhost.localdomain>
References: <1213646544.908600.7895.nullmailer@rafaella.geeks.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alejandro Mery <amery@geeks.cl>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:27:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8LIk-0001Qy-TX
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbYFPU0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbYFPU0s
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:26:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:62615 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbYFPU0r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:26:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3215231ywe.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=HiXj53brZ828yqtQh1TjA6jJa15H7VTlbR8KxDfFsu8=;
        b=NVFYHcYC8L3Op7xEzl1nNgPcCJ6AI6l1Ss+WdwmjsxaUTc3NjNgXmM/5hci1qJgU62
         ZgyM45HDLrRZDHGiis9X5dCP9kJoPJvULkkv9nZ5pfVhnOlf4XXBOAQBBc6FWmztjrkk
         rY0P5+ocd3ucGmGu07rtLtHK8NX4EbB6/pATA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=G3j8A2SdaDL8op7zrgqI7d2KzuYzkB5jW8/pRroHQsJxprf+ASAVVmb7hij3Dnu7Zu
         pTtM0JPiWg1AaSmJHz1JOJ5RvvmyGZDr8sKP1f6jubTPnnEakSpkI45+2yBoPIvEoZRm
         lloA/Q2hBxX29UfI3imoKauqWCAkBBZKuOqOQ=
Received: by 10.150.229.16 with SMTP id b16mr11440976ybh.90.1213648002982;
        Mon, 16 Jun 2008 13:26:42 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.236.117])
        by mx.google.com with ESMTPS id z26sm1190071ele.16.2008.06.16.13.26.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 13:26:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5GKQeKm027141;
	Mon, 16 Jun 2008 22:26:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5GKQd4q027138;
	Mon, 16 Jun 2008 22:26:39 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213646544.908600.7895.nullmailer@rafaella.geeks.cl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85227>

<amery@geeks.cl> writes:

> From 25cb047690dd6101527cdfa6198dd6a6f93bf095 Mon Sep 17 00:00:00 2001

This line is not needed (unless you use git-send-mail, or import patch
as mbox to your MUA), and it should be removed.

> From: Alejandro Mery <amery@geeks.cl>
> Date: Mon, 16 Jun 2008 20:27:14 +0200
> Subject: [PATCH] git-am: head -1 is obsolete and doesn't work on some new systems

These headers should go as mailing list headers, which mean that your
MUA should generate proper from (if it cannot, the From: would have to
stay), and subject should go as email subject.

> http://www.opengroup.org/onlinepubs/009695399/utilities/head.html

We are not interested in theoretical POSIX compliance, see
CodingGuidelines.

Patch lacks signoff line, per SubmittingPatches

: Signed-off-by: Alejandro Mery <amery@geeks.cl>

> ---
>  git-am.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-am.sh b/git-am.sh
> index b48096e..797988f 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -421,7 +421,7 @@ do
>  	else
>  	    action=yes
>  	fi
> -	FIRSTLINE=$(head -1 "$dotest/final-commit")
> +	FIRSTLINE=$(head -n1 "$dotest/final-commit")

For better portability it would be better use 'sed 1q' here instead.

: -	FIRSTLINE=$(head -1 "$dotest/final-commit")
: +	FIRSTLINE=$(sed -e 1q "$dotest/final-commit")


>  	if test $action = skip
>  	then
> -- 
> 1.5.4.3
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
