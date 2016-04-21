From: Santiago Torres <santiago@nyu.edu>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Thu, 21 Apr 2016 18:51:16 -0400
Message-ID: <20160421225116.GF1096@LykOS>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:51:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atNRS-0002yt-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 00:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbcDUWvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 18:51:19 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33240 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbcDUWvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 18:51:18 -0400
Received: by mail-qk0-f178.google.com with SMTP id n63so32177827qkf.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SuSlHC8z6f5zIeVt/0+CUYsSs4lA3LaF17O/Lb1hmG8=;
        b=aGcsWQZ/u+RRbNNBMlvqA2zTLHkZjtOVLlFGvNfWnTCFgU65j+a1yyDjrfwIZZ561U
         UnNAUvoIIX+w5CxrehOsZ5IUCQgE5KWGGk1TLNPs+zsmEQL211C+16nVLaFuo77wVuNl
         33OD7QpNaXDpz3foj0hA93cwje9FzEH+M3vkQpxZiWrcyR7tr2m9fVAtSsbFu0hEDoy2
         IBnUBnl8Oc0JjrhRsg/AZqWVHGjv3XHyfkYPIjN+fvAx48x7ICIaIawtdU5MYaR832Rj
         weWmZo2DeqBM92q3kOM6jD61cy11wCnjagSkpug8BNSU0b6KSXl7rFz44NePNL6UDM6g
         J/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SuSlHC8z6f5zIeVt/0+CUYsSs4lA3LaF17O/Lb1hmG8=;
        b=LREjTAcY+X9qrxLcpj8u+C2I3TakRa7Bd8oOcJXJj/XQbEoDhCx0l5Xq643lkky9GR
         q2lWJHgZ4MeRMrr6gK7PSESm2bO24wcLmMorrFUBeUvXNg4awXsRFgNLT7Gkpqz28R+b
         Kn3GebZjElX8Wi71KRjlSGPSOignpOcwFn6TCpQueGI354NQSIxZyjV3kf5mzL1eQpt4
         7htw+JHOchM+OtiIuKCOjR8kcEzxZDmBgb9uprvAo3nVv45Tc3c3Ss2oSVXgtBAre9s7
         WS5UqSZGIXwP/xz5KhKYC8MOW/AD5Cia1159JdwuA0uOjfRM3RgGoSXaYW/edcKA4Ha1
         OxpQ==
X-Gm-Message-State: AOPr4FU1GMcsySTMHwDNb1aGjGKlHRFrdb/+xF2Q7Uplpcr37EZMek1EYigYsrgmr5OFL238
X-Received: by 10.55.90.130 with SMTP id o124mr2278832qkb.178.1461279077339;
        Thu, 21 Apr 2016 15:51:17 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id j15sm1379361qge.0.2016.04.21.15.51.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Apr 2016 15:51:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292161>

On Thu, Apr 21, 2016 at 03:20:39PM -0700, Junio C Hamano wrote:
> * st/verify-tag (2016-04-19) 6 commits
>  - tag -v: verfy directly rather than exec-ing verify-tag
>  - verify-tag: move tag verification code to tag.c
>  - verify-tag: prepare verify_tag for libification
>  - verify-tag: update variable name and type
>  - t7030: test verifying multiple tags
>  - builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
> 
>  Unify internal logic between "git tag -v" and "git verify-tag"
>  commands by making one directly call into the other.
> 
>  Will merge to 'next'.

Hi Junio, 

Ramsay Jones[1] Suggested we dropped the extern qualifier on the
declaration of verify-tag() in tag.c as it is causing a warning with
sparse.

Should I re-roll this before it's merged into next?

Thanks!
-Santiago.

[1] http://thread.gmane.org/gmane.comp.version-control.git/292029
