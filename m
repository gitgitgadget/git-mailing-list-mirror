From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: how to combine two clones in a collection
Date: Wed, 11 Jul 2007 01:45:27 +0200
Message-ID: <200707110145.28931.robin.rosenberg.lists@dewire.com>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net> <m3644suki6.fsf@host32.eke.fi> <47015E14-FEA7-45C5-B9CB-C949B87B6494@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kalle Pokki <kalle.pokki@iki.fi>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 01:44:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8PNn-0002Ba-8O
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 01:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373AbXGJXoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 19:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757907AbXGJXoh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 19:44:37 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27177 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757851AbXGJXog (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 19:44:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5D1438026DE;
	Wed, 11 Jul 2007 01:37:32 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19267-08; Wed, 11 Jul 2007 01:37:32 +0200 (CEST)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 09AC580019B;
	Wed, 11 Jul 2007 01:37:32 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <47015E14-FEA7-45C5-B9CB-C949B87B6494@silverinsanity.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52121>

tisdag 10 juli 2007 skrev Brian Gernhardt:
> 
> On Jul 10, 2007, at 3:27 PM, Kalle Pokki wrote:
> 
> > You can also just create two different git repositories and start  
> > making
> > the commits in the master (or any other) branch. Then combine the
> > repositories by fetching
> >
> >         cd repo1
> >         git fetch ../repo2 master:repo2
> >
> > This way the branches don't share anything, do they?
> 
> Yes, that's what I was referring to at the end when I wrote:
> 
> > You could also create the branch in a second repository and pull it  
> > from there into the first (probably simpler),
> 
> But it seemed too simple.  ;-)  And that is exactly how I'd do it...   
> Assuming I thought of it before using write-tree, commit-tree, and  
> update-ref.  (Which is what happened.  I thought of the complicated  
> method and wrote it up before thinking "duh, just use a second repo.")

And the simplest way to create an new indpendent branch:

echo ref: refs/heads/newbranch >.git/HEAD
Then prepare the content and commit like you used to do.

-- robin
