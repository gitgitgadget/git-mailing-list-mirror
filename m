From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 10:50:21 -0700
Message-ID: <xmqq618hxxya.fsf@gitster.dls.corp.google.com>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 27 19:50:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmnAr-0007WQ-2o
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 19:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbbD0RuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 13:50:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932817AbbD0RuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 13:50:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 251CF4BF05;
	Mon, 27 Apr 2015 13:50:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DJqqehufKKurMp1y5ikEym+QccI=; b=XGz3S2
	+gdUlxjnkj98q9v5fpoGR92Huc5Pz5aYZv0EhEj4Vfns7/Xg8RIyIqJFxgaKgaP/
	XV8QEx9KL89w/wCo0pVqQOL1Sp6XhV9peY0b6R0d4qMdBbEJ2FkJAe+NIwEln2f3
	gd+T4KeCi9Clqmf1vwQ0xfzRUmrFr4B+k0Fxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qLsXEi+vbxziREhxd/90l6IMvxhjerXd
	BbMZcrD4NyGc1VUSSwgkXGvjGACXHfW++0X6+2IMws2AHAgAj4aMIXBpJv23nZVD
	FxHOkGUXxYrwKmx0SOrGhLwNs70NSFc6j1RCaYkxKYxJzQU2QtE0jfluC1KMrsHV
	f1vxaidTqRw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D99A4BF04;
	Mon, 27 Apr 2015 13:50:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 889CE4BF03;
	Mon, 27 Apr 2015 13:50:22 -0400 (EDT)
In-Reply-To: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 27 Apr 2015 13:17:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E08A5E6C-ED05-11E4-9F35-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267860>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The only changes are to the README files, most notably the list of
> maintainers and the project URL.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  contrib/hooks/multimail/README     | 43 +++++++++++++++++++-------------------
>  contrib/hooks/multimail/README.Git |  6 +++---
>  2 files changed, 25 insertions(+), 24 deletions(-)
> ...

(mental note) OK, only the doc updates; that should be safe even to
apply during -rc freeze period if I wanted to...

> diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
> index 477d65f..6efa4ff 100644
> --- a/contrib/hooks/multimail/README
> +++ b/contrib/hooks/multimail/README
> @@ -456,34 +456,35 @@ consider sharing them with the community!
>  Getting involved
>  ----------------
>  
> -git-multimail is an open-source project, built by volunteers.  We
> -would welcome your help!
> +git-multimail is an open-source project, built by volunteers. We would
> +welcome your help!

Yuck.

> +Whenever enough changes to git-multimail have accumulated, a new
> +code-drop of git-multimail will be submitted for inclusion in the Git
> +project.

OK.

> diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multimail/README.Git
> index 129b771..ab3ece5 100644
> --- a/contrib/hooks/multimail/README.Git
> +++ b/contrib/hooks/multimail/README.Git
> @@ -3,13 +3,13 @@ section of the Git project as a convenience to Git users.
>  git-multimail is developed as an independent project at the following
>  website:
>  
> -    https://github.com/mhagger/git-multimail
> +    https://github.com/git-multimail/git-multimail
>  
>  The version in this directory was obtained from the upstream project
> -on 2014-04-07 and consists of the "git-multimail" subdirectory from
> +on 2015-04-27 and consists of the "git-multimail" subdirectory from
>  revision
>  
> -    1b32653bafc4f902535b9fc1cd9cae911325b870
> +    8c3aaafa873bf10de8dddf1d202c449b3eff3b42 refs/tags/1.0.2

Huh, really?
