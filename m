From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3 1/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 15 Oct 2013 14:57:42 -0700
Message-ID: <xmqqhacici3t.fsf@gitster.dls.corp.google.com>
References: <1379776269-4496-1-git-send-email-philipoakley@iee.org>
	<1379776269-4496-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Oct 15 23:57:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWCcg-0007jz-At
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 23:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933358Ab3JOV5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 17:57:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759563Ab3JOV5p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 17:57:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E7F74A7C3;
	Tue, 15 Oct 2013 21:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W5L0jCfhaN7S23TGWDepjuEY+Rk=; b=bRMudq
	IBnKU+uoLbROTa5hgLwCxWlj2qSPlgdqFZVU7B8tlsrGoQGNFowz7g32cG/gBdjY
	sJejlMKof4w8+vGM856koh2GLZBZ0/vRcZg/KuYwfJd16yzi75P1r37/a4AUY8LA
	/OUeBOcYrmBJHXcekqN3Z7ikzIq3qtr5K9QRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cB1bmV6m34jAEXYlyi+P9gxfHcFzMFKI
	5urMw+ak4eu3qUzmyfUBm5kktMyM0HF9qW5cR4EnQASErlTK05fqJN+hn76zSZQR
	HW0ZEr+fC4lHnS4LW/moHutUI5Ie3IWvHk0w+4jERzn2NlN6UcS6PDKsv3CICeAi
	H02Y5dFq9ts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AE754A7C1;
	Tue, 15 Oct 2013 21:57:45 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5D044A7C0;
	Tue, 15 Oct 2013 21:57:44 +0000 (UTC)
In-Reply-To: <1379776269-4496-2-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Sat, 21 Sep 2013 16:11:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D2372388-35E4-11E3-8512-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236202>

Philip Oakley <philipoakley@iee.org> writes:

> The Git cli will accept dot '.' (period) as the relative path,
> and thus the current repository. Explain this action.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>
> This updates 431260cc8dd

It appears that the original has already been merged to 'next', so
we need to make this incremental on top.  I'll queue this on top.

-- >8 --
From: Philip Oakley <philipoakley@iee.org>
Subject: doc/cli: make "dot repository" an independent bullet point

The way to spell the current repository with a '.' dot is
independent from how the pathspec allows globs expanded by Git.

Make them two separate bullet items in the enumeration.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcli.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 1672842..24e1784 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -58,10 +58,10 @@ the paths in the index that match the pattern to be checked out to your
 working tree.  After running `git add hello.c; rm hello.c`, you will _not_
 see `hello.c` in your working tree with the former, but with the latter
 you will.
-+
-Just as the filesystem '.' (period) refers to the current directory,
-using a '.' as a repository name in Git (a dot-repository) is a relative
-path for your current repository.
+
+ * Just as the filesystem '.' (period) refers to the current directory,
+   using a '.' as a repository name in Git (a dot-repository) is a relative
+   path and means your current repository.
 
 Here are the rules regarding the "flags" that you should follow when you are
 scripting Git:
