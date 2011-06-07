From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Notes that tags need to pushed explicitely
Date: Tue, 07 Jun 2011 07:12:34 -0700
Message-ID: <7vk4cx7mst.fsf@alter.siamese.dyndns.org>
References: <20110606130205.GA41674@sherwood.local>
 <1307443713-14534-1-git-send-email-sdaoden@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Daode Nurpmeso <sdaoden@gmail.com>
To: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 16:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTx1V-0004Ub-Um
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 16:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab1FGOMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 10:12:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab1FGOMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 10:12:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A51D4D76;
	Tue,  7 Jun 2011 10:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Aa1M199rtBb7Qf0RCe+r0au35LM=; b=haqdrF
	sWghIn7ufsr6ojuJNhEvSkdZOl4Yl3fd+wXAP3XHsVOJFI80OlnrOYf7BQkGlGYd
	0kZQ2F7ieO7qvjh8LEq7UnVdRWfwfZCruAwBrilvqqZ8/ljxqcjMj1oqxDpsR/nK
	zmrXJzJ2YB/kem4QdEP5tPE4ICNQkf4/ZFcso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FQ9HMH49tzdPFxy9bTHxLzyD3fCNqvpV
	RsdOWvw3Hq89DZQG43bmZLVW5CByC/nGXSHfUKhib4noh8VQM1wKzVxtTgHQXG2H
	M4/QZkKPp0G5iNdKC0mj7wqtFJ4INvS8k5e2y/7uBhAU+/B4QjZ7YKmzWGgpllgG
	lun++W6V3Fw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25EE34D74;
	Tue,  7 Jun 2011 10:14:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CD5944D6F; Tue,  7 Jun 2011
 10:14:46 -0400 (EDT)
In-Reply-To: <1307443713-14534-1-git-send-email-sdaoden@gmail.com> (Steffen
 Daode Nurpmeso's message of "Tue, 7 Jun 2011 12:48:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 822EB4D0-9110-11E0-823A-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175207>

Steffen Daode Nurpmeso <sdaoden@googlemail.com> writes:

> ---

Sign-off?

>  Documentation/git-tag.txt     |    3 ++-
>  Documentation/gittutorial.txt |    1 +
>  2 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index d82f621..242837f 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -27,7 +27,8 @@ Unless `-f` is given, the tag to be created must not yet exist in the
>  If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
>  creates a 'tag' object, and requires a tag message.  Unless
>  `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
> -in the tag message.
> +in the tag message.  Tag objects can be pushed upstream with
> +linkgit:git-push[1].
>  
>  If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
>  are absent, `-a` is implied.

This part of the patch looks sane and uncontroversial.

> diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
> index 0982f74..08c0c3a 100644
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -520,6 +520,7 @@ names.  For example:
>  
>  -------------------------------------
>  $ git diff v2.5 HEAD	 # compare the current HEAD to v2.5
> +$ git push v2.5		 # push the tag upstream
>  $ git branch stable v2.5 # start a new branch named "stable" based
>  			 # at v2.5
>  $ git reset --hard HEAD^ # reset your current branch and working

This feels way out of place in the context of the story the tutorial is
telling. These are examples that various ways to spell object names are
used to identify a commit to commands that want to be given commits, but
"git push <tagname>" is _not_ an example of such a command.  Also there is
nothing in the vicinity that pushes a branch that contains the tagged
commit out; if the earlier example to create this v2.5 tag were done to
mark a commit in an existing history you obtained from elsewhere, pushing
the tag alone might make sense, but usually you push branches out and then
optionally tags that refer to commits on those branches.

How about adding an example in git-push section instead?

 Documentation/git-push.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 88acfcd..363d3df 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -371,6 +371,11 @@ git push origin HEAD:master::
 	`origin` repository. This form is convenient to push the current
 	branch without thinking about its local name.
 
+git push origin tag v1.5::
+	Push the `v1.5` tag to the `origin` repository. A newly created
+	tag needs to be published explicitly like this, just like a newly
+	created branch does not get published automatically.
+
 git push origin master:refs/heads/experimental::
 	Create the branch `experimental` in the `origin` repository
 	by copying the current `master` branch.  This form is only
