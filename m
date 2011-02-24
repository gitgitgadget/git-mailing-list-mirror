From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] completion: complete "git diff ...branc<TAB>"
Date: Thu, 24 Feb 2011 13:24:57 +0100
Message-ID: <4D664E19.5080804@drmicha.warpmail.net>
References: <7vlj1677gz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 13:28:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsaIu-0007Gp-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 13:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab1BXM2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 07:28:15 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58276 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750867Ab1BXM2P (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 07:28:15 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8F50A207EA;
	Thu, 24 Feb 2011 07:28:14 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 24 Feb 2011 07:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=2ddRWF096z257rpeluLsByeyb0A=; b=dChyTTDa5BwrCbZT6cKeHqf+j8xBrhPq8J+FLbeLqBc0678MvYBzMpumHrbe0gF5/vvPmT9KiE+PUME/lmSvRQfdfdBC0DGjUMfCqY2kgkskX0d7YLIgSST2ynOYd1v2HYq3aqtiIomNdQI2xv3lEkt/J9/+MUcIryMle7W2Hcc=
X-Sasl-enc: fi/J3quSnShUV123KzG3d6oQ2HLaXk9r50pxiv7nvq5G 1298550494
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 896A5441A94;
	Thu, 24 Feb 2011 07:28:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vlj1677gz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167802>

Junio C Hamano venit, vidit, dixit 23.02.2011 22:43:
> While doing a final sanity check before merging a topic Bsomething, it is
> a good idea to review what damage Bsomething branch would make, by running:
> 
>     $ git diff ...Bsomething
> 
> I however find myself often typing "git diff ...B<TAB>", seeing nothing
> happening and then repeatedly hitting <TAB>, saying "huh? <TAAAAAAAAB>!".
> 
> This change would hopefully help me, and others like me.
> 
> Even though there is no point in supporting "git diff A..B" (you can say
> "git diff A B" just fine), but reusing complete-revlist was the easiest
> and that form is supported as a benign but not so useful side effect.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * I sent this out a while ago and have been using it ever since, but
>    totally forgot about it.  Likes, dislikes, alternatives?

Likes

Reminds me fo the following: Typing

git log origin/next@{1}..o<TAB>

gives

git log origin/next{1}..o

WTF? Completion eats at babies!

Michael
