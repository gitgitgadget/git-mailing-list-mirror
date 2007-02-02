From: Brendan Cully <brendan@kublai.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 11:28:29 -0800
Message-ID: <20070202192829.GB7963@ventoux.cs.ubc.ca>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	<Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
	<20070202175923.GA6304@xanadu.kublai.com>
	<200702021919.28669.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	mercurial@selenic.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 20:28:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD45M-0000of-3p
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 20:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423145AbXBBT2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 14:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423162AbXBBT2c
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 14:28:32 -0500
Received: from zakopane.cs.ubc.ca ([198.162.52.68]:60280 "EHLO
	mail.quuxuum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423145AbXBBT2b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 14:28:31 -0500
Received: from zakopane.cs.ubc.ca (localhost.localdomain [127.0.0.1])
	by mail.quuxuum.com (Postfix) with ESMTP id 44DA85C407
	for <git@vger.kernel.org>; Fri,  2 Feb 2007 11:28:30 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed; d=kublai.com; h=received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:x-operating-system:user-agent:x-delivery-agent:from:mail-followup-to; q=dns; s=dk; bh=NKQ3VqzQV2D9bKPZp/E7pbQH7lg=; b=lWWXOx8HPyJ2pZ4JUrlk8IWkZ8FOr8dYjtEfhgm6akPexSeeT36eLHLT6buoLnHKXAjrxERSdwZ7lLInZdbJsYNbSI/4dXayprplvghAA4tp+Dqu3496HR27WLVGrgrVw0l9Y8bsDHCcvdW+V3962tNgsCkSZfHTmC2TI0Jstoo=
Received: by zakopane.cs.ubc.ca (tmda-sendmail, from uid 103);
	Fri, 02 Feb 2007 11:28:29 -0800 (PST)
Received: from ventoux.cs.ubc.ca (ventoux.cs.ubc.ca [198.162.52.72])
	by mail.quuxuum.com (Postfix) with ESMTP id 8FB7A5C1EC;
	Fri,  2 Feb 2007 11:28:29 -0800 (PST)
Received: by ventoux.cs.ubc.ca (Postfix, from userid 3121)
	id 5C2C9340B5; Fri,  2 Feb 2007 11:28:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200702021919.28669.jnareb@gmail.com>
X-Operating-System: Linux 2.6.17-10-generic i686
User-Agent: Mutt/1.5.13 (2006-11-21)
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
Mail-Followup-To: jnareb@gmail.com, torvalds@linux-foundation.org,
	mercurial@selenic.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38528>

On Friday, 02 February 2007 at 19:19, Jakub Narebski wrote:
> Brendan Cully wrote:
> > On Friday, 02 February 2007 at 08:42, Linus Torvalds wrote:
> >> 
> >> The mistake seems to be to think that tags get "versioned", and are part 
> >> of the tree history. That's insane. It means that you can never have a tag 
> >> to a newer tree than the one you are on.
> > 
> > The tags you use can simply be those from the tip of the repository,
> > regardless of which revision you've currently checked out.
> 
> _Can_ be or _are_ (in Mercurial)? Besides, there can be more than one

are. The meaning of tags depends on the repository, not the "index".

> tip of repository (branch are tips of history), and making set of tags
> dependent on which branch you are on is not a good idea either.

agreed.
