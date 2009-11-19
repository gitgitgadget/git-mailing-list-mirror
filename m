From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Thu, 19 Nov 2009 13:27:33 -0800
Message-ID: <7vocmy9pdm.fsf@alter.siamese.dyndns.org>
References: <005a01ca684e$71a1d710$54e58530$@com>
 <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com>
 <m37htnd3kb.fsf@localhost.localdomain>
 <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com>
 <009401ca68bc$7e4b12b0$7ae13810$@com> <20091119074226.GA23304@atjola.homenet>
 <00d401ca6954$a29fa020$e7dee060$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <B.Steinbrink@gmx.de>,
	"'Jason Sewall'" <jasonsewall@gmail.com>,
	"'Jakub Narebski'" <jnareb@gmail.com>,
	'Jan =?utf-8?Q?Kr=C3=BCger'?= <jk@jk.gs>, <torvalds@osdl.org>
To: "George Dennie" <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 22:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBEXo-0004NG-8y
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 22:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbZKSV1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 16:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbZKSV1s
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 16:27:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbZKSV1r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 16:27:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9EE3E9FD14;
	Thu, 19 Nov 2009 16:27:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9x48v4RL1YbhildkTcu8fbSWQM0=; b=juJmj0
	AXfbnpbr10OX5tieFjhvtSTZN33BSb9ADcW+U856d1C2d7IKyGIfjrbLLLcyAb/l
	2hMdKV0BRo3H554j8XLFuYonfSYy8aQlruZwtzSO+TRLEtGP7JQ+NGS65/Zs7yzZ
	+CmyQDmN5dRDrc1vyJ9qSrdm1tA7osRTr48sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WfJdcIlD2J/EKjtofbl5lWXUIxm3vhF/
	fnEV1fmBzCybIuiyYVa6bsPVRg+gdnxKDThdsMW8WlXIC5SexhYV1Bhm5CcU69sU
	Gs8yOTOdC5YlQiWzDTtF0vXs2q3rcaROl3P/vuNKRHeHws/2WS7rXA8X1TP7ePWf
	h9ky6vMLH/c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C5B49FD0F;
	Thu, 19 Nov 2009 16:27:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9D8EF9FD0A; Thu, 19 Nov 2009
 16:27:35 -0500 (EST)
In-Reply-To: <00d401ca6954$a29fa020$e7dee060$@com> (George Dennie's message
 of "Thu\, 19 Nov 2009 15\:12\:35 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 608A0EF4-D552-11DE-8338-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133258>

"George Dennie" <gdennie@pospeople.com> writes:

> REPOSITORIES
> 	Collection of Commits

Ok.

> 	Collection of Branches
> 		-- collection of commits without children

Wrong.

> 		-- as a result each commits either augments
> 		-- and existing branch or creates a new one

Ok.

> 	Master Branch
> 		-- typically the publishable development history

Not necessarily.

> INDEX
> 	Collections of Parent/Merge Commits
> 		-- the commit will use all these as its parent

Wrong.

> 	Staged Commit 
> 		-- these changes are shown relative to the working tree

A new word for me.  I doubt we need to have such a concept.

> 	Default Branch
> 		-- the history the staged commit is suppose to augment

We typically call it "the current branch".  It is "the branch whose tip
will advance by one commit when you make a new commit" and determined by
HEAD.

> 	Collection of Stashes
> 		-- these are not copies of the working tree since they
> 		-- only contain "versioned" files/folders and so is not
> 		-- a backup

I think it is better to say what these _are_, instead of saying what they
are not.  These are not yoghurt cups, these are nor bicycles, these are
not knitting needles.  Listing what they are not does not give you more
information.

> WORKING_TREE
> 	Collection of Files and Folders

Ok.

> As far as I can tell, the working tree is not suppose to be stateful, but it
> seems the commands treat it as such.

I am not sure what you are trying to say by "stateful" here.  A work tree
has files and directories, and if you edit one of the files of course it
changes its state.

----------------------------------------------------------------

A branch is just a pointer to one commit (or nothingness, if it is unborn,
but that is such a special case you do not have to worry about yet until
you understand git more).

The commit can have many children, but you do not care about them when
looking at the branch, as there is no "parent-to-children" pointer.

The pointer that represents a branch moves to another commit by
different operations.

 - If you make a new commit while on the branch, it points to the new
   commit.  This is the most typical, and is done by many every-day
   commands, such as "commit", "am", "merge", "cherry-pick", "revert".

   Typically the new commit B is a direct child of the commit the branch
   used to point at A, and B has A as its first parent.

 - There are commands that let you violate the above, i.e. you can change
   what commit the branch pointer points at, and the new commit A does not
   have to be a direct child of the commit currently pointed by the
   branch.  "reset" and "rebase" are examples of such commands and are to
   rewrite the history.

There is the "current branch" that you are on.  It is recorded in HEAD
(cat .git/HEAD to see it).  When you create a new commit, the tip of the
branch HEAD points at is updated to point at the new commit.  Since the
new commit is made a direct child of the current commit, this will appear
to the users as "advancing the branch".

The state (contents of files and symlinks together with where they are in
the tree) to be commited next is recorded in the index.  "git add" and
friends are used to update this state in the index, and "git diff" with
various options allow you to view the difference between this state and
work tree or arbitrary commit.
