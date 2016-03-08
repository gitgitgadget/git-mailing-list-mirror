From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: More configuration options for some commonly used command-line
 options
Date: Tue, 8 Mar 2016 20:13:23 +0530
Message-ID: <56DEE50B.4080408@gmail.com>
References: <56DD6EEE.4030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 15:43:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adIrN-000496-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 15:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbcCHOn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 09:43:29 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36498 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbcCHOn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 09:43:28 -0500
Received: by mail-pa0-f52.google.com with SMTP id tt10so13993101pab.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 06:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=O7qu17qNiPsWk6hrIo+TEZC6Kly+VogoPBVvJpM/O1s=;
        b=XILCGWF1UbXk6iegpXgQDUlIzBb67b0o0IiLYMU9upNGAZGNLsWOGb6/cUL6r/EvXS
         yKKqvyub8IC70B873qvLij8LDxF6I3dIMvDy3dCfWBF4cLy1NZEr3JVPWyDk+CwgBvHM
         A1+hUTrqyVboc+UCLNdeW5cvJspizyXiTK48lrHVaKtxeo+zlFzbGZHQqijHnSutZxe7
         0uMSwTqAKwWrnnbOVeJoeRGTvNUyRKnsT7581E3cW2PuZpVA/lNgeWhMEi5ig7gDkK8Y
         /i74zX+h93aHUKeaP9xnx0BohzH6255a+tXR9TkPGbmKU+hEQpIAztWmgoLzrg+q2CYr
         UNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=O7qu17qNiPsWk6hrIo+TEZC6Kly+VogoPBVvJpM/O1s=;
        b=gyy0WclDCEby47sR1gZOHSNmCc8PgWn7mNRSpUjk1dOHA93S15IJs8/9+RmL+Zs5U6
         Pnrk8Sy60SUS/CSvY1qKy0EDQCSxtGr68jiighkT6+E88Gt/L/gxp6tD65rWrJ1zzR+Y
         C4+qtZODHld9jar91HhdWJ1ohRQHy/sKmG2IA2QFPNKhhCT8XgSVC2ZCn/7dzsIy3fHi
         OvDwgajY3/H67OJaZ+UIFiHyHfxewp+QLevRQvj5/hno0mjL4uPvV21nDGybcIGC0LSS
         b/UEyfXsJ9vKj6YMqce8tCiIS9BjFXAbi1n0edluEJUxZTLPW0Jga6YPYNpkZPrO+p8k
         ck3Q==
X-Gm-Message-State: AD7BkJKlKP9IgUr3jM/doROP5o5Vlxu42JkDKF6aov0lLYDy3vYfKICdWvzNePeeSGbtJg==
X-Received: by 10.66.221.167 with SMTP id qf7mr42129907pac.94.1457448207368;
        Tue, 08 Mar 2016 06:43:27 -0800 (PST)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id o7sm5085768pfj.89.2016.03.08.06.43.25
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2016 06:43:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <56DD6EEE.4030900@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288437>

Sidhant Sharma wrote:
> Hi,
>
> Regarding the GSoC Microproject 'Add configuration options for some commonly
> used command-line options', currently the list [1] mentions only
> `git commit -v`. Can the following also be candidates for configurations?
> * git log -p
> * git remote -v
> * git branch -v
>
>
> Regards,
> Sidhant Sharma [:tk]
>
>
> [1]: https://git.github.io/SoC-2016-Microprojects/
Perhaps they can be added as Microprojects for the next GSoC.
Comments?


Regards,
Sidhant Sharma
