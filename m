From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Sat, 25 May 2013 02:29:05 -0400
Message-ID: <CAPig+cTSKPS2ui0=xathnR=Xau3YoE+omw3GRmJq5QHDDgD_7Q@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
	<1369405177-7855-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 08:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug7ya-00040c-2R
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 08:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab3EYG3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 02:29:07 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57778 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3EYG3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 02:29:06 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so5382819lbi.19
        for <git@vger.kernel.org>; Fri, 24 May 2013 23:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=qpOzhBxgdoglarReA8d32iwdrQ3AUJcaQaLR7j00+A4=;
        b=EB0hpYB43yP1pWZHN2S0H0Xr1JgEQ8RhW0U8ie6QRPEBCmcuyuvZF4Q7bIqbL7tFfq
         gZjXMbYn24t2pbHdq7e9cDgVMvRk9HRla3BUIxzGTpy7uEX/iX08q3dC1wNBcJW+4R9k
         y6CjHWAgRQljeonJJNUEwjD7xeyFxcb46Gky5JCX3DMl397MMiVMo4cSgihFdfUlR7zS
         VofiNa0hfjhlIeyUFbl6L1J7Yebi/ddNL6xIK8GWy4dcTWr/lFiu16GuvVwPioCPkRI2
         FgVVP78h7din/DCHXA95F2yhInOm/toxijf7o4WL5AxsraL9Xz8X4x41+WkqmlIkaDXg
         MKiA==
X-Received: by 10.112.145.100 with SMTP id st4mr10337541lbb.102.1369463345179;
 Fri, 24 May 2013 23:29:05 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 24 May 2013 23:29:05 -0700 (PDT)
In-Reply-To: <1369405177-7855-2-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: PR7Lc_N8PIFQqmGFOT7Ltllw0QI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225492>

On Fri, May 24, 2013 at 10:19 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Since 'git branch' misses important options like --sort, --count, and
> --format that are present in 'git for-each-ref'.  Until we are in a
> position to fix 'git branch', let us enhance the 'git for-each-ref'
> format so it can atleast colorize output.

s/atleast/at least/

> You can use the following format in for-each-ref:
>
>   %C(green)%(refname:short)%C(reset)
>
> To display refs in green.  Future patches will attempt to extend the
> format even more to get useful output.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
