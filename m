From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Improved hint on how to set identity
Date: Tue, 14 Aug 2007 07:54:06 +0200
Message-ID: <3ED86523-8FEA-4141-BA8A-14FAFD7CD93E@zib.de>
References: <1187042750257-git-send-email-prohaska@zib.de> <7vbqdbf1m2.fsf@assigned-by-dhcp.cox.net> <06A460CB-BF06-4D9D-9219-4D4EC656EF9B@zib.de> <7vps1qellx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 07:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKpLi-0005Ns-VV
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 07:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S943580AbXHNFxm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 01:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S943570AbXHNFxk
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 01:53:40 -0400
Received: from mailer.zib.de ([130.73.108.11]:46242 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938115AbXHNFxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 01:53:35 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7E5rLsj008252;
	Tue, 14 Aug 2007 07:53:21 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db19c78.pool.einsundeins.de [77.177.156.120])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7E5rKQq018924
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 14 Aug 2007 07:53:20 +0200 (MEST)
In-Reply-To: <7vps1qellx.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55810>


On Aug 14, 2007, at 7:22 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> maybe... but my feeling is that the majority of people has only
>> a single identity. Having multiple identities is, in my opinion,
>> advanced usage, and should be mentioned after the common case.
>
> My point was that there is nothing that backs up that your
> feeling of the majority is correct.  I personally do not have
> much preference either way and I certainly do not claim that I
> have better feel of what the majority wants than you do.  I just
> want to see something more concrete than "I think majority wants
> this" to change what has been there for some time.

I see your point. Yet I do not understand, why people might want
to have _no_ default identity. I think everyone should have a
default identity. That is what my patch does: tell the user to
setup a default account identity first. Per repository identities
can be set up later.

	Steffen
