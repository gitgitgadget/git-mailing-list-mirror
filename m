From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/9] gitweb: add a get function to compliment print_local_time
Date: Sat, 23 Jan 2010 03:13:10 -0800 (PST)
Message-ID: <m3r5phaxd1.fsf@localhost.localdomain>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Jan 23 12:15:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYdwv-000513-VQ
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 12:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab0AWLNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 06:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972Ab0AWLNN
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 06:13:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:46265 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0AWLNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 06:13:12 -0500
Received: by fg-out-1718.google.com with SMTP id l26so386521fgb.1
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 03:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=/iadZi2Lm725/RwH6P4JbuHYne+4vs4Mw5GMbRwf9fw=;
        b=Wx3/e167+1r14bZaxlOfvoN+x88Ngh7T01Gk9jQSQW6HYyUzOr9cwieOiiV/Avj7C8
         6Gj/Dsm6hsT43AYsItWuXWrxCiMmZeaVLGv1i8Zu7TzPv/D4AVTkSNkzCci0qjqZuyNi
         sGMtokVWjPKoMChWCkgefXlJGcDzJ4F0cZ0bA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=GtUQ6q9jhzHaY+TtkAd09C1G4WSKMnaIN1ccQzY8fB0fCW10kg8TRGfdJWF18G9jGr
         f0t9U5QxS9Qpr5vEEIf1ldHBN7Qtnbh/i4rHooxL89IEQydEoTo6UZw6TyNCaAO4Qgad
         OUj4g5YEE5YaOoXFLQvEkyBR0/9WB5MKfpFBU=
Received: by 10.87.15.29 with SMTP id s29mr6675233fgi.34.1264245190866;
        Sat, 23 Jan 2010 03:13:10 -0800 (PST)
Received: from localhost.localdomain (abws72.neoplus.adsl.tpnet.pl [83.8.242.72])
        by mx.google.com with ESMTPS id l19sm83209fgb.10.2010.01.23.03.13.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 03:13:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0NBCbfi023359;
	Sat, 23 Jan 2010 12:12:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0NBCQTJ023343;
	Sat, 23 Jan 2010 12:12:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137834>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

Should authorship be associated with eaglescrag.net or kernel.org?

> This adds a get function for print_local_time so that the basic
> function can be used outside of their straight printing operation.

Signoff?
> ---
>  gitweb/gitweb.perl |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b41bc33..d38aad6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3537,14 +3537,21 @@ sub git_print_header_div {
>  }
>  
>  sub print_local_time {
> +	print get_local_time(@_);
> +}
> +
> +sub get_local_time {

This new function should be rather named 'format_local_time', to
follow gitweb convention of naming subroutines.  (And of course commit
message needs to be changed accordingly.)

This comment applies also to the following patch.

> +	my $localtime = "";
>  	my %date = @_;
>  	if ($date{'hour_local'} < 6) {
> -		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> +		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
>  			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
>  	} else {
> -		printf(" (%02d:%02d %s)",
> +		$localtime .= sprintf(" (%02d:%02d %s)",
>  			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
>  	}
> +
> +	return $localtime

Style (terminate statement with ';'): 

  +	return $localtime;

>  }
>  
>  # Outputs the author name and date in long form
> -- 
> 1.6.5.2
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
