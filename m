From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: qgit question: tagged commits not on a branch
Date: Fri, 27 Nov 2009 16:15:06 +0100
Message-ID: <4B0FECFA.9040307@drmicha.warpmail.net>
References: <Xns9CCFDEF02D061ChrisCheneytesconet@80.91.229.13>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 16:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE2YZ-0006Q7-2S
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 16:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZK0PQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 10:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbZK0PQL
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 10:16:11 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43515 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752793AbZK0PQL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 10:16:11 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 79CE5C1A97;
	Fri, 27 Nov 2009 10:16:17 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 27 Nov 2009 10:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=2T8gJpBIhsGJVKDwWdeIEfFdRnA=; b=upOOptZCsynZ0oyU11zLUfsxTqvSyFR6urL1wAzuI4VtnKCxQYYJj4B9wAdSGZPcXgD6PBdztQxLxUpN8ZtmQkg8sL262QApdA/HDRV0fjMtoQ+ih23vPCre58031yyIdWg/8TiyQzRCzCBq5qu+hOMhqVQBruf/dU50bKQPCX0=
X-Sasl-enc: q+HcDIA46nKkFv5tAy+j7yOxCetzCP9qfW3je25om4bf 1259334977
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C78B376F0;
	Fri, 27 Nov 2009 10:16:16 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <Xns9CCFDEF02D061ChrisCheneytesconet@80.91.229.13>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133900>

Chris.Cheney venit, vidit, dixit 26.11.2009 22:54:
> My commit graph has a number of forks (I can't use the word "branches" 
> here) that are referenced only by a tag. Whereas gitk --all displays this 
> graph including those forks, qgit does not display those forks - I don't 
> see a way to make it do so, other than by adding branches to those tagged 
> commits. 
> 
> Have I overlooked something?
> 

qgit --all does it for me. It may not be the newest qgit, though.
I use tags like that to mark a version of a topic branch before
rebasing, so that on old version won't be gc'ed away and the branch name
space is not too crowded. Poor man's topgit, so to say. I guess it's a
common use case.

Michael
