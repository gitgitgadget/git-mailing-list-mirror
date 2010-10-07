From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git push <branch-name>
Date: Thu, 07 Oct 2010 12:50:11 +0200
Message-ID: <4CADA5E3.5060405@drmicha.warpmail.net>
References: <AANLkTineD3DYsBJBBt13-EWX0_1YUf1cf1wTGUL-jRkg@mail.gmail.com>	<AANLkTinjEoDWhq_EWPj+z++g-b7XMA9d2orXRGtuHyRB@mail.gmail.com> <AANLkTi=k9aEqpvoEvU5f-t-63==fouFmJ+OxO=6sQd89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 12:50:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3o38-0005qU-S1
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 12:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab0JGKuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 06:50:01 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38751 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753958Ab0JGKuA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 06:50:00 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9D027227;
	Thu,  7 Oct 2010 06:49:59 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 07 Oct 2010 06:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=M+MDq64ljBNdsbswh24B308CH9w=; b=AIwDp0PNLpJMGt+p4rrRMd/UoA8lmf12g0/h9ytcgKPUsDiEDhoqwgp5qoQTOSAU4Ml3FL9ffK+mFtokiZR04o4L5EyNlJBhHN7xcPjQ9XFy37/Xjp/7R4HMerORy8h8n3Gng70lzmNa7IUE16aU3tontWrPhloc0YET5bp4RqI=
X-Sasl-enc: 3y40tNUyNubFKHYxd7rNvIj1pIvBydXbPZBGdc7dhZUp 1286448599
Received: from localhost.localdomain (wlanstud033.rz.tu-clausthal.de [139.174.16.33])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A42D140099A;
	Thu,  7 Oct 2010 06:49:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTi=k9aEqpvoEvU5f-t-63==fouFmJ+OxO=6sQd89@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158394>

Eric Raible venit, vidit, dixit 06.10.2010 02:52:
> On Tue, Oct 5, 2010 at 3:35 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> Since it is such a simple command expansion, why not create an alias
>> that does just that?
> 
> Because I don't want an alias, I want to extend git-push.
> 
> According to the man page, "git push"
> 
> "Works like git push <remote>, where <remote> is the current branch's remote
>  (or origin, if no remote is configured for the current branch)."
> 
> What I'm advocating is that "git push <branch>" would be described with:
> 
> "Works like git push <remote> <branch>, where <remote> is the <branch>'s remote
>  (or origin, if no remote is configured for <branch>)."

Now, if I have a remote foo and a branch foo, what is

git push foo

supposed to do?

Michael
