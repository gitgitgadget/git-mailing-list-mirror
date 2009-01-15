From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] api-run-command.txt: talk about run_hook()
Date: Thu, 15 Jan 2009 07:49:51 -0800 (PST)
Message-ID: <m38wpczi09.fsf@localhost.localdomain>
References: <1232031618-5243-1-git-send-email-s-beyer@gmx.net>
	<1232031618-5243-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 16:51:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNUVA-00047N-42
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757404AbZAOPt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 10:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757266AbZAOPt4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:49:56 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:63064 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbZAOPty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:49:54 -0500
Received: by ey-out-2122.google.com with SMTP id 22so215249eye.37
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=BEUSDyQoh4Dgsn0XdF+GASewCUUIfwAP/+VcVpzivAY=;
        b=BJ7MU2IU5pGDneMciSHFoJXC45cT//exmFlFOiHHQUTfQarto3vW7lb5fFl6tP0Vl0
         2Jchw9AmniUrt0jjpt/Qohy88Al5INItjciD3O8fQKmwGeqJDsKRORug40egz4NSYlT2
         cTMyZPQHLy3K3dK0rX0MFOh+/GU1aVaG0yAiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Rdm4UOe0GWZ4CT1WOp7RlHiQuXtN57GgyYA8RzX6wz2xvw8vUhRkEbJYafZZgild5K
         VWyA6pcP+lDtCWbwpvgb00DMy/t/cyrK3hUNvROWtpO54nDx6AqrOoOj6+/tyeRyyNnE
         LDvnn2DX+9AAhlQroYByKo51Wj9rXg2mk/9ns=
Received: by 10.210.127.10 with SMTP id z10mr1806199ebc.106.1232034592930;
        Thu, 15 Jan 2009 07:49:52 -0800 (PST)
Received: from localhost.localdomain (abva168.neoplus.adsl.tpnet.pl [83.8.198.168])
        by mx.google.com with ESMTPS id 28sm93340eyg.44.2009.01.15.07.49.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jan 2009 07:49:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0FFnmVZ014558;
	Thu, 15 Jan 2009 16:49:48 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0FFnh3g014554;
	Thu, 15 Jan 2009 16:49:43 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1232031618-5243-2-git-send-email-s-beyer@gmx.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105841>

Stephan Beyer <s-beyer@gmx.net> writes:

> +`run_hook`::
> +
> +	Run a hook.
> +	The first argument is a string to an index file or NULL
> +	if the default index file or no index is used at all.

Errr...

        The first argument is a filename path to an index file,
        or NULL if hook uses default index file or no index is
        used at all. 

> +	The second argument is the name of the hook.

O.K.

> +	The further variable number (up to 9) of arguments correspond
> +	to the hook arguments.
> +	The last argument has to be NULL to terminate the variable
> +	arguments list.

Why the limitation of maximum of 9 hook arguments?

> +	If the hook is not executable, the return value is zero.

Or the hook does not exist, I assume.

> +	If it is executable, the hook will be executed and the exit
> +	status of the hook is returned.
> +	On execution, .stdout_to_stderr and .no_stdin will be set.
> +	(See below.)
> +
>  
>  Data structures
>  ---------------
> -- 
> 1.6.1.160.gecdb
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
