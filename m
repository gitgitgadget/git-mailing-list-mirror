From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH
Date: Wed, 16 Jul 2008 12:47:43 +0200
Message-ID: <bd6139dc0807160347n2ebcd64fy7a15fe94bfabe580@mail.gmail.com>
References: <g5jj21$bsp$1@ger.gmane.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: namsh@posdata.co.kr
X-From: git-owner@vger.kernel.org Wed Jul 16 12:48:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4Ys-0004Np-Nt
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbYGPKrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbYGPKrq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:47:46 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:34692 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106AbYGPKrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:47:45 -0400
Received: by qw-out-2122.google.com with SMTP id 3so267517qwe.37
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QAeG7JREfzzdxVundfOvqBrIE0SoKAbJDkmNU0L1ZT0=;
        b=BEGG5dGyMSnn8k26I6ycn3EkIswnDemekJJm9TUzyyK/uVWT+JAokngUVQO7Y87WrF
         nlLxU3KkNB0Kn/Z66URuvE1Zch9ffbAUb92chlHgWrZIt//c8+5tZG5UaWnIiJrjhb75
         2VGSLvWEdniotF1x4WcCqo6UKuzkGOjmKKQJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=ulz1f8/U8JlQk6HeIfCuc8NdbwjkKSCgQf0OjWtwkf5x2EEVGwG5+hhFEPzYwwGebx
         /PdZiZMr0Ufe3eI177Yvjiudfnz+NgILPKtpw7bP0zED04YctPOe1LGKkRZ4mQ1V3weV
         IAXQtdnzCU7kdGg6a1FhjD1gc0jQK7f6Nt1Y8=
Received: by 10.142.156.19 with SMTP id d19mr5089401wfe.261.1216205263878;
        Wed, 16 Jul 2008 03:47:43 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Wed, 16 Jul 2008 03:47:43 -0700 (PDT)
In-Reply-To: <g5jj21$bsp$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88666>

On Wed, Jul 16, 2008 at 3:31 AM, SungHyun Nam <goweol@gmail.com> wrote:
>
> Signed-off-by: SungHyun Nam <goweol@gmail.com>
> ---
>  t/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/Makefile b/t/Makefile
> index a778865..0d65ced 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -26,7 +26,7 @@ clean:
>        $(RM) -r 'trash directory' test-results
>
>  aggregate-results:
> -       ./aggregate-results.sh test-results/t*-*
> +       '$(SHELL_PATH_SQ)' ./aggregate-results.sh test-results/t*-*
>
>  # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
>  full-svn-test:
> --
> 1.5.6.3.350.g6c11a

It is not clear to me what this patch does, there is no justification
in the commit msg either. Instead you say what is being done, which we
can see from the commit diff. Please clarify?

-- 
Cheers,

Sverre Rabbelier
