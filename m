From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv18 00/11] Expose
Date: Thu, 25 Feb 2016 15:19:04 -0800
Message-ID: <20160225231904.GT28749@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com,
	peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:19:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5Bh-00065r-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbcBYXTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:19:09 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33007 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbcBYXTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:19:08 -0500
Received: by mail-pf0-f173.google.com with SMTP id q63so40674595pfb.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bidXSvNUkIKIIPrI5f9m+r5SRAIUUZagg6U9oWZGSk4=;
        b=eLjKpRZnDsFuO9bt5CxacAGawpnYiNO3QjXnL5zUGske58yNZ9p4gBt8CcXySpDo8C
         QuHHnQDAUgz5G7LYLXUWVDN0kAZ2MPtMp+gCOBg16o9Ua48ZJKURAiuJkjhYFHvkI/mE
         EKn651bq/fkSPXGO05Jj+SztdfuzREmW+OX1iXrLNH03EVS/JGSdNyQr7jDRkdafzIvb
         m07iphPQWelVljitja5wohypFciBwclioodQPYIbnneXLH1wJh52/0s98lqu3pfw+Tz4
         2vBV9ugYCHC27oO7RLRdpaPJBThqSPWo32Q4QYHRw4RSJdm+GBy7Wg0ToZIn0yPvPWFM
         fQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bidXSvNUkIKIIPrI5f9m+r5SRAIUUZagg6U9oWZGSk4=;
        b=gNHuu3eUjIBbMDc7wKq5gsmuKPVnQBhKuOD5CTjjG7m8YeQlbd64qsLbylYGRurE72
         GjEiGrwxcxLgo/ACnSpPVOKoXIs6XJxHH59mlKDrNIiucL7hanNgUJqvu7pROIg3PN0f
         C3wKoIcxDoF7sOk3olUxvTw0t6dL02Mfb6EvOULBD6/Rsg1f3PozN2xJJ3ZhKSNMdOhF
         HYKhs5Q2zWUu30da0gUZ8WX9gRTDZ+b1THWNMZP0eEsq0jKRIHhlyzFVolOTtLfa0Hox
         ad4CHlKBaVwcWbYFIdyYCCR1RCH+1AcIHXbYfYm/VTo01MkQ6BFv8IDeDBKHln6+9T9J
         w8Dg==
X-Gm-Message-State: AG10YOSzn9mME4ZB0P3C52o82bnUZDlXf9XrfV36uyXQmIG7eGjkkt5cxmJW9Sj2ovJDYA==
X-Received: by 10.98.19.205 with SMTP id 74mr66869642pft.31.1456442347028;
        Thu, 25 Feb 2016 15:19:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d4a8:9152:117:98a9])
        by smtp.gmail.com with ESMTPSA id v7sm14533404pfi.56.2016.02.25.15.19.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 15:19:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287489>

Stefan Beller wrote:

> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -465,14 +465,14 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  		NULL
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, module_update_clone_options,
> +	argc = parse_options(argc, argv, suc.prefix, module_update_clone_options,
>  			     git_submodule_helper_usage, 0);

I would have expected this to use 'parse_options(argc, argv, prefix, ...' since
I wouldn't expect a command-specific --prefix= parameter to affect the
interpretation of relative filenames in other parameters.

Now that I look around more, it seems that other submodule--helper subcommands
have the same strange behavior of overwriting the 'prefix' var.  So I take
back my suggestion of using a different variable --- that can be addressed in a
separate patch that deals with them all at once.

Sorry to flip-flop like this,
Jonathan
