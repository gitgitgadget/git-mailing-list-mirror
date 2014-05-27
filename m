From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] wording fixes in the user manual and glossary
Date: Tue, 27 May 2014 12:52:00 -0700
Message-ID: <xmqq4n0bf19b.fsf@gitster.dls.corp.google.com>
References: <1401114023-4015-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	Ben Aveling <bena.001@optusnet.com.au>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 21:52:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNQ2-0006Nk-KX
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 21:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbaE0TwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 15:52:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61465 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbaE0TwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 15:52:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 781BA1BB6E;
	Tue, 27 May 2014 15:52:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=In1Al+Apsri9MUNmqcgQZjUCnzw=; b=yAWvfz
	cNHMlPeyuGy/aTXazaNx9ecSCXpvcpQNA1dCY208XeKTB/vazjPvpDulI9gdzpAf
	QMznlNrEe1HB9R8TlPPVzWuy7CqDDf8vngIswUGPOm3ngtXVRXVc/UG84ycMpPnm
	D1hyL0MMDyIduSoRk1+qwcqgOrRo9uqzDLzkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SWyKOt37Tr+9NDF8tqK0DHnrJkGxl5kQ
	Xkx+ttujkHSsLKHa6IRRBK200ACRjm+zbSNg8HIFnnM4KNStcc8DU/pWTC+kylYI
	JFZgaU1MOXaXDKBoXaGLF5CrWmRIAs7cJErUTAujV5kRV+TuromONuFNILHW55AH
	1ba98IeczFY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6DD221BB6C;
	Tue, 27 May 2014 15:52:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 004241BB67;
	Tue, 27 May 2014 15:52:01 -0400 (EDT)
In-Reply-To: <1401114023-4015-1-git-send-email-jmmahler@gmail.com> (Jeremiah
	Mahler's message of "Mon, 26 May 2014 07:20:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5EF62F00-E5D8-11E3-AE73-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250195>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> Various minor wording fixes throughout the user manual
> and glossary.
>
> The section on "Updating a repository with git fetch" was
> substantially re-worded to try and better explain `git fetch`.
>
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>
> Notes:
>     From the feedback I received by Chris Packham [1] it was clear
>     that my re-wording of the section "Updating a repository with git fetch"
>     still wasn't quite right [1].
>     
>     [1]: http://marc.info/?l=git&m=140100460903936&w=2
>     
>     I re-worded it some more to try and emphasize the remote (upstream)
>     and local aspects of `git fetch`.  Chris liked those changes better [2].
>     
>     [2]: http://marc.info/?l=git&m=140109062903038&w=2
>     
>     I expanded upon this even further.  The section on git-pull is similar
>     so I tried to use that as a basis.  I also thought the relationship between
>     git fetch and git pull was worthy of a short note along with a link to
>     the section on git-pull.
>
>  Documentation/glossary-content.txt |  2 +-
>  Documentation/user-manual.txt      | 28 ++++++++++++++++++----------
>  2 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index be0858c..4e0b971 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -1,7 +1,7 @@
>  [[def_alternate_object_database]]alternate object database::
>  	Via the alternates mechanism, a <<def_repository,repository>>
>  	can inherit part of its <<def_object_database,object database>>
> -	from another object database, which is called "alternate".
> +	from another object database, which is called an "alternate".
>  
>  [[def_bare_repository]]bare repository::
>  	A bare repository is normally an appropriately
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index d33f884..f5fd61b 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -416,14 +416,22 @@ REVISIONS" section of linkgit:gitrevisions[7].
>  Updating a repository with git fetch
>  ------------------------------------
>  
> -Eventually the developer cloned from will do additional work in her
> -repository, creating new commits and advancing the branches to point
> -at the new commits.
> +After you clone a repository and commit a few changes of your own, you
> +may wish to check the original repository for updates.

The above is very good.

> +The linkgit:git-fetch[1] command is used to update all the remote-tracking
> +branches to the latest version found in those repositories.
> +It will not touch any of your own branches--not even the "master"
> +branch that was created during clone.

It is harder to review with unnecessary rewrapping of the text X-<.

I somehow feel that the original was clear around here, by being
explicit that "git fetch $there $that" is not it is talking about,
which seems to have been lost in this update.


> +The linkgit:git-merge[1] command can then be used to merge the changes.
> +
> +-------------------------------------------------
> +$ git fetch
> +$ git merge origin/master
> +-------------------------------------------------

That is not wrong per-se, but it is not a very good example.  If you
immediately merge, there is no reason not to say "git pull" in the
first place ;-)  For this to be a good example, there needs

	git log -p ..origin/master

before that merge happens, I would think.

Not that I read the text around here and confirmed that this is a
good place in the overall flow of the learning to teach about "log
-p" and "merge", though.

> @@ -1811,8 +1819,8 @@ manner.
>  You can then import these into your mail client and send them by
>  hand.  However, if you have a lot to send at once, you may prefer to
>  use the linkgit:git-send-email[1] script to automate the process.
> -Consult the mailing list for your project first to determine how they
> -prefer such patches be handled.
> +Consult the mailing list for your project first to determine
> +their requirements for submitting patches.

OK.

>  [[importing-patches]]
>  Importing patches to a project
> @@ -2255,7 +2263,7 @@ $ git checkout test && git merge speed-up-spinlocks
>  It is unlikely that you would have any conflicts here ... but you might if you
>  spent a while on this step and had also pulled new versions from upstream.
>  
> -Some time later when enough time has passed and testing done, you can pull the
> +Sometime later when enough time has passed and testing done, you can pull the

OK.
