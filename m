From: "Michael J Gruber" <git@drmicha.warpmail.net>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Sun, 01 May 2011 10:30:52 +0200
Message-ID: <1304238652.9638.1446946253@webmail.messagingengine.com>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
 <7vfwp1yqnq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 01 10:31:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGS3Q-0005uw-Vk
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 10:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab1EAIaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 04:30:55 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50185 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752367Ab1EAIaw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2011 04:30:52 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 65B7C21127;
	Sun,  1 May 2011 04:30:52 -0400 (EDT)
Received: from web1.messagingengine.com ([10.202.2.211])
  by compute5.internal (MEProxy); Sun, 01 May 2011 04:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=pGhBN7TQ20gEZjthPpcFGxuLnlA=; b=dCn6WXD4y01UaN+ddRyDNGCoYVDXXHWv+fm8Q8zYoL9+Z9S1N3wSvPewdmcAI29btAJlnT1e5aQL1Hv3kn+uHK/Lg9ZBCuD+AZtxFRSpwG9MU2WSrFI7Br/4FqSdEGFxNC3YoIitUBQkJmyVSwXsQGRLJy1warM+2L+aEOaDksY=
Received: by web1.messagingengine.com (Postfix, from userid 99)
	id 47E453D1CC7; Sun,  1 May 2011 04:30:52 -0400 (EDT)
X-Sasl-Enc: aVfHSOd6OCmdfAuJL8shSMRDYNtdmM4PsCaXwGFfKsfs 1304238652
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <7vfwp1yqnq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172534>

On Fri, 29 Apr 2011 09:21 -0700, "Junio C Hamano" <gitster@pobox.com>
wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > HEAD~n is often used for rebase invocations etc.
> 
> I thought rebase invocations these days use @{u}.
> 

I meant "rebase -i", sorry. And in fact I mostly mean those cases where
I want to "amend" a commit which is not the top most one.

Michael
