From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Tue, 10 May 2016 08:37:11 +0200
Message-ID: <C5C883AD-E684-4D2F-811B-A479DE5E41AB@gmail.com>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de> <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 08:37:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01IG-0003bI-Ko
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 08:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbcEJGhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 02:37:14 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36225 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcEJGhN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 02:37:13 -0400
Received: by mail-wm0-f47.google.com with SMTP id n129so164155769wmn.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jgcfTgCvPZZdNhwPvUciawzJaKGkAaH34w16RksDxqU=;
        b=J6/K88DuSb6VQK/4eIBG2DZY54au+rlO7bNDslcQNptBRKytBBacjTGzP1imStQQb6
         hn1EwQBy12C+2t0aFf4Y3CNLPmOspi1QhKP/eJzn2gutcO/D4b6CyyOr7ZrbFE+2fmn1
         z8PnUCLqUHv6Fv51gcJpqdwnnhy9O8keH7UafvoFz67tf2gvIU4iDL7kUmS3kiqrhGgL
         dikI808Kfrtv6tOHH3s650HsTvRbs90xllUBQVowtLxl3lpU82y0UunOtNCpINV7LQtE
         iLyZdUHs6b1mQIvfPl7MEbcaWvsa6XEnArdUK165xl9FOiyCT6VYIyr0X6JMJIeLjOsx
         OZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jgcfTgCvPZZdNhwPvUciawzJaKGkAaH34w16RksDxqU=;
        b=gH0S6lUfXe7Jm/yZlBSYEjOHiqD+4k1jnMEld3kHO1MYctCY7h0CqEdree0xGG5/Bx
         wwmc2+ER5tz2Q50Oz8h5iu2c/sgebaFy43nTa/zhaGmyq3ZmD/4Dv6tZoK8P+h8y/Pj+
         tE4fR6GUCf0MCv359Be02gGRgb8ZSiMBmLvzctb8g9n9v/lC8tvRl/vsEQxyCqXSTvco
         CawLJpgzTZvSdK6Rx6FsZVzjY705w3vS/LCv3PprUzhL1Wfhxh1wtqz1B6V8CJ5IECvQ
         27e4WVWZeaH4RDL5b48MUvTDyKO3+g8J8oO2KyewhSvHAPS0ElGA3xLkJq89temZTrFK
         gc4w==
X-Gm-Message-State: AOPr4FWWLVTBrH0qCQNLCiDoTW3YDxrVTUM6X7H/JaziaIG6kJsfWa97ossELCmd7HbDNQ==
X-Received: by 10.194.61.231 with SMTP id t7mr41428064wjr.32.1462862231959;
        Mon, 09 May 2016 23:37:11 -0700 (PDT)
Received: from [10.32.249.146] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id a207sm1145633wma.8.2016.05.09.23.37.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 May 2016 23:37:10 -0700 (PDT)
In-Reply-To: <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294101>


> On 09 May 2016, at 08:18, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> 
> Lars Schneider noticed that the configuration introduced to test the extra
> HTTP headers cannot be used with Apache 2.2 (which is still actively
> maintained, as pointed out by Junio Hamano).
> 
> To let the tests pass with Apache 2.2 again, let's substitute the
> offending <RequireAll> and `expr` by using old school RewriteCond
> statements.

All Apache 2.2 tests run nicely on Travis CI with Ubuntu and OSX using
this patch series:
https://travis-ci.org/larsxschneider/git/builds/128955548

Thanks,
Lars

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> t/lib-httpd/apache.conf | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index b8ed96f..29b34bb 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -103,10 +103,6 @@ Alias /auth/dumb/ www/auth/dumb/
> 	Header set Set-Cookie name=value
> </LocationMatch>
> <LocationMatch /smart_headers/>
> -	<RequireAll>
> -		Require expr %{HTTP:x-magic-one} == 'abra'
> -		Require expr %{HTTP:x-magic-two} == 'cadabra'
> -	</RequireAll>
> 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
> 	SetEnv GIT_HTTP_EXPORT_ALL
> </LocationMatch>
> @@ -136,6 +132,14 @@ RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
> RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
> RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
> 
> +# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
> +# And as RewriteCond unfortunately lacks "not equal" matching, we use this
> +# ugly trick to fail *unless* the two headers are present.
> +RewriteCond %{HTTP:x-magic-one} =abra
> +RewriteCond %{HTTP:x-magic-two} =cadabra
> +RewriteRule ^/smart_headers/.* - [L]
> +RewriteRule ^/smart_headers/.* - [F]
> +
> <IfDefine SSL>
> LoadModule ssl_module modules/mod_ssl.so
> 
> -- 
> 2.8.2.463.g99156ee
> 
> 
