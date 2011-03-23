From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 10:35:38 -0700
Message-ID: <7vzkoleo45.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net>
 <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net>
 <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 23 18:36:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2RyV-0000YA-9U
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 18:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab1CWRf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 13:35:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab1CWRf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 13:35:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BBC9478F;
	Wed, 23 Mar 2011 13:37:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mUJnbTIjoXMj+BfM5o1DkqDx9MQ=; b=haYyxW
	RD5b6danAFDQEgbhvHsm3AP133Xt4pry+z3bmc9syPQ2QJMsnscO73Kkg5En0QDm
	/np9VnvOKYHNY+ER2x3qKY3xAjPn4ZuIqzaquGm6Ekyi3y5ITyoPtkImvMxrG4Uz
	e1xOJjUQCJMJsxZI7k5hwMJ8Z8ildyz2M8LSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XfXF4PaPJ00ERPRZkAOdZ1sZe4TAT5mP
	JBYVT/QebZhlVrGM7yBP8YA/kPTb0KAzvTtuyAMzxuGKQ97+TF/xDUjxn9pB/OYj
	TLxiFBJog6pa1E2hFwZT6Kxe9ExIGjvhFSWlTK4vJAXO4tGKdXWilaAs5+S5n6uf
	bknbGNWPIlQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C265478C;
	Wed, 23 Mar 2011 13:37:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7C774786; Wed, 23 Mar 2011
 13:37:21 -0400 (EDT)
In-Reply-To: <7v7hbqgc7g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 Mar 2011 07:09:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AAD5292-5574-11E0-931D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169859>

Junio C Hamano <gitster@pobox.com> writes:

> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
>> and the answer is git ls-files --with-tree=<treeish> | grep <regex> .
>> But the --with-tree param is so counterintuitive to me that I read the
>> manpage, everytime.
>
> Because --with-tree nor ls-files is the tool that was designed for.
>
> If you want to find out about a branch, why aren't you using "ls-tree -r"?

It obviously needs a side note to answer "what is 'ls-files --with-tree'
for, then?", so here is such a note.

The --with-tree option was invented for the sole purpose of helping "git
commit -- $paths" back when "commit" was still a scripted Porcelain.  We
wanted to make sure that the $paths given from the command line made sense
(we wanted to diagnose e.g. "git commit Mkaefile" as a typo).

The obvious plumbing to check if the given pathspec matches what are known
to git (i.e. in the index) is:

	git ls-files --error-unmatch -- $paths

but there is a catch.  If you are about to commit a removal of a path,
i.e.

	$ rm -f generated-file.c
	$ git update-index --remove generated-file.c
        $ git commit -m "Do not keep a generated file in SCM" generated-file.c

the above ls-files would report that the pathspec "generated-file.c" does
not match, as that path is no longer in the index.

To make the "ls-files --error-unmatch" useful for this check, we use:

	git ls-files --error-unmatch --with-tree=HEAD -- $paths

to overlay the contents of the tree on top of what is already in the index
and then determine what paths are "known" to git at that point.

So your use of "git ls-files --with-tree=<unrelated branch>" has been
giving results that you didn't want to see, as the set of paths in your
index that is based on your current branch most likely are different from
what is in that unrelated branch.

I don't think there is any in-tree users of --with-tree option anymore,
other than the tests, so it probably is not even worth thinking about
removing it and replacing it with a --with-head-tree (as using any commit
other than HEAD makes little sense) option.
