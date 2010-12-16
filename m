From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: decorate a bit more remotes
Date: Thu, 16 Dec 2010 14:23:32 -0800 (PST)
Message-ID: <m3tyjglxi0.fsf@localhost.localdomain>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
	<1292535801-7421-3-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMEd-0004ff-Sm
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab0LPWXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:23:35 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:58679 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab0LPWXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 17:23:34 -0500
Received: by fxm18 with SMTP id 18so58807fxm.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=E/zHdsNncgqqyqXWGrThqWAEo7Pt10VjZehuF/VhcWg=;
        b=r2Rw7De97bSUPIYqw0yFKkpwB2Ny6vLUQOQU6cC//47tydCUD6t17CslEhZLjm5ng4
         d5pnnXVgCTO+ShObnDWY+xiZMGchdbu/qFDv+Ckzd4IgL36acxRn7xWyey+2uOAdGSph
         G2YbGKVzPyvEpoJt1hTJvrBqG6ifEAwe+u/QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=K0F3kwSB/y/PgaGTXLxc++d7EFTMiVuiIOQCRaE9ZeAmutmZaMJg1mxrT+J71ExkHR
         TPRW535FTiFb5AbyrU2abb9Ep/cfJcNT/pF62ol5jJmtA/VgkzaIsX/Qvp/0vJc2Dqdb
         chBopZUhnyJT4B2NEjJoiZIE8yTSWX1TZPNDg=
Received: by 10.223.86.196 with SMTP id t4mr365273fal.34.1292538213652;
        Thu, 16 Dec 2010 14:23:33 -0800 (PST)
Received: from localhost.localdomain (abvg92.neoplus.adsl.tpnet.pl [83.8.204.92])
        by mx.google.com with ESMTPS id n3sm215365fax.31.2010.12.16.14.23.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 14:23:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAGMMqtc015806;
	Tue, 16 Nov 2010 23:23:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAGMMV3B015796;
	Tue, 16 Nov 2010 23:22:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1292535801-7421-3-git-send-email-sylvain@abstraction.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163824>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> ---
>  gitweb/gitweb.perl |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index db18d06..9398475 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5127,13 +5127,13 @@ sub git_remote_block {
>  
>  	if (defined $fetch) {
>  		if ($fetch eq $push) {
> -			$urls_table .= format_repo_url("URL", $fetch);
> +			$urls_table .= format_repo_url("<strong>URL:</strong>", $fetch);

I would really prefer to use CSS for that...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
