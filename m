From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: 500Mb file erroneously commited
Date: Mon, 06 Jun 2011 09:51:10 +0200
Message-ID: <4DEC86EE.1030101@drmicha.warpmail.net>
References: <loom.20110606T093627-918@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bartolomeo Nicolotti <bnicolotti@siapcn.it>
X-From: git-owner@vger.kernel.org Mon Jun 06 09:51:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTUaq-00032l-9f
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 09:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865Ab1FFHvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 03:51:15 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37502 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756774Ab1FFHvM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 03:51:12 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BE7EA20297;
	Mon,  6 Jun 2011 03:51:11 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 06 Jun 2011 03:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mMDnvumCSm+G9dgyV51EXw7tXvs=; b=GURPqtMECBT3Mi961gVt+HlQax37nLF6gOFFl5feFIMuJfEQms45euHYHnQNiXTzm4vDrk+CtnW84MfG5AZDpLv7V0vYugmwl2jU6vGJ+8REBYWctioe3D4oG3Uh7rjtuMUMLE5X+FU/4jKBKjP4Efdvj7szxGb5bOc3FADG4VM=
X-Sasl-enc: 3mvmM+M8vSz1pVVPSmB2WU8QVpX6pltdc7OmzBl7U5MR 1307346671
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3738344026D;
	Mon,  6 Jun 2011 03:51:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <loom.20110606T093627-918@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175102>

Bartolomeo Nicolotti venit, vidit, dixit 06.06.2011 09:43:
> Hello,
> 
> we're using CVS to store some sources, but for some big projects I'm considering
> to use git. Last week it has happened that one collegue erroneously commited one
> big file, 500Mb the file only. To avoid to have this file in the repository
> we've deleted the history file in the CVS repository, the one with ,v, this has
> been easy as each file has its own history. Would it be possible to do the same
> with git, or there's no possibility to delete a 500Mb file erroneously commited? 

Due to the way git (or hg or...) works, you would have to rewrite the
history in order to remove a file from a repo completely. The first
example in the git-filter-branch man page describes how to do this.

Michael
