From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commit summary, --pretty=short and other tools
Date: Mon, 17 Sep 2007 17:24:05 -0700
Message-ID: <7vr6kwyg62.fsf@gitster.siamese.dyndns.org>
References: <20070917112136.GA30201@glandium.org>
	<55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:24:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQsz-0005rP-DR
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbXIRAYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 20:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbXIRAYM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:24:12 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbXIRAYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:24:12 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 22DD313700B;
	Mon, 17 Sep 2007 20:24:29 -0400 (EDT)
In-Reply-To: <55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr> (Benoit
	SIGOURE's message of "Tue, 18 Sep 2007 01:52:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58513>

Benoit SIGOURE <tsuna@lrde.epita.fr> writes:

> I started using Git as a "better SVN client" and didn't follow this
> "good idea".  The thing, as I already pointed out on IRC, these a are
> more rules than just guidelines.  Some tools (such as rebase) enforce
> them.  That is, they rewrite commit messages.  I found this extremely
> annoying (Junio provided a patch but I don't know whether it's been
> applied, I personally use it in my Git).

Wow, ancient history.

d7f6bae28142e07e544efdab73260cf9f60ca899 (rebase: try not to
munge commit log message) is what you are talking about.  It is
in 1.5.3.

commit d7f6bae28142e07e544efdab73260cf9f60ca899
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sat Jul 28 17:57:25 2007 -0700

    rebase: try not to munge commit log message

    This makes rebase/am keep the original commit log message
    better, even when it does not conform to "single line paragraph
    to say what it does, then explain and defend why it is a good
    change in later paragraphs" convention.

    This change is a two-edged sword.  While the earlier behaviour
    would make such commit log messages more friendly to readers who
    expect to get the birds-eye view with oneline summary formats,
    users who primarily use git as a way to interact with foreign
    SCM systems would not care much about the convenience of oneline
    git log tools, but care more about preserving their own
    convention.  This changes their commits less useful to readers
    who read them with git tools while keeping them more consistent
    with the foreign SCM systems they interact with.

    Signed-off-by: Junio C Hamano <gitster@pobox.com>
