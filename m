From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Clone Parameter
Date: Fri, 19 Jul 2013 12:10:14 -0700
Message-ID: <7v38rawell.fsf@alter.siamese.dyndns.org>
References: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
	<7v4nbqzj7u.fsf@alter.siamese.dyndns.org>
	<101D1917805742BE86814C6E6E51C378@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Allan Acheampong" <allanadjei@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jul 19 21:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0G4N-0007M6-SL
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 21:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab3GSTKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 15:10:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab3GSTKS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 15:10:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C0731A1B;
	Fri, 19 Jul 2013 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3tSljDmGKxQ5CJ8hYtkjulg+36E=; b=JaJDMW
	YX1aywWCJ+zlochz+loBKgwElzVBtfcO3qcbTiaC5W9iqFJNwz34Z7Py9qd/MntF
	49ugqoL2H98/3zntfGVNMAJ6GSN2TnhgmoxK9evZShTEoGomKFZX0oyP/lTAC4x6
	g+oW5SnNXaaEv1Pqt0pHm/LnAT3+scKNgzYt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S78m9CiDDbbs12iYHwxreEMkLV0dc1MB
	DypbI2d89E8e/JY1n/ZkW05B9WNTsCvdYAO/vn6k5li0GJRZFw0eQPnfvwnX2tRc
	QfJfJRjgnOHAGPwksl8yZL8bqjgD0LX/UsCjRwSoZwrSjOHWCQ6qg+pw8x43dNSY
	DziyhAZDCF8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8C3931A1A;
	Fri, 19 Jul 2013 19:10:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C28D31A13;
	Fri, 19 Jul 2013 19:10:16 +0000 (UTC)
In-Reply-To: <101D1917805742BE86814C6E6E51C378@PhilipOakley> (Philip Oakley's
	message of "Fri, 19 Jul 2013 18:19:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8B597A4-F0A6-11E2-9167-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230839>

"Philip Oakley" <philipoakley@iee.org> writes:

>> Allan Acheampong <allanadjei@gmail.com> writes:
>>
>>> ... I'm new to git, but I found it very
>>> confusing to understand the difference between "remote" ,
>>> "remotes". Is it in the cloned repo, or is it in a remote place?
>>> If its local, why doesn't it get shown when I do 'git branch' but
>>> when I do 'git branch -a'.
>
> For the uninitiated, the lack of distinct terminology can cause no end
> of confusion as most explanations presume that you will implicitly
> understand the context, which can't be true for such newbies.

True.

 * You work in a local repository.

 * You interact with repositories other than the local repository.
   Here, "to interact" mean "exchange the history with", either by
   pushing the commits in the local repository to the other one(s),
   or fetching the commits in the other one(s) to the local
   repository.

   These "other repositories" are "remote repositories" from the
   point of view of the local repository.

   Note that you may have two repositories you use for working on
   the same project, one on your desktop and one on your notebook.
   As far as the repository on your notebook is concerned, the
   repository on your desktop, if you interact with it from the
   repository on your notebook, is a "remote repository" (and the
   one on the desktop views the one on the notebook as "remote").

 * Often we call a "remote repository" just a "remote".  Especially
   when we give a convenience short-name to it, like "origin".

 * When you "clone" from a repository to create a "copy" to work in,
   from that new repository's point of view, the original repository
   is a "remote repository", and "git clone" configures things in
   the new repository so that you can conveniently interact with
   that original repository.  The last part is what lets you say
   "git fetch origin", for example, to interact with the "origin"
   remote.

 * Branches are local to each repository.  It is merely a social
   convention that the primary branch in the repository you cloned
   from (i.e. your "origin") is often called 'master', the primary
   branch in the local repository is called 'master', and you often
   interact with the history of the 'master' branch of the "origin"
   when you are on your 'master' branch.  There is no stronger tie
   between their 'master' and your 'master' other than the social
   convention, but Git makes it easier for you to work that way by
   setting a few configuration variables.

 * Some of the social conventions, and the configuration Git sets up
   to let you follow them easily, allows you to find out where the
   tips of branches at your remotes were, when you last observed
   them (remember, Git is distributed, so you do not ask "right
   now"; instead you have "when you last observed" and "make an
   observation right now" separately).  This is achieved by keeping
   the record of the last observation in "remote-tracking branches".

   The last observed value of the 'master' branch of the remote
   repository "origin" is stored as 'origin/master' (its full name
   is 'refs/remotes/origin/master', but you rarely have to spell it
   out) remote-tracking branch.

   CAVEAT: some older documentation call a "remote-tracking branch"
   just "remote branch", but we have been trying to move away from
   that practice, as it is confusing, because the 'master' branch at
   the 'origin' remote is often called a 'remote branch'.  When you
   see 'remote branch', you need to make sure which one the writer
   meant.

 * "git fetch" (and "git pull", which internally invokes "git
   fetch") is a way to "make the observation now".  "git fetch
   origin" updates your remote-tracking branches for the "origin".

 * "git pull" (and "git pull --rebase") is a way to do the "fetch"
   above and then integrate the history of the branch at the remote
   (which now you know its latest state, because you just observed
   it) with the history you have on your branch.  Again, these
   branches may be named 'master' but the user needs to be aware
   that they are two separate branches (your 'master' branch is just
   as a different entity from the 'master' branch of the remote
   repository as it is your 'next' or any other branch).

   To make it easier to work, git configures the history of which
   branch you obtained/observed from what remote is to be integrated
   with your history per your local branch.  Immediately after "git
   clone", you will typically have your 'master' branch, and the
   branch "knows" that it wants to integrate with the 'master'
   branch at 'origin' remote.  So "git pull" becomes:

    - "git fetch origin", because you will integrate with the
      history that comes from that remote, not other remotes;

    - which updates 'origin/master' remote-tracking branch, and
      possibly other remote-tracking branches under 'origin/'; and

    - integrate your branch with the history of 'origin/master'
      remote-tracking branch.

   We say "your 'master' branch is set to integrate with
   remote-tracking branch 'origin/master'".  It is morally
   equivalent to say "your 'master' branch integrates with the
   'master' branch of 'origin'".

  CAVEAT: people often call this relationship between your 'master'
  branch and 'origin/master' (or the 'master' branch of 'origin'
  remote) "tracking", e.g. "your 'master' branch tracks
  'origin/master'".  Unfortunately, this is a confusing misnomer, as
  the relationship between the 'master' branch of 'origin' and the
  remote-tracking branch 'orign/master' you have in your local
  repository is also called "tracking" (the latter keeps track of
  the former).  You are better off avoid using the word "track" for
  this purose, unless it is very clear from the context.
