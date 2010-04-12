From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 16:13:15 +0800
Message-ID: <4BC2D61B.7050902@drmicha.warpmail.net>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 10:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Eln-0002dh-QW
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 10:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab0DLINR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 04:13:17 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42977 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752548Ab0DLINR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 04:13:17 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A64A1EA41E;
	Mon, 12 Apr 2010 04:13:16 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 12 Apr 2010 04:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=B/NmUwvtNrKT1LkKw12jyCr755s=; b=K+pazmwiK1SaOckfmI4HQySV9Vl/uWdmzSSEdiA1SGyM2/+zS+JHGgs+L0MPIV6Lk+Y6ffUnurOj+REhuybhMxAoT2uwQgu1Kp1ypAbM6VHNTGcAFafGitrvqFYk93H+06cuQgi1VDI7jAy8vv6qxDWdabCwJeg0JtbfWiACdjk=
X-Sasl-enc: pUr1Zssh7bwZo7pqJA1+o37uS47cW1kGy/X3mDkalfAB 1271059996
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07656446E2;
	Mon, 12 Apr 2010 04:13:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144710>

Stefan Hajnoczi venit, vidit, dixit 10.04.2010 14:54:
> I have default settings for sending email in the global git config.
> However, for one repo different email settings are necessary.  That
> specific SMTP server does not want authentication, therefore smtpuser
> should be unset.
> 
> The issue is that global smtpuser is set for the default SMTP server
> and unsetting local smtpuser results in the global smtpuser being
> inherited.  What I'd like is smtpuser to be unset for this particular
> repo.
> 
> Is there any way to "unset override" options locally?  If not, is this
> something that could and should be implemented?
> 
> Stefan

have you tried setting it to an empty value?

Michael
