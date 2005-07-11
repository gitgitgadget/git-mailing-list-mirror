From: Thomas Lord <lord@emf.net>
Subject: Re: arch 2.0 first source available (git related)
Date: Mon, 11 Jul 2005 14:36:56 -0700
Message-ID: <1121117816.16511.5.camel@dev1.seyza.com>
References: <1120867947.5882.2.camel@dev1.seyza.com>
	 <20050709113942.GB26343@pasky.ji.cz>
	 <1120918813.4901.27.camel@dev1.seyza.com>
	 <20050711193944.GA5981@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds63o-0000ie-Uv
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 23:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVGKVmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 17:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVGKVhw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 17:37:52 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:49576 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262811AbVGKVgl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 17:36:41 -0400
Received: (qmail 35746 invoked from network); 11 Jul 2005 21:36:37 -0000
Received: from unknown (HELO adsl-69-236-72-120.dsl.pltn13.pacbell.net) (tom.lord@sbcglobal.net@69.236.72.120 with plain)
  by smtp110.sbc.mail.mud.yahoo.com with SMTP; 11 Jul 2005 21:36:36 -0000
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050711193944.GA5981@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-07-11 at 21:39 +0200, Petr Baudis wrote:
> Dear diary, on Sat, Jul 09, 2005 at 04:20:13PM CEST, I got a letter
> where Thomas Lord <lord@emf.net> told me that...
> > The prereq graph is, indeed, an improvement.  
> ..snip..

> But object retrieval can be potentially as much as linear to the depth
> of the prereq graph, right? 

Potentially but not, by far, in the common case.

Moreover, that depth is an arbitrary parameter which user's can
freely vary -- that's part of the point.


> I don't think any of the benefits you listed
> are worth the complication, and you can still do the reachability
> analysis pretty easily. (And I think it takes the same number of
> roundtrips when downloading from remote server?)
> 

I don't agree that any complication is added.  I know that 
some complications are avoided with this approach.

-t
