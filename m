From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: multiple-commit cherry-pick?
Date: Thu, 6 Nov 2008 19:29:04 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 04:30:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyI3H-0008MW-41
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 04:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYKGD3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 22:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbYKGD3N
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 22:29:13 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59875 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750806AbYKGD3M (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2008 22:29:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA73T6mB029107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Nov 2008 19:29:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA73T4Mu002004;
	Thu, 6 Nov 2008 19:29:05 -0800
In-Reply-To: <20081106213711.GA4334@blimp.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100284>



On Thu, 6 Nov 2008, Alex Riesen wrote:
> 
> git format-patch --full-index --binary --stdout <range...> | git am -3
> 
> This will not work if you want to pick a list, not a range, of
> commits.

Doesn't "--no-walk" + list commits individually work?

So it _should_ be possible to pick a list of commits too. Although I think 
that git format-patch will reverse the order.

		Linus
