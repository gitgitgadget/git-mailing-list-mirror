From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: decorate a bit more remotes
Date: Mon, 20 Dec 2010 15:11:14 -0800 (PST)
Message-ID: <m3d3owkplq.fsf@localhost.localdomain>
References: <1292871681-4818-1-git-send-email-sylvain@abstraction.fr>
	<1292871681-4818-3-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Tue Dec 21 00:11:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUot0-0006Tl-OZ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 00:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758157Ab0LTXLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 18:11:18 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:62088 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab0LTXLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 18:11:17 -0500
Received: by bwz16 with SMTP id 16so3914341bwz.4
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 15:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kB97qFHmvKDnKY87zQwkwu9N3phLATvxENHO5WBPbyw=;
        b=H69RbELDX4vT8v+3gj5VAjpiK149y2q9nIDdTi4UVJQ/EA4z5JN3CgHd7EDMNSFHMO
         WMTT3H7anFvZgZLYrwYUgNfjeUf5VggpbSU+vT8a1hyU+VMaiiHqSTqLLrIjcDeRMGFH
         JD/QoHf81Eb1IeYN4iu6PNmsUGDKi5y/jOG+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AghARh1WJUDEjBUytaiM5eqhQDDZ4XWMFHV6rkFrbR6C/lAd+vaoGUANGnDVd0OYOj
         IDb2jlzAvwe9bdRmfJSFSaK83JXnsaVGWCvhLpbnbjCcsQMww4bcECMj3L/7G9iXvrlG
         t1FRt7HCp8lossc6JUd/EeAVT4uindYOCLqS4=
Received: by 10.204.61.74 with SMTP id s10mr4136280bkh.91.1292886676161;
        Mon, 20 Dec 2010 15:11:16 -0800 (PST)
Received: from localhost.localdomain (aehn132.neoplus.adsl.tpnet.pl [79.186.195.132])
        by mx.google.com with ESMTPS id q18sm3870369bka.3.2010.12.20.15.11.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 15:11:14 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBKNAfDR014538;
	Tue, 21 Dec 2010 00:10:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBKNAPWi014534;
	Tue, 21 Dec 2010 00:10:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1292871681-4818-3-git-send-email-sylvain@abstraction.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164017>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> -			$urls_table .= format_repo_url("URL", $fetch);
> +			$urls_table .= format_repo_url("<span class=\"bold\">URL:</span>", $fetch);

[...]
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 79d7eeb..ce902f5 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -579,6 +579,10 @@ div.remote {
>  	display: inline-block;
>  }
>  
> +.bold {
> +	font-weight: bold;
> +}

<span class="bold"> is not much different from <strong> or <b>;
I'd rather you use some semantic name for the class, describing
what content it contains rather than what style it uses.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
