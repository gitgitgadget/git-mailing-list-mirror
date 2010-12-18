From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] http-fetch docs: use <commit-id> consistently
Date: Sat, 18 Dec 2010 01:51:42 -0600
Message-ID: <20101218075142.GB6187@burratino>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
 <1292650725-21149-5-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 08:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTrc6-0004vI-Co
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 08:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab0LRHvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 02:51:49 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47560 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab0LRHvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 02:51:48 -0500
Received: by ywl5 with SMTP id 5so678524ywl.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 23:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0PjDtExIg5MdvNnBONkEX3j4hPSojeQ06guTc0kAS+M=;
        b=l4BID722eAMwVEzC1LoU8R6sMbB6g+nSKfx6fhb16uF5QQxOJCzAupxwcGUoHKPxKb
         vxcze5dkI5VNw/RGz+SNW1pCYz6DVUNqLkibpS1JJuVsKocloHIFZ/umDeUb/MXj7uw8
         rS290CkTm+JkgNoRdJfGyHPcUI30AvbgSHgb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Dq7b6ACd/jGJMsRPt7RjhtoQpo8b1wGPUx764edSjOdOVMB/xGUrYtaIkj076DMDkQ
         024De6kvTH5Zq1I+gwijyJjgSi34UMZsklFhQ3apLaU56KVECYGNzR5ebccmA/IkjwSk
         QXU5pRRhbP/EQHvZo76FH+GG/OmR8wFnHaJto=
Received: by 10.151.154.21 with SMTP id g21mr3827814ybo.199.1292658707942;
        Fri, 17 Dec 2010 23:51:47 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id c30sm5322970anc.0.2010.12.17.23.51.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 23:51:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292650725-21149-5-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163907>

Mark Lodato wrote:

> --- a/Documentation/git-http-fetch.txt
> +++ b/Documentation/git-http-fetch.txt
> @@ -8,7 +8,7 @@ git-http-fetch - Download from a remote git repository via HTTP
>  
>  SYNOPSIS
>  --------
> -'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
> +'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit-id> <url>
>  
>  DESCRIPTION
>  -----------
> @@ -16,7 +16,7 @@ Downloads a remote git repository via HTTP.
>  
>  OPTIONS
>  -------
> -commit-id::
> +<commit-id>::
>          Either the hash or the filename under [URL]/refs/ to
>          pull.

Does this mean the same thing as "commit id" in other manpages?
