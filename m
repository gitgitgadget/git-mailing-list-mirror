From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/9] gitweb: cleanup error message produced by undefined $site_header
Date: Fri, 15 Jan 2010 15:49:53 -0800 (PST)
Message-ID: <m3pr5bc4jv.fsf@localhost.localdomain>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:50:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvw0-0008Ob-FX
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715Ab0AOXuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 18:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758710Ab0AOXt7
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:49:59 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35067 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286Ab0AOXt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 18:49:56 -0500
Received: by bwz27 with SMTP id 27so1025609bwz.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 15:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=WIQ3ub7iCBajGaVSsrPzC3UDZPWhPrpmTpLBn0tQHjk=;
        b=JDte03Q8U9655UNwcNiYkZhUWuKbFJPOcFSlkodX7kyvsCvmFnpm0+WQV0guhGHHIJ
         dKP1N0CIG4CRiossKUowSRYUEnuXNVmYjZdugb+vdI/JC9dE0CuCZUGbReLwAr/Ooijb
         Vwm9onoS58Ie9DUMb+zM9x2z+JNQvhCdGujPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vZukYIeHewlS6vRL0zAsubd02si4tlztyXkD87VYAcGt/6t7KAk4Itq+oQoaxUSHA7
         aMca/bzxIiupdMV+EW6ckELtLZAGJldUjal7P0f+D3H8RlZ7aZi/ks414Sc3A/UBEfae
         bZsBlWDdMnUkoiBMfPRsBIOqoJw9P8qlwjOGk=
Received: by 10.204.14.82 with SMTP id f18mr1698583bka.204.1263599394399;
        Fri, 15 Jan 2010 15:49:54 -0800 (PST)
Received: from localhost.localdomain (abwi123.neoplus.adsl.tpnet.pl [83.8.232.123])
        by mx.google.com with ESMTPS id 13sm1153884bwz.2.2010.01.15.15.49.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 15:49:53 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0FNnOWU031656;
	Sat, 16 Jan 2010 00:49:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0FNn8JP031649;
	Sat, 16 Jan 2010 00:49:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137163>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

I have modified commit message a bit

> If $site_header is not defined you get extraneous errors in the web
> logs:
> 
> [Wed Jan 13 16:55:42 2010] [error] [client ::1] [Wed Jan 13 16:55:42 2010]
>  gitweb.cgi: Use of uninitialized value $site_header in -f at .../gitweb.cgi line 3287.,
>  referer: http://git/gitweb.cgi
> 
> for example (line wrapped for better readibility).  This commit
> ensures that the variable is defined before trying to use it.

  Ordinarily build procedure ensures that $site_header is defined (but
  empty, therefore false-ish), so this issue might happen only because
  of errors in gitweb config file.  Nevetheless it is better to code
  defensively.

  Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 07fdeb5..c4a177d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3277,7 +3277,7 @@ EOF
>  	print "</head>\n" .
>  	      "<body>\n";
>  
> -	if (-f $site_header) {
> +	if ($site_header && -f $site_header) {

It should be, I think

+	if (defined $site_header && -f $site_header) {

although I guess that nobody would name $site_header file "0".

>  		insert_file($site_header);
>  	}
>  
> -- 

More important is the fact that it is not the only variable holding
file name, that is not checked that it is defined before use.  You
should do the same change also for $site_footer and $home_text, and
die_error(500, "Gitweb misconfigured") or just die_error(500) if
$projects_list is not defined.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
