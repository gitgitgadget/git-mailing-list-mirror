From: "Daniel Richard G." <skunk@iSKUNK.ORG>
Subject: Re: [PATCH] Building Git on Tru64
Date: Thu, 15 Apr 2010 16:21:43 -0400
Message-ID: <1271362903.31598.1370191799@webmail.messagingengine.com>
References: <1271358589.19032.1370170305@webmail.messagingengine.com><r2n81b0412b1004151229g6fe840a1v23a9d06f72e8d36a@mail.gmail.com><1271360809.25304.1370186353@webmail.messagingengine.com>
 <alpine.LFD.2.00.1004151603290.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Apr 15 22:21:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2VZN-0001lZ-Ji
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 22:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643Ab0DOUVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 16:21:44 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42353 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756458Ab0DOUVo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 16:21:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9B672EAFBE;
	Thu, 15 Apr 2010 16:21:43 -0400 (EDT)
Received: from web7.messagingengine.com ([10.202.2.216])
  by compute1.internal (MEProxy); Thu, 15 Apr 2010 16:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=EXLMGHdGs+kKaW9apOOKZp6utCM=; b=ZX2o6/YcRmtS1/3qPcNn61Zgd2n0olJS+3XfdDBXMGka9VcuJHMsq+GswdAI1J/zrDr6FqjE04fJCUySii7LMa5po70zVE+FiiB8i2n0awASvy3KC7g9hLk+9jE5t9R/s7wtf+7vaqZqTLgF3BfV4A8BnEc0NyP5ro+SMhsZ7cs=
Received: by web7.messagingengine.com (Postfix, from userid 99)
	id 770CA13D293; Thu, 15 Apr 2010 16:21:43 -0400 (EDT)
X-Sasl-Enc: FlYlAXSFIFoQjGW2qCay0XsEvg6wQsB3sG/JnfO7WHRx 1271362903
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <alpine.LFD.2.00.1004151603290.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145021>

On Thu, 2010 Apr 15 16:04-0400, Nicolas Pitre wrote:
> >
> > I agree with the sentiment, but you can't have a macro refer to
> > itself :]
>
> you may undefine and redefine it appropriately instead.

Yes, the macro should have included the cast in the first place.

(I was going to say "you can't assume the value is always going to be -1
casted," but then this is only for Tru64, not for those weird platforms
that #define NULL as something other than (void*)0...)


--Daniel


-- 
NAME = Daniel Richard G.     _\|/_    Remember, skunks
MAIL = skunk@iSKUNK.ORG     (/o|o\) _- don't smell bad---
MAIL+= skunk@alum.MIT.EDU   < (^),>     it's the people who
WWW  = (not there yet!)      /   \      annoy us that do!
