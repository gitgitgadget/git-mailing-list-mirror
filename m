From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] Makefile: implement help target
Date: Tue, 28 Sep 2010 14:24:52 -0700 (PDT)
Message-ID: <m3vd5pftox.fsf@localhost.localdomain>
References: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com>
	<4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 23:25:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hfc-0004mL-Rn
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 23:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab0I1VY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 17:24:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34943 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab0I1VYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 17:24:55 -0400
Received: by fxm14 with SMTP id 14so98539fxm.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=clUsGz5tp+grL9SJaajIZv8QSFaDp9zOeqDWx2ppzRM=;
        b=VjacVJ94GiFNzupvffynIJyc+NXrlhxzUBx9UNq5z3L6lqV/0ojHiMyAvoeNFz6zzH
         IHLhs5nLuXG8dXLcRFKV37j7nUPW1FMwC7yKkeLR7UZQr7aX6MCBahQmfCMnqqAeQTiX
         BaGkdcj8ejM3q6Gsg09wc8kYc0IH67zkExNHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=QTymtocGXgV4oFbpI6mvdAB6X3us2sBBo102dekjRfo2+TrmSzFDY/jYfjf1En2mtA
         kI14MEPVlISDDkCSblyAl9wtl88XyiEjBNvAOkVHqC+eQ32kBtJ4FYbY1BiFyzeRVyVq
         daSC5FqOGnV3blSXRNdTQPWBfR9HAcnsKxfrc=
Received: by 10.223.126.8 with SMTP id a8mr746591fas.17.1285709093841;
        Tue, 28 Sep 2010 14:24:53 -0700 (PDT)
Received: from localhost.localdomain (abvm69.neoplus.adsl.tpnet.pl [83.8.210.69])
        by mx.google.com with ESMTPS id j14sm3422582faa.23.2010.09.28.14.24.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 14:24:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8SLOPNu027804;
	Tue, 28 Sep 2010 23:24:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8SLNwsX027798;
	Tue, 28 Sep 2010 23:23:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157478>

I'm sorry for duplicated post; I made mistake that made vger anti-SPAM
filter stop it.

Michael J Gruber <git@drmicha.warpmail.net> writes:

> with automatic help text collection from lines starting with "# Help: " and
> preceding a make target.
> 
> Suggested-by: Stephen Boyd <bebarino@gmail.com>
> Helped-by: Andreas Ericsson <andreas.ericsson@op5.se>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Now how's this for portability and such? New output:
> 
> Build targets:
>     all:                Build the Git suite
>     dist:               Build git-$(GIT_VERSION).tar.gz source
>     dist-doc:           Build $(manpages).tar.gz and $(htmldocs).tar.gz
>     doc:                Build man pages and HTML docs
>     html:               Build HTML doc
>     info:               Build info docs
>     man:                Build man pages
>     pdf:                Build PDF docs
>     rpm:                Build source and binary RPM packages
> Clean targets:
>     clean:              Remove generated files but keep the configure script
>     distclean:          Remove generated files and the configure script
[...]

Shouldn't some excerpt of this be put in the commit message as example
output fragment?


>  Makefile |   43 +++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index db2efd6..497dd92 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,4 +1,5 @@
>  # The default target of this Makefile is...
> +# Help: Build: Build the Git suite
>  all::
[...]

>  ### Testing rules

Why can't you use existing headers in Makefile, like the one above, to
divide list of targets in "make help" output into categories of
targets?

> +
> +# Help: Help: Show help for main make targets
> +help:
> +	@awk '/^# Help:/ { l=substr($$0,8); \

Doesn't it need to be $(AWK) not awk?

> +		getline; \
> +		j=index(l,":"); \
> +		print substr(l,1,j-1), substr($$0,1,index($$0,":")), substr(l,j+2); \
> +		}' <Makefile | sort | while read category target text; \
> +	do \
> +		test "$$category" = "$$currcat" || printf "$$category targets:\n"; \
> +		currcat="$$category"; \
> +		printf "    %-20s%s\n" "$$target" "$$text"; \
> +	done
> -- 
> 1.7.3.98.g5ad7d
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
