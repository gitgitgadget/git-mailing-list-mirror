From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: how to combine two clones in a collection
Date: Tue, 10 Jul 2007 16:00:49 -0400
Message-ID: <47015E14-FEA7-45C5-B9CB-C949B87B6494@silverinsanity.com>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org> <20070710062104.GA22603@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707100950520.3412@woody.linux-foundation.org> <20070710174543.GA16054@piper.oerlikon.madduck.net> <72218C10-EE5E-4CD9-B5DE-DFEC40EBEF27@silverinsanity.com> <m3644suki6.fsf@host32.eke.fi>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kalle Pokki <kalle.pokki@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jul 10 22:00:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8LtJ-000867-6T
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 22:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912AbXGJUAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 16:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754972AbXGJUAw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 16:00:52 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51455 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbXGJUAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 16:00:52 -0400
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id A9B151FFC003;
	Tue, 10 Jul 2007 20:00:51 +0000 (UTC)
In-Reply-To: <m3644suki6.fsf@host32.eke.fi>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52110>


On Jul 10, 2007, at 3:27 PM, Kalle Pokki wrote:

> You can also just create two different git repositories and start  
> making
> the commits in the master (or any other) branch. Then combine the
> repositories by fetching
>
>         cd repo1
>         git fetch ../repo2 master:repo2
>
> This way the branches don't share anything, do they?

Yes, that's what I was referring to at the end when I wrote:

> You could also create the branch in a second repository and pull it  
> from there into the first (probably simpler),

But it seemed too simple.  ;-)  And that is exactly how I'd do it...   
Assuming I thought of it before using write-tree, commit-tree, and  
update-ref.  (Which is what happened.  I thought of the complicated  
method and wrote it up before thinking "duh, just use a second repo.")

~~ Brian
