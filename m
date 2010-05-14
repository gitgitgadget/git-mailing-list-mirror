From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] rev-parse: deprecate use as an option sifter
Date: Fri, 14 May 2010 20:52:57 +0200
Message-ID: <4BED9C09.8010801@drmicha.warpmail.net>
References: <20100505033536.GB8779@coredump.intra.peff.net>	<725860e3bfc692c7241695ef5f554ff73f277b15.1273760226.git.git@drmicha.warpmail.net> <m3y6fmcx0n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 20:53:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD00J-0007w1-SA
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 20:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758866Ab0ENSwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 14:52:54 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57124 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757882Ab0ENSwx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 14:52:53 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7AE9AF78F3;
	Fri, 14 May 2010 14:52:53 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 May 2010 14:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=E7X4SoIFRxia7Z1jHd7HHt7jj98=; b=i1+dhjvm9yXqZZj3nuXDZUsIHYDiweEbmJGbDwdJGRM/RF6cqpHCxpsTlvq5RX6NvjbLQnTuWtlumBDq5q2dhRmfqMf2DUqZWrxKDPdHKuMVeYa8X8LjSa3AegGyT7E05XxUNTIc6L7+GyEhztb6Om0oXgUoTXijQEDotzr82UM=
X-Sasl-enc: s2GOp83gD86W+qs6w/ZAfWTPcJAuZ+MRrVULOQvaWW89 1273863173
Received: from localhost.localdomain (p5485982A.dip0.t-ipconnect.de [84.133.152.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6B0784AA1F5;
	Fri, 14 May 2010 14:52:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <m3y6fmcx0n.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147111>

Jakub Narebski venit, vidit, dixit 14.05.2010 17:41:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>  NAME
>>  ----
>> -git-rev-parse - Pick out and massage parameters
>> +git-rev-parse - Parse symbolic names into object names
> 
> What about "git rev-parse --parseopt"?  Isn't it massaging parameters?
> 

Sure it is. But if you read the part of the patch that you cut out (i.e.
the comment and relevant diff) you see that the massaging part is the
deprecated part of it. That's why I suggest not mentioning it at the
most prominent place. (I don't suggest removing that functionality.)

Michael
