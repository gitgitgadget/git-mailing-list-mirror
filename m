From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 06/11] gitweb: use CSS to style split head lists.
Date: Sat, 15 Nov 2008 01:20:50 +0100
Message-ID: <200811150120.51805.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 01:22:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L18ve-0003ZH-EW
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 01:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbYKOAU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 19:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbYKOAU6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 19:20:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:46122 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbYKOAU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 19:20:57 -0500
Received: by ey-out-2122.google.com with SMTP id 6so686553eyi.37
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 16:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=e4TWNkSpNh35x5qh2zhp780mvHBDWubpVzlBZqK+MwA=;
        b=pUn7jJ/+lsE87iSIAAiB3kf3e6IjRUwTNTL0RVu7b2vwrOBdg/h/spORxpyXo56fFx
         7iEOQCHTmKJVd36cHa/TXNkump2oXGNk9FY51lP9gqqzHG1HQyz+t7WcNF/kD5LzBmK3
         ukJ0Ohyt8l8OVLq4vIo72FaK+natHxdRvOT1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UdugnoYkcSVs9IbJZd+3ynK2Z/L9KWLCni0coK4f2ZfrwFAGae+IAf8xNWH81EiHxp
         em1EEpNAt3Hbi/SeaUkx2RvEMlMQ9fAzGqg7iZbqTcpkPXIU8jgYNsp9D0gs2FByjKh4
         h6HEOtquPmfu/djdgZovMZAxmwzXz/sWkulsA=
Received: by 10.210.76.19 with SMTP id y19mr1678202eba.52.1226708453467;
        Fri, 14 Nov 2008 16:20:53 -0800 (PST)
Received: from ?192.168.1.11? (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id 7sm82183eyg.9.2008.11.14.16.20.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Nov 2008 16:20:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101039>

On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:

> Introduce a new div class 'subsection' in the CSS and use it to style
> split head lists.

I think this patch should be squashed with the previous one.
 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.css  |   10 ++++++++++
>  gitweb/gitweb.perl |    4 +++-
>  2 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index a01eac8..751749f 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -8,6 +8,16 @@ body {
>  	color: #000000;
>  }
>  
> +div.subsection {
> +	border: solid #d9d8d1;
> +	border-width: 1px;
> +	margin: 10px;
> +}
> +
> +.subsection .title {
> +	font-size: smaller;
> +}

Hmmm... do we use "subsection title" class anywhere? If you did
introduce it in earlier patch, this is one more reason to squash
them (after significant reworking)... ahh, this is link or span
or div with class .title insider div.subsection, sorry.

> +
>  a {
>  	color: #0000cc;
>  }
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 836b6ba..03e0b21 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4296,9 +4296,11 @@ sub git_split_heads_body {
>  	} @$headlist;
>  
>  	foreach $leader (sort(keys %headlists)) {
> -		print "<b>$leader</b><br/>\n" unless $leader eq "\000";
> +		print "<div class=\"subsection\">\n";
> +		git_print_header_div(undef, $leader) unless $leader eq "\000";

Again, cannot this ugly guardian value be replaced by for example empty
string '', or undef?

>  		$list = $headlists{$leader};
>  		git_heads_body($list, $head, $from, $to, $extra);
> +		print "</div>\n";

Just in case, for easier editing and easier browsing through *occur*
buffer, I'd use here

+		print "</div>\n"; # class="subsection"


>  	}
>  }
>  

-- 
Jakub Narebski
Poland
