From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-reset.txt: Use uniform HEAD~N notation in all examples
Date: Sat, 01 Sep 2007 11:39:45 +0300
Organization: Private
Message-ID: <hcmesrse.fsf@cante.net>
References: <tzqfsijk.fsf@cante.net>
	<7vy7frzfzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 10:38:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IROV6-00073u-R5
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 10:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbXIAIh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 04:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbXIAIh5
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 04:37:57 -0400
Received: from main.gmane.org ([80.91.229.2]:46959 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378AbXIAIhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 04:37:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IROTb-0004aS-CB
	for git@vger.kernel.org; Sat, 01 Sep 2007 10:37:07 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 10:37:07 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 10:37:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:h5Mowr9LpEXD5B5d0Q4nZ5FOWwg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57259>

Junio C Hamano <gitster@pobox.com> writes:

> Jari Aalto <jari.aalto@cante.net> writes:
>
>> The manual mixed both caret(HEAD^) and tilde (HEAD~N) notation in
>> examples. This may be xconfusing to new users. The "counting" notation
>> HEAD~N likely to be grasped more easily because it allow successive
>> numbering 1, 2, 3 etc.
>
> I am mildly negative on this change.
>
> Referring to (rather, "having to refer to" to fix mistakes) the
> previous commit happens far more often than referring to an
> ancestor of an arbitrary generation away (i.e. HEAD~$n).  I
> think it is a better idea to expose users early on that HEAD^
> notation which is shorter to type.

If the page contains/combines many different ways of doing things,
this creates confusion, especially if the distictions are not explained.
And it would be unnecessary to explain the HEAD^ and HEAD~1 similarities
in every page where these two get mixed.

PRICPLES:

1. The novice user is best served by making things simple and uniform.

2. Utilize concepts that may already be familar. E.g. other VCS/SCM tools
   have concept of counting back revisions with negative numbers: -1,
   -2, -3; so following this same idea in git manual pages would 
   already rang associated bells.

Like:

    HEAD, HEAD~1, HEAD~2

If the syntax is changed in the middle (as it was in manual page),
that interrupts the kognitive flow of reading.

    HEAD, HEAD^, HEAD~2

I'm sure when user progresses with his learning, the differences or
similarities of the notations become no-op.

But manual pages are served for wide audience. They are most
important to new users.

I hope we could strive for KISS is possible.

-- 
Welcome to FOSS revolution: we fix and modify until it shines
