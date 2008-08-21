From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Thu, 21 Aug 2008 19:49:16 +0200
Message-ID: <20080821174915.GC5119@blimp.local>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821174118.GB5119@blimp.local>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:53:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWEIh-0001iM-Es
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 19:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbYHURtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 13:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbYHURtT
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 13:49:19 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:10478 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbYHURtS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 13:49:18 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (mrclete mo6) (RZmta 16.47)
	with ESMTP id z0380ck7LGqIEa ; Thu, 21 Aug 2008 19:49:16 +0200 (MEST)
	(envelope-from: <fork0@users.sourceforge.net>)
Received: from blimp (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 300A5277AE;
	Thu, 21 Aug 2008 19:49:16 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 13AC436D18; Thu, 21 Aug 2008 19:49:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080821174118.GB5119@blimp.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93182>

Alex Riesen, Thu, Aug 21, 2008 19:41:18 +0200:
> Michael J Gruber, Thu, Aug 21, 2008 11:19:41 +0200:
> > This allows the use of author abbreviations when specifying commit
> > authors via the --author option to git commit. "--author=$key" is
> > resolved by looking up "user.$key.name" and "user.$key.email" in the
> > config.
> 
> Isn't there existing well-known formats for mail aliases?
> For instance, Mutt uses simple text file:
> 
>     alias nickname1 Author Name <mail@address>
>     alias nickname2 "Author Name 2" <mail2@address>
> 
> I don't know how well-known this is, but is surely more known than
> git's config (and there are aliases in that format already).
> Maybe just reference such files in git's config?
> 

Oh, and you may consider using .mailmap files (look into the Git's
one for example): the user part of mail address is very often a good
alias (and sometimes famous nickname) of a person: junio, tytso,
davem, alan, viro, hpa... You'll have to define some rules for
duplications, of course (first wins seems to be popular).
