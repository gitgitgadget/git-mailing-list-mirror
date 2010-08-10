From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git notes primer?
Date: Tue, 10 Aug 2010 13:32:39 +0200
Message-ID: <4C6138D7.6050300@drmicha.warpmail.net>
References: <201008101040.07172.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Tue Aug 10 13:32:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oin4I-00032k-74
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 13:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859Ab0HJLc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 07:32:26 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46913 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756571Ab0HJLcY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 07:32:24 -0400
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1854E46D;
	Tue, 10 Aug 2010 07:32:24 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 10 Aug 2010 07:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=8+eQaK+P2kCfCdIiND4RbuVJFdo=; b=HEma/a18MzUoM4ibXu4epa+re1VNuZf4yM7M7MB79FwTgmR0ty742Y/s5ZM4u/5ETOiZ+giqhir6vime9wvAWS186+IMvJOc1KJwc7UH7GxWmMuZ/IN64CtUQSzfDwuFYUSAFVvuBEKtmnl6QuL0DFlmDWa7LJhRH1Cg8fpfNOA=
X-Sasl-enc: O9evU9LS8oFkaHpExRl/ifaH00Bh92z5Bh2xndgjnFIS 1281439943
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 463C6400447;
	Tue, 10 Aug 2010 07:32:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9pre) Gecko/20100806 Lightning/1.0b2pre Lanikai/3.1.2
In-Reply-To: <201008101040.07172.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153094>

Thomas Koch venit, vidit, dixit 10.08.2010 10:40:
> Hi,
> 
> I'm working on a patch management system as topgit, but without the 
> complexity:
> http://koch.ro/blog/index.php?/archives/139-tnt-is-not-topgit.html
> 
> Before I continue with my current design, I wanted to have a look at git 
> notes, whether it would provide better mechanisms then tracking my meta 
> informations in a hidden background branch. (Much like pristine-tar does.)
> 
> However I couldn't get a grip on git notes:
> 
> - Is git notes the only command that works on notes?
> - How are notes saved inside GIT?

For thoese two it's best to look at the textconv-cache facility
developed by Jeff King which uses notes internally, without creating
"proper" notes.

> - Is git notes and it's implementation stable now?

The API should be as stable as any API on master.

> - Are there any tutorials on workflows with git notes?
> - What different use cases of git notes do you know?
> - What use cases triggered the development of git notes in the first place?

The origin was being able to amend/annotate commit messages without
rewriting history.

Others may have to say more ;)

Michael
