From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] Different views on a repository
Date: Thu, 25 Feb 2010 10:01:43 +0100
Message-ID: <4B863C77.8040304@drmicha.warpmail.net>
References: <cover.1267029680.git.agruen@suse.de>	<f409d0cde7939a833708ed92f86605dbbdd64a49.1267029680.git.agruen@suse.de> <92fea2335b73265b04d64fcc217055e1170f5e16.1267029680.git.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Feb 25 10:04:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkZe8-0002gi-GU
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 10:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab0BYJEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 04:04:11 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39624 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752233Ab0BYJEI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2010 04:04:08 -0500
Received: from compute1.internal (compute1 [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2DE2EE27B6;
	Thu, 25 Feb 2010 04:04:05 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 25 Feb 2010 04:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=C8MlJszXTojhJ5I/07jd7fykhJM=; b=dFLgu/867mXPeMMVtjPb7xVN4BBYvccIrU6TIf7EJF6J5JV/GPDWS6eL01RCmy3fwwu+FSpy7RCIlAsJZsI7siVsdzgTCILIYeLFDEHsI14te7ow9rnGm7Q/4rQ8GkejB2KPZsQhpDNFsnfi2CwVTU3WC5tA0FrrZCndHBuIw9A=
X-Sasl-enc: Kh7J/Fm0gOkOZRVfpr8kxJhmvA6OP3Qmg2EYd55ww1Em 1267088644
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 97334D6E8;
	Thu, 25 Feb 2010 04:04:04 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100222 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <92fea2335b73265b04d64fcc217055e1170f5e16.1267029680.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141035>

Andreas Gruenbacher venit, vidit, dixit 24.02.2010 16:57:
> Add --view options in upload-pack and receive-pack so that a repository
> on the server side can be made to look like several independent
> repositories on the client side.
> 
> This is implemented by transforming ref names: for example, with
> --view=one/, refs/heads/one/master on the server will look like
> refs/heads/master to the client, refs/tags/one/v1 will look like
> refs/tags/v1, etc.
> 
> This allows to transparently share repositories on the server which
> have a lot of objects in common without complicating things for the
> client, and without breaking garbage collection.

Just from this description, I can't see why the same can't be done with
appropriate refspecs. (A helper for doing that would be more welcome, of
course.)

Maybe a few tests and documentation (i.e. examples, not just the option
description) would clear this up?

Michael
