From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Make AsciiDoc links always point to HTML files
Date: Fri, 06 Sep 2013 14:43:34 -0700
Message-ID: <xmqqa9jpwrqx.fsf@gitster.dls.corp.google.com>
References: <522A350A.5040903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 23:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI3oh-0000Dd-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 23:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab3IFVnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 17:43:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab3IFVnj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 17:43:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E2573F068;
	Fri,  6 Sep 2013 21:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkIy4hO2qJtRq6rzl5n0ENRnHjo=; b=Ftys5x
	Jr1lh46mJbp0jPlBgmvRMUZAlBfrccUf1gSe64FMhZN0GXzaD/fuPiTEGGfn5viG
	s6yMHvf6nygpOVRdap5rc3wVcVlhSx+nFGVq1YwTrctg/YeXAwbhcwwMn1y3GKy4
	tHCk0fbeZXnHjY3MGMcmCKsGYg5NIKXIMkyac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hwRCilLttcJvQhfDX1VB7ThdnuMJJB9c
	nmoW86v/I1Vmrqf/f3AWP72X8JPs6eQaW3OTgRHfwL3+YIhpfPVhcD9AdTgt96WU
	OXwlmVoTcxkcYVzBOR8D673jcW5Uxr+MKwU7HZ/uqDDcFKjT+zkaokd+PATC2WvB
	LY721XEk/f4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9FC93F067;
	Fri,  6 Sep 2013 21:43:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF0FA3F065;
	Fri,  6 Sep 2013 21:43:36 +0000 (UTC)
In-Reply-To: <522A350A.5040903@gmail.com> (Sebastian Schuberth's message of
	"Fri, 06 Sep 2013 22:03:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 62AE6046-173D-11E3-B026-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234101>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> AsciiDoc's "link" is supposed to create hyperlinks for HTML output, so
> prefer a "link" to point to an HTML file instead of a text file if an HTML
> version of the file is being generated. For RelNotes, keep pointing to
> text files as no equivalent HTML files are generated.
>
> If appropriate, also update the link description to not contain the linked
> file's extension.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---

Makes sense; we should have done this back when we applied 5e00439f
(Documentation: build html for all files in technical and howto,
2012-10-23).



>  Documentation/everyday.txt                | 2 +-
>  Documentation/git-credential.txt          | 2 +-
>  Documentation/git-rebase.txt              | 4 ++--
>  Documentation/git-revert.txt              | 2 +-
>  Documentation/gitcvs-migration.txt        | 2 +-
>  Documentation/technical/http-protocol.txt | 4 ++--
>  Documentation/user-manual.txt             | 4 ++--
>  7 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
> index e1fba85..2a18c1f 100644
> --- a/Documentation/everyday.txt
> +++ b/Documentation/everyday.txt
> @@ -304,7 +304,7 @@ and maintain access to the repository by developers.
>    * linkgit:git-shell[1] can be used as a 'restricted login shell'
>      for shared central repository users.
>  
> -link:howto/update-hook-example.txt[update hook howto] has a good
> +link:howto/update-hook-example.html[update hook howto] has a good
>  example of managing a shared central repository.
>  
>  
> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> index 7da0f13..b211440 100644
> --- a/Documentation/git-credential.txt
> +++ b/Documentation/git-credential.txt
> @@ -20,7 +20,7 @@ usernames and passwords. The git-credential command exposes this
>  interface to scripts which may want to retrieve, store, or prompt for
>  credentials in the same manner as Git. The design of this scriptable
>  interface models the internal C API; see
> -link:technical/api-credentials.txt[the Git credential API] for more
> +link:technical/api-credentials.html[the Git credential API] for more
>  background on the concepts.
>  
>  git-credential takes an "action" option on the command-line (one of
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6b2e1c8..94e07fd 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -322,7 +322,7 @@ You may find this (or --no-ff with an interactive rebase) helpful after
>  reverting a topic branch merge, as this option recreates the topic branch with
>  fresh commits so it can be remerged successfully without needing to "revert
>  the reversion" (see the
> -link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
> +link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
>  
>  --ignore-whitespace::
>  --whitespace=<option>::
> @@ -416,7 +416,7 @@ Without --interactive, this is a synonym for --force-rebase.
>  You may find this helpful after reverting a topic branch merge, as this option
>  recreates the topic branch with fresh commits so it can be remerged
>  successfully without needing to "revert the reversion" (see the
> -link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
> +link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
>  
>  include::merge-strategies.txt[]
>  
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index f79c9d8..2de67a5 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -59,7 +59,7 @@ brought in by the merge.  As a result, later merges will only bring in tree
>  changes introduced by commits that are not ancestors of the previously
>  reverted merge.  This may or may not be what you want.
>  +
> -See the link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for
> +See the link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for
>  more details.
>  
>  --no-edit::
> diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
> index 5ab5b07..5ea94cb 100644
> --- a/Documentation/gitcvs-migration.txt
> +++ b/Documentation/gitcvs-migration.txt
> @@ -157,7 +157,7 @@ points.  You can use these, for example, to send all commits to the shared
>  repository to a mailing list.  See linkgit:githooks[5].
>  
>  You can enforce finer grained permissions using update hooks.  See
> -link:howto/update-hook-example.txt[Controlling access to branches using
> +link:howto/update-hook-example.html[Controlling access to branches using
>  update hooks].
>  
>  Providing CVS Access to a Git Repository
> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> index a1173ee..caf941a 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -499,5 +499,5 @@ References
>  
>  link:http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
>  link:http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
> -link:technical/pack-protocol.txt
> -link:technical/protocol-capabilities.txt
> +link:technical/pack-protocol.html
> +link:technical/protocol-capabilities.html
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index fe723e4..ed01c98 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1977,7 +1977,7 @@ $ git clone http://yourserver.com/~you/proj.git
>  -------------------------------------------------
>  
>  (See also
> -link:howto/setup-git-server-over-http.txt[setup-git-server-over-http]
> +link:howto/setup-git-server-over-http.html[setup-git-server-over-http]
>  for a slightly more sophisticated setup using WebDAV which also
>  allows pushing over HTTP.)
>  
> @@ -3191,7 +3191,7 @@ those "loose" objects.
>  You can save space and make Git faster by moving these loose objects in
>  to a "pack file", which stores a group of objects in an efficient
>  compressed format; the details of how pack files are formatted can be
> -found in link:technical/pack-format.txt[technical/pack-format.txt].
> +found in link:technical/pack-format.html[pack format].
>  
>  To put the loose objects into a pack, just run git repack:
