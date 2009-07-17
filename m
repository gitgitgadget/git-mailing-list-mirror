From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] post-update.sample referenced obsolete binary "git-update-server-info"
Date: Fri, 17 Jul 2009 18:12:12 +0200
Message-ID: <4A60A2DC.90506@drmicha.warpmail.net>
References: <874otb724d.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Simons <simons@cryp.to>
X-From: git-owner@vger.kernel.org Fri Jul 17 18:12:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRq33-00022U-3Z
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 18:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbZGQQMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 12:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934708AbZGQQMa
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 12:12:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57344 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934702AbZGQQM3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 12:12:29 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7D0BD3BC3B2;
	Fri, 17 Jul 2009 12:12:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 17 Jul 2009 12:12:29 -0400
X-Sasl-enc: a1Cq4H8N7HgIQDAFxgdN9g9bunBQu0hHFM9mAnMdl96v 1247847149
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EE5528BA8;
	Fri, 17 Jul 2009 12:12:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090717 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <874otb724d.fsf@write-only.cryp.to>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123472>

Peter Simons venit, vidit, dixit 17.07.2009 17:36:
> 
> 	Modified 
> diff --git a/templates/hooks--post-update.sample b/templates/hooks--post-update.sample
> index 5323b56..ec17ec1 100755
> --- a/templates/hooks--post-update.sample
> +++ b/templates/hooks--post-update.sample
> @@ -5,4 +5,4 @@
>  #
>  # To enable this hook, rename this file to "post-update".
>  
> -exec git-update-server-info
> +exec git update-server-info
> 

Have you actually tried? t/t5540-http-push.sh should fail if this really
needed a fix (libexec is in $PATH for hooks).

Michael
