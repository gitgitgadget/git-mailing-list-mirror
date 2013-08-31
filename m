From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] rebase: trivial style fixes
Date: Fri, 30 Aug 2013 20:49:27 -0700
Message-ID: <xmqqbo4ewmd4.fsf@gitster.dls.corp.google.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 05:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFcBr-0001FN-WC
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 05:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab3HaDtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 23:49:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091Ab3HaDtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 23:49:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97D3E33AC1;
	Sat, 31 Aug 2013 03:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FdUBspZQ9QrO4BJzRXeTK4a/+rU=; b=E3S4/O
	MdgekyOt6YyNIaDDeLTMWqhVWhNYmM8xytCntEA4w5odJSQBt87U8x5n0lvP7AYc
	edSBUDYnpQBEFqKB2a6/EqxSU1dD8tzkPV642hLEvHp/dfvj4B5YR2W4fL6Kmd4G
	aaGCumk8DfgTZ8gidPBOvhFy7/7/nELlyuY08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NuYc+P7Xb/7P1yA+0W1A8MyGYYfdARQq
	WQhvreSBs81nBSqTl37rgCLdOSiIOObuq4wYBWdCXoDaU/kH0UmfPwiWyjSxcKz/
	9VvtltBn/7ZBAVK6Zb8b+j/EJWp0/9HKqADxCCmuneXsVjlCmvlpYhf/9Ip2NgcH
	WZ1RMC+fxUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D44133AC0;
	Sat, 31 Aug 2013 03:49:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 059F933ABE;
	Sat, 31 Aug 2013 03:49:29 +0000 (UTC)
In-Reply-To: <1377899810-1818-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 16:56:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 56FA3F06-11F0-11E3-A0B2-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233496>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-rebase.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 8d7659a..2c02853 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -324,7 +324,7 @@ done
>  test $# -gt 2 && usage
>  
>  if test -n "$cmd" &&
> -   test "$interactive_rebase" != explicit
> +	test "$interactive_rebase" != explicit
>  then
>  	die "$(gettext "The --exec option must be used with the --interactive option")"
>  fi
> @@ -486,7 +486,7 @@ case "$#" in
>  	switch_to="$1"
>  
>  	if git show-ref --verify --quiet -- "refs/heads/$1" &&
> -	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
> +		orig_head=$(git rev-parse -q --verify "refs/heads/$1")
>  	then
>  		head_name="refs/heads/$1"
>  	elif orig_head=$(git rev-parse -q --verify "$1")

I am not sure about this change.  I do not personally have strong
preference on this, but it would be better to be consistent.

The style of the original we see above seems to be the one that is
consistently used in this file for conditionals that span multiple
lines.  That is, to align the beginning of subsequent lines with the
beginning of the conditional (i.e. the "g" in "git show-ref" on the
first line)---which happens to be in line with what we use in our C
sources, too.

I see there is one oddball in that file, though.

 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8d7659a..187793e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -422,7 +422,7 @@ then
 	case "$#" in
 	0)
 		if ! upstream_name=$(git rev-parse --symbolic-full-name \
-			--verify -q @{upstream} 2>/dev/null)
+		   --verify -q @{upstream} 2>/dev/null)
 		then
 			. git-parse-remote
 			error_on_missing_default_upstream "rebase" "rebase" \
