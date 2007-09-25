From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Workflow question
Date: Tue, 25 Sep 2007 14:28:22 -0700
Message-ID: <7vabra5tah.fsf@gitster.siamese.dyndns.org>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se>
	<46F96493.8000607@gmail.com>
	<20070925201717.GB19549@segfault.peff.net>
	<46F97618.9010207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 23:28:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaHxO-0001UF-Vm
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 23:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbXIYV2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 17:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754466AbXIYV2a
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 17:28:30 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbXIYV23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 17:28:29 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 119D113BCE8;
	Tue, 25 Sep 2007 17:28:46 -0400 (EDT)
In-Reply-To: <46F97618.9010207@gmail.com> (Russ Brown's message of "Tue, 25
	Sep 2007 15:56:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59174>

Russ Brown <pickscrape@gmail.com> writes:

> I keep reading things similar to this and bit by bit I'm starting to get
> it. :) I suppose this is one case in which it's definitely a
> disadvantage to have a good understanding of svn before coming to git...
>
> <yoda>You must unlearn what you have learned</yoda>

You do not have to unlearn; if Jeff truly unlearned he wouldn't
have spotted you were trapped in SVN mentality.  You just need
to learn there could be other ways ;-).

> If you delete a branch that has commits on it that aren't referenced by
> any other branches, will those commits be removed by something like git
> pack or git gc?

Yes, eventually.

> I suppose what has me the most confused is how a developer works with a
> remote branch: I've come to understand that a developer should never
> check out and work on a remote branch, and always create a local one and
> work on that. If he does that using the above hierarchy, there then
> becomes main->projectX->featureY->jeff_local_branch_of_featureY. Or is
> is possible for a developer to work directory on a remote branch?

The statement in the last sentence does not make any sense.
Remote is called remote because it is remote and supposed to be
out of reach ;-)

More seriously, remotes are used as reference points so if you
"work directly on them", you cannot use them as reference points
any more; you defeat the sole purpose of existence of remotes.

You can work _without_ using remote tracking branches, but that
is mostly for merge based workflow.  It appears that you are
leaning towards rebase-heavy workflow, so I do not think it is
applicable to your project.
