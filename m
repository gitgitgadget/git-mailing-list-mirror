From: Travis P <git@castle.fastmail.fm>
Subject: Re: How to handle terminal detection in a daemon calling git?
Date: Thu, 31 May 2012 08:43:37 -0500
Message-ID: <1338471817.15272.140661083202725.1D34BB07@webmail.messagingengine.com>
References: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
 <20120531012908.GD5488@sigill.intra.peff.net>
 <7vaa0o98e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 15:43:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa5fD-0002XC-2D
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758032Ab2EaNni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 09:43:38 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54539 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757496Ab2EaNnh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 09:43:37 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5CE9220E11;
	Thu, 31 May 2012 09:43:37 -0400 (EDT)
Received: from web5.nyi.mail.srv.osa ([10.202.2.215])
  by compute6.internal (MEProxy); Thu, 31 May 2012 09:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:from:to:cc:mime-version
	:content-transfer-encoding:content-type:in-reply-to:references
	:subject:date; s=smtpout; bh=G2mpu6mMYF52352qWcbrUlzF6fI=; b=Uum
	WGLgFAipv6lxNAwqjn+DFrI+aNwSXzsrXqwz4sd+I+TTJulMCMluWGTTNTN82Gx8
	8MWVE+uHWGFqDqld/BXY3eFYjdKK5WjuP/lmWS/iAjLKwYMg0y0k53U0MjhDhs/i
	uNOsNUbQFuhP/nfQevmNxzLtxDUJlz/Hu+9lTkQY=
Received: by web5.nyi.mail.srv.osa (Postfix, from userid 99)
	id 3E43B4C0F7F; Thu, 31 May 2012 09:43:37 -0400 (EDT)
X-Sasl-Enc: LXBuqTWUSVdUXtvY38mkDY152uOtkz1sAfwyrsQMP7J4 1338471817
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <7vaa0o98e5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198898>


Oops, I meant to mention that I'm using git 1.7.6 on RedHat.
Someone else did the git installation.
