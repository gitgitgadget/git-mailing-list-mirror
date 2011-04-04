From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] Documentation: Add filter.<driver>.* to config
Date: Mon, 04 Apr 2011 10:46:03 +0200
Message-ID: <4D99854B.70801@drmicha.warpmail.net>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com> <1301840722-24344-1-git-send-email-artagnon@gmail.com> <1301840722-24344-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 10:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6fTv-0004vo-0F
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 10:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab1DDIti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 04:49:38 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58433 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751459Ab1DDIth (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 04:49:37 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C657F204E1;
	Mon,  4 Apr 2011 04:49:36 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 04 Apr 2011 04:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=MjAu5V6N1rhBibO37ojkQSh6M6M=; b=LdvDbZfDeET61n2yADOPsyFoauzfvYqG1OGrSgKI7Q40ClAxfkEmUWuSgr8mlVXjyogK6VGu7k6a2LrGRBscxFYvyBR8kGMAPEhlqaUl2/LI+dHWnNhFq917YYVK+wuBAHzpldcV5aOZQUN92rBL4Etmd6iLt1FqqcZa8cl5CyA=
X-Sasl-enc: zTXdX9VT4+i6ODH2a48JA+eE7PBxAGi659Q6nsPo7Oby 1301906976
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 466CF401369;
	Mon,  4 Apr 2011 04:49:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1301840722-24344-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170796>

Ramkumar Ramachandra venit, vidit, dixit 03.04.2011 16:25:
> Although the gitattributes page contains comprehensive information
> about these configuration options, they should be included in the
> config documentation for completeness.
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/config.txt |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8ea55d4..711072c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -973,6 +973,16 @@ format.signoff::
>      the rights to submit this work under the same open source license.
>      Please see the 'SubmittingPatches' document for further discussion.
>  
> +filter.<driver>.clean::
> +	Defines the command to be used to convert the contents of
> +	worktree file upon checkin.  See linkgit:gitattributes[5] for
> +	details.
> +

Here we go again :) I rever Desmond Tutu, I dislike "to... to"... And
articles. Also, every option "defines" something, no need to say that:

The command which is used to convert the content of a worktree file to a
blob upon checkin.


> +filter.<driver>.smudge::
> +	Defines the command to be used to convert the blob object to
> +	worktree file upon checkout.  See linkgit:gitattributes[5] for
> +	details.
> +

The command which is used to convert the content of a blob object to a
worktree file upon checkout.

>  gc.aggressiveWindow::
>  	The window size parameter used in the delta compression
>  	algorithm used by 'git gc --aggressive'.  This defaults
