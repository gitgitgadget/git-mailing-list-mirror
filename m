From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sat, 20 Apr 2013 23:51:24 -0700
Message-ID: <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 08:51:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTo7l-0003Ef-67
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 08:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab3DUGv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 02:51:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab3DUGv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 02:51:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05ECA134F2;
	Sun, 21 Apr 2013 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SsNTSWeO3b5Nqb39gHMNQt9ZUQI=; b=lEHY9F
	aJKIxt7Ayczs5wWaXUmqo3DA3HSI//HOmRW76HCxF2UbrIksdJvcJEb6rV2L6TEH
	Lxiy2RZiSSfg72G5VxQ/hi0bpABShWO9vpmQgIbqbs2x1r8ZEhrEpHvhfcKR5OAg
	FXFqkngBmQcM5LpDL0C6teOFfKV494YINDd88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PQwnhRu8aqIxWpzDC3ZoqbM1Wb297tW2
	xHl+uPj/hukeFTdQuJz0GcPXd8KZzcjXYUAfcKbRj6OubjQxNMmJxJo4+w8uVH8j
	PkweYs9Xj11owVpiC5g3u62xL9ntlo79OACG9xDoUxT8F6gjfVCG+CB5r653FeOH
	cxUITN+p7R0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDD20134EE;
	Sun, 21 Apr 2013 06:51:26 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57D7E134E5;
	Sun, 21 Apr 2013 06:51:26 +0000 (UTC)
In-Reply-To: <1366458313-7186-5-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 20 Apr 2013 17:15:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E317F22A-AA4F-11E2-911D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221898>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In its current form, the note talks about separating options from
> "branch names" and "refnames" in the same sentence.  This is entirely
> inaccurate, as the rev spec need not be a set of branch names or ref
> names.  Rewrite it to use the word "revisions".
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-log.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index f03ae74..1a9c3ca 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -75,8 +75,8 @@ produced by --stat etc.
>  	Simplification" below for details and other simplification
>  	modes.
>  +
> -To prevent confusion with options and branch names, paths may need to
> -be prefixed with "\-- " to separate them from options or refnames.
> +Paths may need to be prefixed with "\-- " to separate them from
> +options or revisions, when confusion arises.

I think "branch names" was an attempt to make it more newbie
friendly by sacrificing technical accuracy.  With the suggested
update (see the review for the previous one), it would be easier to
read if this part said "options or the revision range".

Two other things I noticed with the current text are:

 * As the synopsis section shows, on the command line, --options
   come first, then revision range and then pathspec.  The order of
   the description should follow that as well.  The current text
   shows <since>..<until> at the very beginning, which is wrong.

 * The part with the new "-L" option seems to be throwing the
   overall formatting off.  Its second paragraph "<start> and <end>
   can take..." is not indented to the same level as its first
   paragraph "Trace the evolution of...", and the following items,
   like "--full-line-diff" and "[--] <pathspec>..." are indented one
   level too deeply.
