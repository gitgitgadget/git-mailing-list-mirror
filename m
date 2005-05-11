From: Rik van Riel <riel@redhat.com>
Subject: Re: Core and Not-So Core
Date: Tue, 10 May 2005 21:59:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0505102158140.17216@chimarrao.boston.redhat.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com> 
 <1115739511.16187.432.camel@hades.cambridge.redhat.com> 
 <2cfc4032050510092238259b63@mail.gmail.com>  <1115744609.16187.455.camel@hades.cambridge.redhat.com>
  <2cfc403205051010151304d88a@mail.gmail.com> <2cfc4032050510101553d391b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 11 03:52:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVgOQ-0007y8-OC
	for gcvg-git@gmane.org; Wed, 11 May 2005 03:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVEKB71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 21:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVEKB71
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 21:59:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31691 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261877AbVEKB7X (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 21:59:23 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4B1xNXi008959
	for <git@vger.kernel.org>; Tue, 10 May 2005 21:59:23 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4B1xNO24692
	for <git@vger.kernel.org>; Tue, 10 May 2005 21:59:23 -0400
Received: from chimarrao.boston.redhat.com (chimarrao.boston.redhat.com [172.16.80.75])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j4B1xMBA009005
	for <git@vger.kernel.org>; Tue, 10 May 2005 21:59:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by chimarrao.boston.redhat.com (8.13.1/8.12.10) with ESMTP id j4B1xMam018840
	for <git@vger.kernel.org>; Tue, 10 May 2005 21:59:22 -0400
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc4032050510101553d391b2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 11 May 2005, Jon Seymour wrote:

> I did consider wrapping it - I really did. But after thinking about it 
> for a couple of weeks I eventually came to the conclusion it would be a 
> sub-optimal solution.

> So, if I want a stable foundation to build my stuff on, basing it on
> the output of the C tools would be a huge mistake.

Can Java use a library that's implemented in C, like Python
and Perl can?  If that is the case, the C implementation of
git simply needs the ability to be called as a library and
you can implement Java bindings for it.

That should also make it easier to create front-ends in
other languages...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
