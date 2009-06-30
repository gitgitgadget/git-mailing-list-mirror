From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv8 6/7] gitweb: picon avatar provider
Date: Tue, 30 Jun 2009 22:23:22 +0200
Message-ID: <200906302223.23190.jnareb@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjyN-0007Ix-IR
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbZF3UaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbZF3UaI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:30:08 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:62274 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbZF3UaC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:30:02 -0400
Received: by bwz25 with SMTP id 25so119612bwz.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/IHs0CFifT9p9fw9jOT54h8sujWzfnUjAqxFcJ++9oo=;
        b=N3hyYIG9NhminV9Q88vEqH0Su+or9ZGUoINTwN29I9h6CF8OOIQcghmZzQm/XQ5j8x
         yKsip+oBanetQ9vZWnlfQlZgH6p9vAORGpbH79Cbk+gSVbneKJhQobG+U6Pka4D0ES+z
         9H8Ug+q4tg9j/Lw9fu1t9WSsrbrzB3TRz0fPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sy0NIsLBKSTk9mj34sbHgC9vKLufJXHbcY8H9mWBHIvRndwCPP45FzbGkm2sUhfVuQ
         rrGpjlyPh5TqRHYXVG96Tot2ovix24zNgin7vsVpGTTO+2nV3cg10qBkFXp38zntr7JI
         WjLz/CcoutOfCIfIhQ5uWHg5zFrcyPZGLsZfg=
Received: by 10.102.228.10 with SMTP id a10mr2931733muh.16.1246393804298;
        Tue, 30 Jun 2009 13:30:04 -0700 (PDT)
Received: from ?192.168.1.13? (abvk72.neoplus.adsl.tpnet.pl [83.8.208.72])
        by mx.google.com with ESMTPS id t10sm2191632muh.0.2009.06.30.13.30.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 13:30:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246312854-3365-7-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122537>

On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:

> Simple implementation of picon that only relies on the indiana.edu
> database.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Well written, and nice example how to add other avatar providers.

Acked-by: Jakub Narebski <jnareb@gmail.com>

[...]
> -	# Currently only the gravatar provider is available, and it
> -	# depends on Digest::MD5. If an unknown provider is specified,
> -	# the feature is disabled.
> +	# Currently available providers are gravatar and picon.
> +	# If an unknown provider is specified, the feature is disabled.
> +
> +	# Gravatar depends on Digest::MD5.
> +	# Picon currently relies on the indiana.edu database.

[...]
> -	# Currently only gravatars are supported, but other forms such as
> -	# picons can be added by putting an else up here and defining $url
> +	# Other providers can be added by extending the if chain, defining $url
>  	# as needed. If no variant puts something in $url, we assume avatars
>  	# are completely disabled/unavailable.

I see that you have updated comments too.

-- 
Jakub Narebski
Poland
