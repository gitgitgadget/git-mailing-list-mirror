From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git config -> "fatal: bad config file"
Date: Fri, 14 Aug 2009 16:18:52 +0200
Message-ID: <4A85724C.5060406@drmicha.warpmail.net>
References: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 16:19:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbxck-0000bC-UH
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 16:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878AbZHNOTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 10:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756873AbZHNOTI
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 10:19:08 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48957 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756864AbZHNOTH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 10:19:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D312451B0A;
	Fri, 14 Aug 2009 10:19:06 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 14 Aug 2009 10:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=G1nUzXeGfJaRY+0TtMGzXN40oKg=; b=pIS3WMbJy1ZtMvbvbTjzlDLJxCsXwDZVAAZ2ibct1g+z8P48YU3eBSiMra0b4HPzz4W15m6vpoaaxct6kCMt9uu9VwiCzM1VQMS5zyLdOO5nvjwenY+SpnGufNq0LEvh5YVDx+XrmPsxmz3VzDQh7c8xxKLDTOu6vl6PvUkPRXA=
X-Sasl-enc: CL78QqVAK3AHe16wisb+ThYQxY3AU8Wj66K9ndtWjUGU 1250259546
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3A7073761;
	Fri, 14 Aug 2009 10:19:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090814 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125926>

David Reitter venit, vidit, dixit 14.08.2009 15:38:
> I made a mistake editing my config file using "git config -e".  This  
> caused git commands to fail.
> 
> Trying to fix the problem, I did
> 
> git config -e
> fatal: bad config file line 7 in .git/config
> 
> I think the refusal to edit a broken config file is not a good idea.   
> It's easy to fix for me of course by editing .git/config directly, but  
> git-config should probably not read the config file at all.
> 
> Thanks for your consideration.
> 

git needs to read the file because the editor could be configured there!
The only option would be to make git config -e continue past that error.

Michael
