From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Jan 2013, #11; Wed, 30)
Date: Wed, 30 Jan 2013 19:19:52 +0000
Message-ID: <20130130191952.GK1342@serenity.lan>
References: <7vd2wmldw9.fsf@alter.siamese.dyndns.org>
 <20130130190759.GJ1342@serenity.lan>
 <7v4nhylbus.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 20:20:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dCw-0004JR-Lu
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 20:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741Ab3A3TUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 14:20:03 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:52147 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab3A3TT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 14:19:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 11EE760651D;
	Wed, 30 Jan 2013 19:19:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 46qbmp4lSD+Q; Wed, 30 Jan 2013 19:19:58 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 7BC206064FF;
	Wed, 30 Jan 2013 19:19:54 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v4nhylbus.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215060>

On Wed, Jan 30, 2013 at 11:17:15AM -0800, Junio C Hamano wrote:
> Let's do something like this on top of the topic.

This looks good to me.

>  INSTALL | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/INSTALL b/INSTALL
> index b96e16d..2dc3b61 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -131,8 +131,9 @@ Issues of note:
>  	  use English. Under autoconf the configure script will do this
>  	  automatically if it can't find libintl on the system.
>  
> -	- Python version 2.4 or later is needed to use the git-p4
> -	  interface to Perforce.
> +	- Python version 2.4 or later (but not 3.x, which is not
> +	  supported by Perforce) is needed to use the git-p4 interface
> +	  to Perforce.
>  
>   - Some platform specific issues are dealt with Makefile rules,
>     but depending on your specific installation, you may not
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
