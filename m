From: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
Subject: Re: svn to git with non-standard layout
Date: Wed, 23 Nov 2011 21:52:20 +0100
Message-ID: <4ECD5D04.6090100@itwm.fraunhofer.de>
References: <2d5f33eb-c1dc-491a-a8ed-e8ceaaf2e2b1@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 21:52:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTJnz-0007Xp-Lm
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 21:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab1KWUw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 15:52:27 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60988 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752819Ab1KWUw0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 15:52:26 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F096121DA1
	for <git@vger.kernel.org>; Wed, 23 Nov 2011 15:52:25 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 23 Nov 2011 15:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=aVxaquCy4Kir/Q3ev0JGME
	hNh1Q=; b=JCGM04wrT0CdB+sxX0Z7Z3XizUTYa7BSIXdoI/lz9ntlO2LRHzE7Rl
	iX0rR93Ykeg03o9041+YaaF37J0D3GOjqoXTaa0tmKGB6JXW/6UzV99FKnyR8a9I
	S923pWA1hW5QMHy8i3COowfjqhAfLPedvVfaylxRd0L/copr0Scc8=
X-Sasl-enc: nX2azLX9xcjBQcb0Mj4QdRGhEse3tEyF3noQ284seb5G 1322081545
Received: from [192.168.178.29] (95-89-141-39-dynip.superkabel.de [95.89.141.39])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7E9E58E00E1;
	Wed, 23 Nov 2011 15:52:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20111031 Thunderbird/7.0.1
In-Reply-To: <2d5f33eb-c1dc-491a-a8ed-e8ceaaf2e2b1@mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185874>

On 11/23/2011 09:22 PM, Stephen Bash wrote:
> ----- Original Message -----
>> From: "Bernd Schubert"<bernd.schubert@itwm.fraunhofer.de>
>> To: git@vger.kernel.org
>> Sent: Wednesday, November 23, 2011 2:23:34 PM
>> Subject: svn to git with non-standard layout
>>
>> So we have something like this:
>>
>> svn-root ->  main-project
>>               /       |    \
>>              /        |     \
>>             proj1    proj2   proj{n}
>>            /    \     /   \    /    \
>>           /      \   /     \  trunk  tags
>>          /       \ trunk   tags
>>          trunk   tags
>>                  /   \
>>                 tag1 tag{2...n}
>
> Just for clarification: are there files and/or directories in main-project that are not sub-projects?

Yes that as well, sorry, forgot to tell about this. If those should be 
troublesome, we might simply ignore them, as those are not that 
important to have a full history, though.


Thanks,
Bernd
