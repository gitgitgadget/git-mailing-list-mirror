From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] Documentation: remove redundant colons in git-for-each-ref.txt
Date: Wed, 09 Mar 2011 08:55:37 +0100
Message-ID: <4D773279.4020709@drmicha.warpmail.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com> <1299590170-30799-2-git-send-email-alcosholik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 08:59:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxEIZ-0004Qm-4f
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 08:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521Ab1CIH7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 02:59:05 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47829 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753454Ab1CIH7E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2011 02:59:04 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 583BC208FC;
	Wed,  9 Mar 2011 02:59:03 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 09 Mar 2011 02:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=DBzdB6peb4GEi3f86gGu2xEt6Ak=; b=cpQJ1rymv5xZx4Sf8dOn/H45hGYK1+GHOECHdMc8WAMCVjop6B1RJWi2T99A/+V1buhK3GCPRPtHYN1QxhoWBJYVPCWKn+Q3Jz09XYa4ezNRt106MUVEftKk3orzeKpMREzxGn1yOxYqmIdEkK1QqxN54+cuBq0k9vEJwBXRGdE=
X-Sasl-enc: /JIXa5wMJ9ha64RqzVwcJfz4mEl546Unu6f+F/BoaRbD 1299657543
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DA5DD444C25;
	Wed,  9 Mar 2011 02:59:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <1299590170-30799-2-git-send-email-alcosholik@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168723>

Alexei Sholik venit, vidit, dixit 08.03.2011 14:16:
> Signed-off-by: Alexei Sholik <alcosholik@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index fac1cf5..bffb5d2 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -123,7 +123,7 @@ EXAMPLES
>  --------
>  
>  An example directly producing formatted text.  Show the most recent
> -3 tagged commits::
> +3 tagged commits:
>  
>  ------------
>  #!/bin/sh
> @@ -140,7 +140,7 @@ Ref: %(*refname)
>  
>  
>  A simple example showing the use of shell eval on the output,
> -demonstrating the use of --shell.  List the prefixes of all heads::
> +demonstrating the use of --shell.  List the prefixes of all heads:
>  ------------
>  #!/bin/sh
>  
> @@ -154,7 +154,7 @@ done
>  
>  
>  A bit more elaborate report on tags, demonstrating that the format
> -may be an entire script::
> +may be an entire script:
>  ------------
>  #!/bin/sh
>  

Maybe those were meant to be items in a labelled list, but asciidoc
doesn't seem to recognize the "::" as such here, so I think this change
is fine.

Michael
