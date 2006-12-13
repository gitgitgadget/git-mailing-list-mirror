X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: GIT - releases workflow
Date: Wed, 13 Dec 2006 14:13:47 +0100
Message-ID: <457FFC8B.5010501@op5.se>
References: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com>	 <Pine.LNX.4.63.0612122353320.2807@wbgn013.biozentrum.uni-wuerzburg.de>	 <1166001019.19098.4.camel@localhost.localdomain>	 <89b129c60612130434q18c69c7bxd96b7db0c423d8ea@mail.gmail.com> <89b129c60612130439m452b315x2278456396a248a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 13:14:01 +0000 (UTC)
Cc: Matthias Kestenholz <lists@spinlock.ch>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <89b129c60612130439m452b315x2278456396a248a5@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34218>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuTvl-00016Q-4K for gcvg-git@gmane.org; Wed, 13 Dec
 2006 14:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964947AbWLMNNu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 08:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWLMNNu
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 08:13:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44505 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S964947AbWLMNNt (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 08:13:49 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id CE8496BCBF; Wed, 13 Dec 2006 14:13:47 +0100 (CET)
To: Sean Kelley <sean.v.kelley@gmail.com>
Sender: git-owner@vger.kernel.org

Sean Kelley wrote:
> Hi,
> 
> On 12/13/06, Sean Kelley <sean.v.kelley@gmail.com> wrote:
>> Hi,
>>
>> On 12/13/06, Matthias Kestenholz <lists@spinlock.ch> wrote:
>> >
>> How do I push that tag that I created to the maint/v0.1 branch on the
>> remote repository?
> 
> Never mind, I answered my own question.  Sorry for asking without
> doing my research first.
> 
>   git push --tags origin
> 

Sort of, but not quite. This will push *all* your tags to wherever 
origin points to. If you, like me, use un-annotated tags to remember a 
particular snapshot you will then push a number of tags named "foo", 
"fnurg", "sdf" and "werwer" to the mothership repo.

	git push origin v0.1

works marvellously though.

Btw, this behaviour of mine, coupled with the company policy of only 
allowing annotated tags signed by the project maintainer as 
release-tags, lead to the creation of the update-hook I believe is still 
shipped as the default update-hook template with the git repo. It 
disallows un-annotated tags completely and should be used on the 
mothership repo.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
