From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Direct ancestors from commit to HEAD
Date: Wed, 16 Sep 2009 07:26:41 -0700 (PDT)
Message-ID: <m3vdjj2ceq.fsf@localhost.localdomain>
References: <4AB0EFC0.8020005@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gonsolo <gonsolo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 16:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnvTB-0003Qh-3L
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 16:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbZIPO0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 10:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbZIPO0n
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 10:26:43 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:61895 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbZIPO0m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 10:26:42 -0400
Received: by fxm17 with SMTP id 17so2315487fxm.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lGvrSlmFXjfIoIG11FZgStenJ/sTbKt2boZncKqSFVU=;
        b=xZrWOFT4m8Pseb3bBZ+Juq769ATFMWLqTySaETF7MnG6d3E0Jr5dfeTgnJoPYUVRUk
         KD+QjBip4Fv2V0rfWAr+qC7U6sQ6O539jDDpmyjG/P9Cu7AfAzBFZRb2A0UQxX2j2mhn
         AvKMM0BUq/JnIM5j+1vnpHoEadNsiN57+fedc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=t2zZCImygHu8VrnOS0LMcqXEn6YuqkD13EHeOkg+klrJojjPFVXq7ccblxfQSIvU/v
         A4X09LYqdMjYHz3ZvgNJsEUIzZEz8LTuRp82xTXExCj9eI2eEm5P8YJRnxRNnOVYWY02
         3hPZh3qg12Dp4wdBEsRCKNQ7VSs+YH9s3w5rY=
Received: by 10.86.231.17 with SMTP id d17mr7490978fgh.46.1253111203690;
        Wed, 16 Sep 2009 07:26:43 -0700 (PDT)
Received: from localhost.localdomain (abvy57.neoplus.adsl.tpnet.pl [83.8.222.57])
        by mx.google.com with ESMTPS id l19sm2453918fgb.2.2009.09.16.07.26.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 07:26:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8GEQsd3007209;
	Wed, 16 Sep 2009 16:26:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8GEQsp2007206;
	Wed, 16 Sep 2009 16:26:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4AB0EFC0.8020005@googlemail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128657>

Gonsolo <gonsolo@gmail.com> writes:

> Is there a way to see only the direct line of (merge) ancestors from
> patch to HEAD? Something like:
> 
> commit 0cb583fd2862f19ea88b02eb307d11c09e51e2f8
> Merge: 723e9db... a2d1056...
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Sep 15 10:01:16 2009 -0700
> 
> 	Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next-2.6
> 
> commit 88512935a24305fea7aecc9ba4d675869e97fc2a
> Merge: 8a62bab... 6b26dea...
> Author: David S. Miller <davem@davemloft.net>
> Date:   Fri Aug 14 12:27:19 2009 -0700
> 
> 	Merge branch 'master' of
> git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6
> 
> commit edd7fc7003f31da48d06e215a93ea966a22c2a03
> Author: Nick Kossifidis <mick@madwifi-project.org>
> Date:   Mon Aug 10 03:29:02 2009 +0300
> 
>      ath5k: Wakeup fixes
> 
> 
> Here I can see exactly how the ath5k patch came to mainline and since
> when it is there.

I don't know whether --first-parent or --simplify-by-decoration, or
perhaps --dense is what you want (you can also use --graph for better
visualization).

Or use git-show-branch... :-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
