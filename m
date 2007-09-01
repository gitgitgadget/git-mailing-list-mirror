From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Sat, 01 Sep 2007 10:54:04 -0700
Message-ID: <7vwsvas24j.fsf@gitster.siamese.dyndns.org>
References: <20070831000149.GK1219@pasky.or.cz>
	<9e4733910709010815t23849056j9039a9d92eae15ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org,
	jnareb@gmail.com, ltuikov@yahoo.com
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 19:54:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRXBE-0004Gg-32
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 19:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbXIARyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 13:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbXIARyN
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 13:54:13 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbXIARyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 13:54:13 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C251912C748;
	Sat,  1 Sep 2007 13:54:28 -0400 (EDT)
In-Reply-To: <9e4733910709010815t23849056j9039a9d92eae15ee@mail.gmail.com>
	(Jon Smirl's message of "Sat, 1 Sep 2007 11:15:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57278>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> On 8/30/07, Petr Baudis <pasky@suse.cz> wrote:
>>
>>   due to popular (Junio's) demand, I have set up a gitweb-oriented fork
>> of git at repo.or.cz:
>>
>>         http://repo.or.cz/w/git/gitweb.git
>>
>>   It is meant as a hub for various gitweb-related patches and
>> development efforts. So far it is pre-seeded by the patches repo.or.cz's
>> gitweb uses. It is divided to three main branches (StGIT patchstacks in
>> reality), where master is what Junio is gonna pull to git's master.
>
> Using gitweb....
> Since this is a patch stack, how do I get the summary log messages for
> just the commits on the branch without getting the log messages for
> the master repository mixed in? Would that give me a nice list of the
> pending patches?

That's an excellent suggestion.  I'd love to see "fork" aware
gitweb myself.

If a project A is "forked" repo.or.cz style to a project B, what
often is interesting to see is what changes B has relative to A.

In other words, you would want to view all of B except what are
in A, something like:

$ gitk --all --not $(git for-each-ref --format='%(objectname)' refs/remotes/A)
