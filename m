From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch + git-applymbox small issue
Date: Wed, 17 Aug 2005 12:26:15 -0700
Message-ID: <7vll30wejs.fsf@assigned-by-dhcp.cox.net>
References: <20050817175452.84541.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 21:28:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5TYK-0002pq-IN
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 21:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVHQT0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 15:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVHQT0R
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 15:26:17 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54707 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751215AbVHQT0R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 15:26:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817192614.OUEU19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 15:26:14 -0400
To: Marco Costalba <mcostalba@yahoo.it>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <20050817175452.84541.qmail@web26306.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Wed, 17 Aug 2005 10:54:51 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba <mcostalba@yahoo.it> writes:

>>revision::
>>	A particular state of files and directories which was stored in
>>	the object database. It is referenced by a commit object.
>>
>>commit object::
>>	An object which contains the information about a particular
>>	revision, such as parents, committer, author, date and the
>>	tree object which corresponds to the top directory of the
>>	stored revision.
> So 'revision' is the struct and 'commit object' the pointer ;-)

It would be more like "revision" is a concept represented (not
"referenced") by a commit object.

>>repository::
>>	A collection of refs together with an object database containing
>>	all objects, which are reachable from the refs. A repository can
>>	share an object database with other repositories.
>>
>
> In a lot of git documentation, starting from the tutorial, it is used 'git archive' 
> but peraphs 'repository' is more a standard definition for an SCM archive. 
> Just archive peraphs is too generic, also a tarball is an archive :-)

Agreed.  I personally think the word "archive" on this list came
from people who have some degree of tla background.  CVS and SVN
people would have said repository.
