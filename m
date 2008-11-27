From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: summaries in git add --patch
Date: Thu, 27 Nov 2008 13:27:19 -0800 (PST)
Message-ID: <m3od00kgg9.fsf@localhost.localdomain>
References: <492F0CAD.3010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 22:28:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5oPf-0001NS-7s
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbYK0V1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbYK0V1X
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:27:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:58348 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYK0V1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:27:22 -0500
Received: by nf-out-0910.google.com with SMTP id d3so630082nfc.21
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 13:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=7xsNhXpH28H8kIKJA0hWFkak969g2UZ1EQKK5nEmt1s=;
        b=vkGpFcPR5aO+AA69Hu2HxuS/83y5Gy66yiJpbvNBdJivETnPaW4svEZc8+CJmPEgqm
         giN9CN2zYYnKRitBzrKtHyZRt2/bh7EIHOfFBi4BNWGKkcdbWZVb74dgLg3zHYZ8mT0G
         kC3jcRkJiluXb6AU+PKrc9YDdbPHWHOfQlccE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=fYR0Rfr8sUSW4As5Z7ca/1Kf6tfrMyjG6vtrRU+3L7mI6RCXh/3uHufQ4F0+P1eorC
         HmbaZ/+Yr9fBS8Woi89vMqgWT9MUN5ggPToLo7UqtVj0L/Jkcaa+HaJoCRTugmpOVxdo
         D9zwn3I/3gK+UCV8gNs2P40nT952NjFHEQt/4=
Received: by 10.210.90.10 with SMTP id n10mr8044029ebb.9.1227821240743;
        Thu, 27 Nov 2008 13:27:20 -0800 (PST)
Received: from localhost.localdomain (abww170.neoplus.adsl.tpnet.pl [83.8.246.170])
        by mx.google.com with ESMTPS id 7sm1161497eyg.42.2008.11.27.13.27.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 13:27:19 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mARLRJ9v014056;
	Thu, 27 Nov 2008 22:27:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mARLRJIW014053;
	Thu, 27 Nov 2008 22:27:19 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <492F0CAD.3010101@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101838>

William Pursell <bill.pursell@gmail.com> writes:

> I just implemented a command to give a brief summary
> of the patches in the current file.  

Good idea.

Side note: you should signoff your patches, following
Documentation/SubmittingPatches.  And it would be better
if the patches itself were either threaded, or all be
replies to this cover letter ([PATCH 0/5]) email.

>                                       Please note that
> I am just rediscovering perl after having abandoned it
> years ago, so any criticism is appreciated. 5 patches
> to follow.  (From aa14a0c3f)
> 
> Here's a screen shot:
> 
> 
> Stage this hunk [y,n,a,l,d,k,K,j,J,e,?]? l
> '*' indicates current hunk.  '+' stage, '-' don't stage
>   0+: @@ -8,9 +8,9 @@ Aani
>   1 : @@ -48,7 +48,7 @@ abandonable
> *2 : @@ -88,7 +88,7 @@ abaton

I hope that contrary to this 'screenshot' actual output is aligned
properly...

>   3 : @@ -128,7 +128,7 @@ abdest
>   4-: @@ -81192,9 +81192,9 @@ gyrous
>   5 : @@ -234925,7 +234925,7 @@ zymotic

That of course assumes that summary catches right thing; still
it is better than nothing.

> @@ -88,7 +88,7 @@ abaton
>   abator
>   abattoir
>   Abatua
> -abature
> +agature
>   abave
>   abaxial
>   abaxile

Same here.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
