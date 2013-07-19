From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] checkout --rebase
Date: Fri, 19 Jul 2013 17:06:59 +0530
Message-ID: <CALkWK0mp=2xuQwSjMPRBvwRUEnAbM2=r_hZu=ZKc8wxZYxgSVA@mail.gmail.com>
References: <CALkWK0m-ZpVvvgAB_yzooah0=veeNDudahs=4ur2YHN03h-h4g@mail.gmail.com>
 <CA+xP2SbHD+MU4K0JBbZdA6bWQFQerBi5mWA+7G9=tBksjp+LXw@mail.gmail.com>
 <CALkWK0nM4fkCPNJo_c3Rpwh1azsGRdGvM3S80vcuRiRXDT0vOQ@mail.gmail.com> <CALkWK0kVNw3Ko3+_Y-KDF=pdha6wxyMmQmLtOOr5tQYzgUr_Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sebastian Staudt <koraktor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 13:37:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V090K-00078c-S3
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 13:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760214Ab3GSLhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 07:37:41 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52951 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760161Ab3GSLhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 07:37:40 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so970510iea.3
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 04:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7QV7wS78DnFQB9wvS+ttkkXNR/sEA9kbhdvOpOsPunQ=;
        b=aU0RKhuggFZod6dY/4qGfZevjrAmdKJofJj7MYF/QrQmMx88euEUeQ60ofXF3P18NI
         VvxrWONVEUU895QHUDVw+D66lpjHv1LXtCrvLSF8MHT34Ag1qVBNY6+tImMQ14j7cTMp
         r2FWRqdARPXZJ43Tr82Rhzc9lEunPjJu4rrUpxgGlVZDiISg3N+6zzV2S5Bo5hVCJ+HY
         VLK4KU8et9amtEgjt14X05igy5ELm491m3F9frbnrqAHD08ijvYrPwyE4Uwzsg5B2F2o
         HWG0+KPboxMVFh9JEhU9Dmpd7MOl4NdnYMl0jjETd2UkTgaSGQsAFVd/Ux2QaH/5tqym
         1Huw==
X-Received: by 10.43.99.138 with SMTP id cs10mr9862420icc.105.1374233860078;
 Fri, 19 Jul 2013 04:37:40 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 04:36:59 -0700 (PDT)
In-Reply-To: <CALkWK0kVNw3Ko3+_Y-KDF=pdha6wxyMmQmLtOOr5tQYzgUr_Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230793>

Ramkumar Ramachandra wrote:
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 0039ecf..7405d9a 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh

Er, sorry.  I think it suffices to check that $branch_name equals
HEAD, for this optimization.
