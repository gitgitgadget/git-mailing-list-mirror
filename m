From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Unable to coax hooks into working
Date: Mon, 26 Apr 2010 14:55:17 +0200
Message-ID: <4BD58D35.1010307@drmicha.warpmail.net>
References: <4C764DDD-420E-40C6-9848-96E2197BE70D@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremiah Foster <jeremiah.foster@pelagicore.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 14:55:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6NqS-000257-Jc
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 14:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0DZMzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 08:55:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35218 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752275Ab0DZMzU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 08:55:20 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A03E9EE034;
	Mon, 26 Apr 2010 08:55:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 26 Apr 2010 08:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=rra2k4yCuiMVa/PdHqFb+iayxJM=; b=ZjLoP7prHYO3D8mMZNSF/AYHPlkojrPBNkwaM19SET6fiJMhWN9cpLJtTeKaFqxaAM6+Bc0ydceh/VCKWS3ubKK60/sjN2ShU1TZl/OdjDpjiHCu08ENLW+sl0Ri5u6cHJ3oQCyD484QPP0VmUwiKuQGEfXf4tQ6tmX2fOSrLIM=
X-Sasl-enc: xPzpy5Ue3HLyeBrdFJzrCsjZIMtGf9YB4ZvMDHDfD6oe 1272286519
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 19C852C00C;
	Mon, 26 Apr 2010 08:55:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <4C764DDD-420E-40C6-9848-96E2197BE70D@pelagicore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145816>

Jeremiah Foster venit, vidit, dixit 26.04.2010 14:32:
> Hello,
> 
> 	After reading this page: http://book.git-scm.com/5_git_hooks.html on git hooks and doing a test implementation, I cannot seem to coax my git hooks into working.
> 
> 	My understanding is that the hook is in the right location, in the git repository on the remote server, when doing a hook based on a post-commit update. I have down chown and chmod, the code executes, it just doesn't execute when I update the git repo and push. I have also tested this on the local machine with a different hook for the client also without success. 
> 
> 	We're using debian testing and git 1.7.0.2 with the http-smart backend.
> 
> 	What should I do to get hooks working?

Use the right hook.

Unsurprisingly, the post-commit hook is executed after a commit. That
should give you an indication that the hook should be in the repo where
you commit. Reading the page you linked to confirms this guess. I
refrain from comments related to the "smart backend" ;)

Michael
