From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Tue, 22 Jul 2008 21:39:29 -0700
Message-ID: <7vsku1gqny.fsf@gitster.siamese.dyndns.org>
References: <200807230325.04184.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 06:40:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLW9V-0008DF-Jq
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 06:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbYGWEjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 00:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYGWEjh
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 00:39:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbYGWEjg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 00:39:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A18D62B9DA;
	Wed, 23 Jul 2008 00:39:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CBDA02B9D5; Wed, 23 Jul 2008 00:39:31 -0400 (EDT)
In-Reply-To: <200807230325.04184.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 23 Jul 2008 03:25:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A0F7190-5871-11DD-8E9E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89601>

Jakub Narebski <jnareb@gmail.com> writes:

>    15. What operating system do you use Git on?
>        (one or more: multiple choice, as one can use more than one OS)
>      - Linux, *BSD (FreeBSD, OpenBSD, etc.), MS Windows/Cygwin,
>        MS Windows/msysGit, MacOS X, other UNIX, other

Shouldn't we at least name the ones we have specific support in our
Makefile instead of blanketting them into one "other Unices"?  We may not
necessarily want to list all of them, but at least major ones like SunOS,
HP-UX and AIX deserve to be listed, methinks.

>      + "What hardware platforms do you use GIT on?" question was
>        removed; should it stay?

I think the removal of "hardware platform" question is a good idea.

>    24. If you want to see Git more widely used, what do you
>        think we could do to make this happen?
>      + Is this question necessary/useful?  Do we need wider adoption?

My stance on this has always been that wider adoption, even though it
might eventually come as a consequence of being the best in the field, is
never a goal.

>    27. Which of the following features do you use?
>        (zero or more: multiple choice)
>      - git-gui or other commit tool, gitk or other history viewer, patch
>        management interface (e.g. StGIT), bundle, eol conversion,
>        gitattributes, submodules, separate worktree, reflog, stash,
>        shallow clone, detaching HEAD, mergetool, interactive rebase,
>        add --interactive or other partial commit helper, commit
>        templates, bisect, other (not mentioned here)
>      + should probably be sorted in some resemblance of order
>      + are there any new features which should be listed here?

The above is a valid and interesting question, but "Which features do you
find unique and useful ones, compared to other systems?" would be another
interesting question to ask to people with experience with other systems.

>    28. If you use some important Git features not mentioned above,
>        what are it?
>        (free form)

"rerere"?

>    40. Do you read the mailing list?
>     -  yes/no

Which mailing list?  Do we want to ask about alternative lists?

I am not sure how and where, but I think j/egit should also be
mentioned and/or asked about.
