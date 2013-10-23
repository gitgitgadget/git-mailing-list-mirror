From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/15] api-remote.txt: correct section "struct refspect"
Date: Wed, 23 Oct 2013 11:43:18 -0700
Message-ID: <xmqq1u3brfp5.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 23 20:43:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ3P8-0005kf-LB
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 20:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab3JWSnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 14:43:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3JWSnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 14:43:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD0054DC30;
	Wed, 23 Oct 2013 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HcvVwhamKQc71TdDMArojsviqas=; b=Y/Q4Ff
	x20tMMKa4QVh4CyQlzwMYe1kJuX8Wmgmy35v/DH8ZDtAE7YpesoUgtnHgeDfWfTN
	BfdWMsPGKWJhP4/crYB/TDwj47eLW6jcrK5CD+XYHJFpc2GM+OKYRvlg5KEYDizp
	A0YAAxx/OoZit3w/p+u/ZtH0DD7w8/Fkux7Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ybvQYhENsKGGcTvYMGb/HU4NzmPpgtZy
	mI4V1HhwSNhLa46xe+aVXm25qYT6aauBLYpKWKKxM5Y7f+H5PETSofiFCclO40US
	9PlkwxhTC2b8kG17PCr/BgygP4oLWmRhYWNJIHLFucdyI+2naCd+8wKT6X9MVq9b
	Q3qGvaadlWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF1C24DC2E;
	Wed, 23 Oct 2013 18:43:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 139FD4DC2C;
	Wed, 23 Oct 2013 18:43:20 +0000 (UTC)
In-Reply-To: <1382543448-2586-5-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 23 Oct 2013 17:50:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FCEC0B8C-3C12-11E3-89A6-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236545>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> Subject: Re: [PATCH 04/15] api-remote.txt: correct section "struct refspect"

refspect???

> * Replace reference to function parse_ref_spec() with references to
>   functions parse_fetch_refspec() and parse_push_refspec().
>
> * Correct description of src and dst: they *do* include the '*'
>   characters.

 * Replace a single SP after a full-stop at the end of sentence with
   double SP as if we were back in the typewriter age.

The last one made it hard to spot what actually got changed,
though.  The updated text otherwise looks correct.

Thanks.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/technical/api-remote.txt | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/technical/api-remote.txt b/Documentation/technical/api-remote.txt
> index 4be8776..5d245aa 100644
> --- a/Documentation/technical/api-remote.txt
> +++ b/Documentation/technical/api-remote.txt
> @@ -58,16 +58,16 @@ default remote, given the current branch and configuration.
>  struct refspec
>  --------------
>  
> -A struct refspec holds the parsed interpretation of a refspec. If it
> -will force updates (starts with a '+'), force is true. If it is a
> -pattern (sides end with '*') pattern is true. src and dest are the two
> -sides (if a pattern, only the part outside of the wildcards); if there
> -is only one side, it is src, and dst is NULL; if sides exist but are
> -empty (i.e., the refspec either starts or ends with ':'), the
> -corresponding side is "".
> -
> -This parsing can be done to an array of strings to give an array of
> -struct refpsecs with parse_ref_spec().
> +A struct refspec holds the parsed interpretation of a refspec.  If it
> +will force updates (starts with a '+'), force is true.  If it is a
> +pattern (sides end with '*') pattern is true.  src and dest are the
> +two sides (including '*' characters if present); if there is only one
> +side, it is src, and dst is NULL; if sides exist but are empty (i.e.,
> +the refspec either starts or ends with ':'), the corresponding side is
> +"".
> +
> +An array of strings can be parsed into an array of struct refspecs
> +using parse_fetch_refspec() or parse_push_refspec().
>  
>  remote_find_tracking(), given a remote and a struct refspec with
>  either src or dst filled out, will fill out the other such that the
