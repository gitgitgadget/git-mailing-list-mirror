From: Junio C Hamano <gitster@pobox.com>
Subject: "What's cooking" between #05 and #06
Date: Tue, 16 Apr 2013 16:52:14 -0700
Message-ID: <7v8v4ihw41.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 17 01:52:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USFfr-0004fv-KA
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 01:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab3DPXwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 19:52:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab3DPXwR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 19:52:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4C801720F;
	Tue, 16 Apr 2013 23:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PfoORIHI55ELvXXAqjmClJP0fgg=; b=rMNKwO
	nh7eXQkeSah2kO4E6R0iQLjPvwnusfdI9d+ILYjTwPrS43vv3ByAOhMVKGZb3MEW
	volX6vKkF7xYRI/hQMMdfmitrrSKQ5CzAhmiawgEy2beyWy7nYWiMR5Xz6FW5MxF
	EA0l00cjbFa8/5mmK5NBVmspDdleXaoiNml80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j7J1v7NqhzTzgdMHkWN8JjCb/7byZt4t
	Mte8HRfs5v2q3wz/cDj16cLwP+ISP3nxtVFdfcs5tmrDosTJ3C/vIa/Z+sPVptY0
	PtG84IfHJtSJv2qD3R0BK+u0qiOSkFiISqpcLcu52/J5AzREvH1xJ6EZcWk+FvAG
	PfaoAGNAmeQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB5C31720E;
	Tue, 16 Apr 2013 23:52:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 043F417207; Tue, 16 Apr
 2013 23:52:15 +0000 (UTC)
In-Reply-To: <7vhaj7r116.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 15 Apr 2013 13:28:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAAB7F86-A6F0-11E2-A79F-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221490>

Quick incremental report on tonight's integration status.

> * jk/http-error-messages (2013-04-06) 9 commits
>   (merged to 'next' on 2013-04-11 at 7a03981)
>  ...
>  + http: add HTTP_KEEP_ERROR option
>
>  Improve error reporting from the http transfer clients.

Peff posted an update to this to fix a regression, which is parked
on 'next' for tonight.

> * kb/status-ignored-optim-2 (2013-04-15) 14 commits
>  ...
>
>  Rerolls kb/status-ignored-optim topic (reverted from 'next').  Not
>  merged to 'pu' as it heavily interferes with as/check-ignore topic.

This still has not been merged to 'pu' for the same reason.

> * jk/remote-helper-with-signed-tags (2013-04-15) 3 commits
>  - transport-helper: add 'signed-tags' capability
>  - transport-helper: pass --signed-tags=warn-strip to fast-export
>  - fast-export: add --signed-tags=warn-strip mode

There were some comments on the noisiness of the warning output, but
it appears that everybody involved in the area is basically happy
with the direction this series goes in, so I'll expect a reroll and
then merge it to 'next'.

> * jn/gitweb-install-doc (2013-04-15) 1 commit
>  - gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM
>
>  Reword gitweb configuration instrutions.

This hasn't been merged to 'next'.

There are a few competing proposals to further update it.  I am
inclined to take Jonathan's version.

> * nd/pretty-formats (2013-04-01) 12 commits
> ...

Updated the one in 'pu' with the reroll.

> * fc/transport-helper-error-reporting (2013-04-11) 3 commits
>  - transport-helper: improve push messages
>  - transport-helper: mention helper name when it dies
>  - transport-helper: report errors properly
>
>  Rerolled enough times.  In-code comments may want to be further
>  extended to explain tricky parts, but seems to be ready otherwise.
>
>  Will merge to 'next'.

This is in 'next' with the last one (missing from the above list)
with slightly tweaked commit log message.

> * jk/submodule-subdirectory-ok (2013-04-10) 2 commits
>  - submodule: drop the top-level requirement
>  - rev-parse: add --prefix option
>
>  Allow various subcommands of "git submodule" to be run not from the
>  top of the working tree of the superproject.
>
>  Waiting for comments.

Any submodule users wants to weigh in?  The code looked fine, but I
do not heavily use it (and the repository with a submodule I have, I
do not have a "subdirectory" ;-, so I am a bad guinea pig).


> * mv/sequencer-pick-error-diag (2013-04-11) 1 commit
>  - cherry-pick: make sure all input objects are commits
>
>  "git cherry-pick $blob $tree" is diagnosed as a nonsense.
>
>  Will merge to 'next'.

This, with the help with a fix to a long-standing issue in the
command line parser for revisions from Thomas, is now in 'next'.

> * fc/remote-hg (2013-04-11) 21 commits
> ...
>  Rerolled.
>
>  Waiting for comments.

I think this has gone as far as it can go with the people who are
interested in reviewing this series on the list.  It is in 'next'
now.

> * nd/magic-pathspecs (2013-03-31) 45 commits
> ...
>
>  Migrate the rest of codebase to use "struct pathspec" more.

Still out of 'pu' for the same reason as yesterday (and as
kb/status-ignored-optim topic).
