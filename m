From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] Documentation: Add filter.<driver>.* to config
Date: Wed, 06 Apr 2011 13:27:11 +0200
Message-ID: <4D9C4E0F.8050302@drmicha.warpmail.net>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com> <1302083854-2448-1-git-send-email-artagnon@gmail.com> <1302083854-2448-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 13:30:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Qwn-00046K-Hx
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 13:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab1DFLas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 07:30:48 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48178 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751673Ab1DFLar (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 07:30:47 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5428420A37;
	Wed,  6 Apr 2011 07:30:47 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 06 Apr 2011 07:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=oDkhlVh7/ZnyRuva58crqT5tYPk=; b=Hjm5IQd1OPCNnwU167u+KasDABS4osbJaeqW6g+8TVRJIvJiZnIjEGQv2XLYj4/rdibAWx+dulXYX+xfG28Ca/D8Fn9VtN1Ax/Gws/LjRJ31Jalrg7HWGU4+zyci0oUiruwgG4+XD4gvQatk5fAL4o8tzQNURqG7t1N4dhcdpAY=
X-Sasl-enc: ISHbH3UPFaChEQnN8b7hySvpXmDkTiI15OOqZPLu3JOq 1302089446
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 17CB044788C;
	Wed,  6 Apr 2011 07:30:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1302083854-2448-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170966>

Ramkumar Ramachandra venit, vidit, dixit 06.04.2011 11:57:
> Although the gitattributes page contains comprehensive information
> about these configuration options, they should be included in the
> config documentation for completeness.
> 
> Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/config.txt |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8ea55d4..654a3b8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -973,6 +973,15 @@ format.signoff::
>      the rights to submit this work under the same open source license.
>      Please see the 'SubmittingPatches' document for further discussion.
>  
> +filter.<driver>.clean::
> +	The command which is used to convert the contents of worktree
> +	file upon checkin.  See linkgit:gitattributes[5] for details.

I don't want to be a PITA, but is there any particular reason you are
refusing to use the article "a" even after repeated suggestions to use
it? (Also, I suggested to say what we are converting into here.)

> +
> +filter.<driver>.smudge::
> +	The command which is used to convert the blob object to
> +	worktree file upon checkout.  See linkgit:gitattributes[5] for
> +	details.
> +

You see, before my first response in this thread I thought: "Doing this
myself would be less work than replying and explaining things, but I'll
try to be nice."

Now, this is v4, I've even provided complete sentences ready for copy &
paste, and we're still iterating. It turned out to be *much more* work
than doing it myself. I'm sorry but I can't afford to spend even more
time on this.

>  gc.aggressiveWindow::
>  	The window size parameter used in the delta compression
>  	algorithm used by 'git gc --aggressive'.  This defaults
