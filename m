From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] Documentation: Allow custom diff tools to be specified
 in 'diff.tool'
Date: Mon, 04 Apr 2011 10:55:31 +0200
Message-ID: <4D998783.8060209@drmicha.warpmail.net>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com> <1301840722-24344-1-git-send-email-artagnon@gmail.com> <1301840722-24344-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 10:59:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6fcr-0001ii-S6
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 10:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab1DDI7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 04:59:04 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47644 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753929Ab1DDI7C (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 04:59:02 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4BBDE2071D;
	Mon,  4 Apr 2011 04:59:02 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 04 Apr 2011 04:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=weslM5gg0YoShCXhmqiQlL/XFRk=; b=fludPJNUtAKET51cJvzlyhNESZ/e9DYnYMJiXEdIOcGAmmArw7ZLeTuq5bjCOfeE6UuKb+CRe0a66vjhik7Sbk8LikqzFlItesg1cCKD8B7tJHAqkMB7wFhb1rxRsYST3LI8PVVYZgOYWJWT9207SsreARq02HuV65fM08dnYv4=
X-Sasl-enc: GQ6L81NJXjoLpYJo+XO8qWNiVMeCSAFJ67LKcL6Xl+SW 1301907542
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AD4D6403C9F;
	Mon,  4 Apr 2011 04:59:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1301840722-24344-4-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170799>

Ramkumar Ramachandra venit, vidit, dixit 03.04.2011 16:25:
> Apart from the list of "valid values", 'diff.tool' can take any value,
> provided there is a corresponding 'difftool.<tool>.cmd' option.
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/diff-config.txt |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 8c1732f..7f985a3 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -59,7 +59,9 @@ diff.tool::
>  	Controls which diff tool is used.  `diff.tool` overrides
>  	`merge.tool` when used by linkgit:git-difftool[1] and has
>  	the same valid values as `merge.tool` minus "tortoisemerge"
> -	and plus "kompare".
> +	and plus "kompare".  Any other value is treated is custom

"treated as a custom"

> +	diff tool and there must be a corresponding
> +	'difftool.<tool>.cmd' option.
>  
>  diff.<driver>.command::
>  	Defines the command that implements the custom diff driver.
