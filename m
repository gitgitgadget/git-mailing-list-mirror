From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/6] Merge David's SVN exporter into git.git
Date: Fri, 04 Jun 2010 15:31:17 +0200
Message-ID: <4C090025.6010905@drmicha.warpmail.net>
References: <1275657988-29765-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:31:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKWzy-0001By-6E
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab0FDNbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:31:41 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:36946 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755722Ab0FDNbl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 09:31:41 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 39558F88EE;
	Fri,  4 Jun 2010 09:31:40 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 04 Jun 2010 09:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ts/rjVDhwCnWQxLCaXtiM+P0cnk=; b=E8B+OUxSzCJo68sI/lo8F1M+hnJuK6tdOAJxa8cTn/6Gku5bONy3OV0s72x7BiwVsYq0Fpp7s7r4x9S+D1UAeFr7lxSqxfhE9J45qZ04AaVLetnJ6Z7LeoTzIFRq1s8eEvo3fxVPbQChPYJOH6T3nf8DrFtGniddnJZctcB+9xE=
X-Sasl-enc: SziFR50wjjqiqNXzVw1RrGYQbCnnOsP/K8LpwSWOdU+w 1275658299
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 090344A50D1;
	Fri,  4 Jun 2010 09:31:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <1275657988-29765-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148408>

Ramkumar Ramachandra venit, vidit, dixit 04.06.2010 15:26:
> Hi,
> 
> This is another attempt to merge David's SVN exporter into
> git.git. What changed since last time: David implemented incremental
> dump support, and I fixed certain things for the merge, as suggested
> by Jonathan Nieder. Preparing patches for the list eats up a lot of my
> time, and if this batch is more-or-less okay, I'd like it to be merged
> atleast into `pu`: we can squash in minor fixes later. The exporter is
> functionally complete and validated against ~940k revisions of the ASF
> repository.
> 
> You can see the complete revision history in my `git-merge` branch of
> my fork of svn-dump-fast-export [1].
> 
> The issue of authorship has already been discussed, but what exactly I
> should do isn't very clear to me- in my opinion the author of all six
> patches should be hand-edited to:
> David Barr <david.barr@gmail.com>

Well, in that case you should rewrite the patches to have David in the
author field (e.g. rebase -i and commit --amend --author=...). Git
format-patch/send-email will insert an additional From header in the
patch e-mail then. (Sorry if that was clear to you already. I see you
have a different author in 2/6.)

Michael
