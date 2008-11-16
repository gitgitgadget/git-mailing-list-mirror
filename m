From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 11/11] gitweb: CSS style and refs mark for detached HEAD
Date: Sun, 16 Nov 2008 01:08:55 +0100
Message-ID: <200811160108.56237.jnareb@gmail.com>
References: <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com> <1226620461-25168-1-git-send-email-giuseppe.bilotta@gmail.com> <1226620461-25168-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 01:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1VDc-0005KG-DK
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 01:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYKPAJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 19:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYKPAJE
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 19:09:04 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:6333 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbYKPAJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 19:09:03 -0500
Received: by ey-out-2122.google.com with SMTP id 6so779242eyi.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 16:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8ZG83HcHvX2W1zRBYtwTxsjA93xFBhotOqEOnsKC2OY=;
        b=HzIEXxzXM1qPYwFUuqI0qC0pSd4g/bItned6hb35SvGMsBV6Ts/YIGUHTYIEjgJqjg
         cQXNhh1Snlm3k/cq8oNX4Ki+t55Z1wDfRqV20/131yqv4kKl42OHXceDYHXexPqr2R1q
         awR5+Qx0x2i4QCKLA3FfrZLrKQT8YMlS8oQYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HvuQaPnDUVfo5izV3DHCylcebsNMkE2V9bkHT116aILFg991lIiPslFd2q6osBFzl/
         qTKduDsMF4tMqVuA1H/Lnd26gzzpWmgRnvsP59QZbFfK0umT5j60p6f5jfX+CUpAlT6H
         6hCVc2njUZT8xHo7L+iQIiGb4KGH8BI8mvyoU=
Received: by 10.210.41.1 with SMTP id o1mr2537773ebo.179.1226794141737;
        Sat, 15 Nov 2008 16:09:01 -0800 (PST)
Received: from ?192.168.1.11? (abwb4.neoplus.adsl.tpnet.pl [83.8.225.4])
        by mx.google.com with ESMTPS id 5sm1686891eyf.8.2008.11.15.16.08.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 16:09:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226620461-25168-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101100>

On Fri, 14 Nov 2008, Giuseppe Bilotta wrote:

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.css  |    5 +++++
>  gitweb/gitweb.perl |    2 +-
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 751749f..c0c4540 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -523,6 +523,11 @@ span.refs span.head {
>  	border-color: #ccffcc #00cc33 #00cc33 #ccffcc;
>  }
>  
> +span.refs span.detached {
> +	background-color: #ffaaaa;
> +	border-color: #ccffcc #00cc33 #00cc33 #ccffcc;
> +}

Nice and good. I think.

> +
>  span.atnight {
>  	color: #cc0000;
>  }
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 256c962..51e133d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2298,7 +2298,7 @@ sub git_get_references {
>  	my %refs;
>  	if (git_is_head_detached()) {
>  		my $hash = git_get_head_hash($project);
> -		$refs{$hash} = [ 'HEAD' ];
> +		$refs{$hash} = [ 'detached/HEAD' ];

This, not so much.

Please, if you use some _*hack*_, and adding 'detached/' prefix is
certainly hack (you could have modified format_ref_marker() instead,
and that is probably better solution), you really should explain it
in detail in commit message.  Otherwise some time later somebody would
examine the code, say 'WTF?!?'... and even git-blame would not help ;-/

>  	}
>  	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
>  	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
