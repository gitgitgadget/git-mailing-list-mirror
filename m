From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix rebase -p --onto
Date: Fri, 17 Jul 2009 10:47:32 +0200
Message-ID: <4A603AA4.7020800@viscovery.net>
References: <20090716230031.GM7503@vinegar-pot.mit.edu> <4A601C59.8040108@viscovery.net> <7vk52767el.fsf@alter.siamese.dyndns.org> <4A6038E8.1090402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Greg Price <price@ksplice.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 10:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRj6T-0000PL-Ij
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 10:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934241AbZGQIrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 04:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934203AbZGQIrf
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 04:47:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21411 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934181AbZGQIre (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 04:47:34 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MRj6K-0003IW-U9; Fri, 17 Jul 2009 10:47:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AD7476D9; Fri, 17 Jul 2009 10:47:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A6038E8.1090402@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123452>

Johannes Sixt schrieb:
> I have used rebase -i -p in the past to rewrite history that involves
> merges of topic branches like this:
> 
>   ---------Y--M--M--F     <-- master
>              /  /
>   ----a--a--a  /
>               /
>   --b--b--b--b
> 
> where F is a fixup that I want to insert between Y and M, and I thought
> rebase -i -p was intended for this use-case.
> 
> With this in mind, I do not see why should we distinguish the cases. I
> would even go so far to say that this is OK:
> 
>   X---a---o---o---M            X---a
>        \         /    ===>          \
>         x---x---x                    x---x---x
>                                               \
>   Y                            Y---a'--o'--o'--M'

because it is a user error: wrong tool for the task. The right tool would
perhaps be git-sequencer.

-- Hannes
(I hit the send button too early by accident, sorry for the excessive
quoting in the previous mail.)
