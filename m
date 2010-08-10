From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Gitweb: Use a default for a bad env config file variable
Date: Tue, 10 Aug 2010 15:42:05 -0700 (PDT)
Message-ID: <m3tyn22iqd.fsf@localhost.localdomain>
References: <AANLkTi=42V8=26oEwcNOHubuK+VAf-QaYnvCLAKQ0xtg@mail.gmail.com>
	<vpq4of2scen.fsf@bauges.imag.fr>
	<AANLkTi=UCJa9uT5i9TRB9hGsH1D8b9DgB49TPM5k1htQ@mail.gmail.com>
	<AANLkTikDtK0vyRwJE3Un5uFkK7FzoWtiWpL8gPqLQjH5@mail.gmail.com>
	<1281458849.28858.18.camel@ping.CS.McGill.CA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, avarab@gmail.com
To: James Shubin <purpleidea@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 00:42:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OixWQ-0001Lq-HX
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 00:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029Ab0HJWmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 18:42:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48299 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758016Ab0HJWmH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 18:42:07 -0400
Received: by bwz3 with SMTP id 3so2254193bwz.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UKg+dlCTuZq79csJAuiODaXrx5QP3TbTUfz9bMLNpDc=;
        b=q9+NXGVGpqyZxWKBLi/nN2n/xvm8j0RJQ/mqebs3Wv7QDQGHDnyhr6XyKRNMIZc3L5
         MfayMYooR8MEbqJMzxWrC9elag+eosETfEtjKqqGEb2nvaE6HQta91eAvHIzluDrU4Ji
         y5LHQIhqXfvipppEzABU0u4/uICIJ9sY6DtP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Ol8PG30aHzFIphVXuxcZCb1jwHj+6mFEsXJnbeDA5eV7UtGV58PyoX/yv1G6xHQNhC
         4l3qYPx+kAuoOp2OrvGSf4dbj3o5Lpf5vipFnXGuHbTz4+5u6bdxwqp11BEW5jDcvTxX
         9tUFLzDlsPwGDIgOLdfSTBwEoxc55d+zA5qYA=
Received: by 10.204.2.139 with SMTP id 11mr12376914bkj.202.1281480126335;
        Tue, 10 Aug 2010 15:42:06 -0700 (PDT)
Received: from localhost.localdomain (abwr164.neoplus.adsl.tpnet.pl [83.8.241.164])
        by mx.google.com with ESMTPS id f10sm4588363bkl.5.2010.08.10.15.42.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 15:42:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7AMg8Hi009618;
	Wed, 11 Aug 2010 00:42:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7AMflDI009614;
	Wed, 11 Aug 2010 00:41:47 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1281458849.28858.18.camel@ping.CS.McGill.CA>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153171>

James Shubin <purpleidea@gmail.com> writes:

> From: James Shubin <purpleidea@gmail.com>

Small nitpick: you need line like the above only if the From: header
in your email is diferent from the authorship you want to have in
commit, i.e. when you are sending email from other email account, or
when you are (re)sending someone's else patches.

In this patch situation it is not, I think, necessary.

> Signed-off-by: James Shubin <purpleidea@gmail.com>
> ---
> It's quite trivial really, all that changes is that if someone sets
> the environment variable: $GITWEB_CONFIG_SYSTEM, and this points to
> something like: /srv/gitosis/gitweb.conf, which doesn't actually
> exist, then gitweb will default to trying out the built in default of
> /etc/gitweb.conf (if it was built with that value).
> 
> This patch should make it easier for people who are configuring
> gitweb+gitosis, so that a separate gitweb.conf config file can be used
> to call the main config, but which doesn't null out the system
> defaults if it is missing.

First, why it is needed?  Why can't you just have GITWEB_CONFIG_SYSTEM
(or GITWEB_CONFIG) environment variable visible to gitweb.cgi that
points to existing file?

Second, is there any history behind providing this fallback only for
$GITWEB_CONFIG_SYSTEM variable, and not for $GITWEB_CONFIG?  Currently
gitweb use environment variable if it exists, falling back to build-time
value (might be default), and using first of $GITWEB_CONFIG and 
$GITWEB_CONFIG_SYSTEM that exists.

> PS: thanks to everyone for their patience with my first patch.
> This applied cleanly with git am, let me know if I should do anything
> else differently.
> 
>  gitweb/gitweb.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4efeebc..43294e1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -605,6 +605,10 @@ sub evaluate_gitweb_config {
>  	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
>  		do $GITWEB_CONFIG_SYSTEM;
>  		die $@ if $@;
> +	# if config file from env is missing, then try the default anyways

Minor nitpick: Actually that is not default, but build-time value, which
has a default.

> +	} elsif (-e "++GITWEB_CONFIG_SYSTEM++") {
> +		do "++GITWEB_CONFIG_SYSTEM++";
> +		die $@ if $@;
>  	}
>  }
>  
> -- 
> 1.7.0.4

-- 
Jakub Narebski
Poland
ShadeHawk on #git
