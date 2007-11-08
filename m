From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Remove deprecated commands from command list and update
 manpages
Date: Thu, 08 Nov 2007 16:00:43 +0100
Message-ID: <4733249B.9020504@op5.se>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site> <7vlk998u6r.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711080041120.4362@racer.site> <20071108145435.GA18727@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq8sw-0002fC-LJ
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760524AbXKHPAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760817AbXKHPAt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:00:49 -0500
Received: from mail.op5.se ([193.201.96.20]:37624 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760399AbXKHPAs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:00:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A12311F0870A;
	Thu,  8 Nov 2007 15:59:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AsiyiR5LJRR7; Thu,  8 Nov 2007 15:59:06 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id D22061F08708;
	Thu,  8 Nov 2007 15:59:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071108145435.GA18727@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64034>

Jonas Fonseca wrote:
> ... and remove manpages of commands that no longer exists.
> 
> diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
> index 8139423..73c37b0 100644
> --- a/Documentation/git-var.txt
> +++ b/Documentation/git-var.txt
> @@ -20,7 +20,8 @@ OPTIONS
>  	Cause the logical variables to be listed. In addition, all the
>  	variables of the git configuration file .git/config are listed
>  	as well. (However, the configuration variables listing functionality
> -	is deprecated in favor of `git-config -l`.)
> +	is deprecated. Use gitlink:git-config[1] with the option '-l'
> +	instead.)
>  

Skip the parentheses. It reads better without it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
