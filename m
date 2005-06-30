From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Thu, 30 Jun 2005 17:44:53 +0200
Message-ID: <20050630154453.GA26808@pc117b.liacs.nl>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 17:39:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do17b-0001eW-In
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 17:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVF3Ppz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 11:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVF3Ppz
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 11:45:55 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:54992 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S262904AbVF3Ppl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 11:45:41 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5UFirHY000956;
	Thu, 30 Jun 2005 17:44:58 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id C11EA6FEA; Thu, 30 Jun 2005 17:44:53 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050630152125.GO10850@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2005 at 05:21:25PM +0200, Matthias Urlichs wrote:
> Sven Verdoolaege:
> > Could you try to make the resulting repository compatible
> > with a repository generated with the old cvs2git ?
> > 
> I believe I did... at least it worked that way two days ago. ;-)
> 
> > This is the original version:
> 
> Which repository is that?
> 

That was a private repository, but I tried it on another one
and I see that each commit message has an extra empty line
when compared to both an earlier cvs2git conversion and
"cvs log".
Presumably you have an extraneous "\n" somewhere.

-d :pserver:anonymous@exp-prolog.cs.kuleuven.ac.be:/cvs/dtse/ Polylib 

sverdool@pc117b:/local/kul/Polylib> cvs log typemap  |tail -n 15
make Polyhedron subclass of Domain
----------------------------
revision 1.2
date: 2001/11/16 16:01:58;  author: sven;  state: Exp;  lines: +15 -1
take array when matrix is needed
----------------------------
revision 1.1
date: 2001/11/06 15:19:44;  author: sven;  state: Exp;
branches:  1.1.1;
Initial revision
----------------------------
revision 1.1.1.1
date: 2001/11/06 15:19:44;  author: sven;  state: Exp;  lines: +0 -0

=============================================================================

sverdool@pc117b:/local/git/Polylib> cg-log typemap | tail -n 26
commit b53b0121ac62e9fa9cceb2c483e121d6ba1e24ed
tree 8d3d8125b8642a21cb9a5efb4e308f91ede06d56
parent 74d88525870de6c5648580a90920e85f294cae8c
author sven <sven> Mon, 14 Jan 2002 12:48:11 +0000
committer sven <sven> Mon, 14 Jan 2002 12:48:11 +0000

    make Polyhedron subclass of Domain
    

commit df6e38c6efe4f161ee35d60728813ddc0f1cb9cf
tree 43eef31ade1f7a88256e6dff9e66c2e7ca3201db
parent e38797be1f09c649600e681c8c7dc322e2db504d
author sven <sven> Fri, 16 Nov 2001 16:01:58 +0000
committer sven <sven> Fri, 16 Nov 2001 16:01:58 +0000

    take array when matrix is needed
    

commit 4c91382f379478f2ef8b9d875e7c81bddcb3aa57
tree e0ed0e7b11f9fc0341cdddaa95a8872fe5b01a5c
author sven <sven> Tue, 06 Nov 2001 15:19:44 +0000
committer sven <sven> Tue, 06 Nov 2001 15:19:44 +0000

    Initial revision
    

sverdool@pc117b:/local/git/Polylib> 

skimo
