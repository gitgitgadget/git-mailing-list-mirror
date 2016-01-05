From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expand documentation describing --signoff
Date: Tue, 05 Jan 2016 15:02:07 -0800
Message-ID: <xmqqa8ojiqa8.fsf@gitster.mtv.corp.google.com>
References: <E1aGX9e-0002m1-55@rmm6prod02.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git" <git@vger.kernel.org>
To: "David A. Wheeler" <dwheeler@dwheeler.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 00:02:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGacN-0002bP-7T
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 00:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbcAEXCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 18:02:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751663AbcAEXCK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 18:02:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11DFB39291;
	Tue,  5 Jan 2016 18:02:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B/jiQRPqgz0/2GQvKRygQ9H0RiA=; b=TF77ns
	m8XjRx1H9v+iximu86WX81ar/c14FzsUCCYjpq4IPojgiS//2EB2sjE4uH9jZjNx
	bqjDf4Cz0ayJwzRqncJUTc31KhuE1iqfSSQcH76B8uSKNBB741kW/mNkKiPg3sYi
	vSX8BQ+XWir2vms3755Qp5k5A4wPtso7RnnKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OFa7u5nrvC6ScqX/qac2BwVqhnZNPdkn
	DZKpS9u0aIG8yo5kAfGM+qQt7QnSBEoqLqy3XSHI7PfjGicSAGz6DTAA+Ycea59f
	4vDA6qi8Y7bjLU1DXaUftMhBcOvl+KrGlMweWowVBt2QMX/R9RcW4p2Nm1aD1Pyv
	SfvxpRqZpaA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 095ED39290;
	Tue,  5 Jan 2016 18:02:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 76BDF3928E;
	Tue,  5 Jan 2016 18:02:08 -0500 (EST)
In-Reply-To: <E1aGX9e-0002m1-55@rmm6prod02.runbox.com> (David A. Wheeler's
	message of "Tue, 05 Jan 2016 14:20:26 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 58A725D0-B400-11E5-98EA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283407>

"David A. Wheeler" <dwheeler@dwheeler.com> writes:

> Modify various document (man page) files to explain
> in more detail what --signoff means.
>
> This was inspired by https://lwn.net/Articles/669976/ where
> paulj noted, "adding [the] '-s' argument to [a] git commit
> doesn't really mean you have even heard of the DCO...".
> Extending git's documentation will make it easier to argue
> that developers understood --signoff when they use it.
>
> Signed-off-by: David A. Wheeler <dwheeler@dwheeler.com>
> ---

Looks sensible, striking the balance between the need by the
projects that do adopt DCO to be specific, and the need by the
others to allow other uses of "-s".

Will queue; thanks.


>  Documentation/git-am.txt           | 1 +
>  Documentation/git-cherry-pick.txt  | 1 +
>  Documentation/git-commit.txt       | 6 +++++-
>  Documentation/git-format-patch.txt | 1 +
>  Documentation/git-revert.txt       | 1 +
>  5 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 452c1fe..13cdd7f 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -35,6 +35,7 @@ OPTIONS
>  --signoff::
>  	Add a `Signed-off-by:` line to the commit message, using
>  	the committer identity of yourself.
> +	See the signoff option in linkgit:git-commit[1] for more information.
>  
>  -k::
>  --keep::
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 77da29a..6154e57 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -100,6 +100,7 @@ effect to your index in a row.
>  -s::
>  --signoff::
>  	Add Signed-off-by line at the end of the commit message.
> +	See the signoff option in linkgit:git-commit[1] for more information.
>  
>  -S[<keyid>]::
>  --gpg-sign[=<keyid>]::
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 7f34a5b..9ec6b3c 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -154,7 +154,11 @@ OPTIONS
>  -s::
>  --signoff::
>  	Add Signed-off-by line by the committer at the end of the commit
> -	log message.
> +	log message.  The meaning of a signoff depends on the project,
> +	but it typically certifies that committer has
> +	the rights to submit this work under the same license and
> +	agrees to a Developer Certificate of Origin
> +	(see http://developercertificate.org/ for more information).
>  
>  -n::
>  --no-verify::
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index e3cdaeb..b149e09 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -109,6 +109,7 @@ include::diff-options.txt[]
>  --signoff::
>  	Add `Signed-off-by:` line to the commit message, using
>  	the committer identity of yourself.
> +	See the signoff option in linkgit:git-commit[1] for more information.
>  
>  --stdout::
>  	Print all commits to the standard output in mbox format,
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index b15139f..573616a 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -89,6 +89,7 @@ effect to your index in a row.
>  -s::
>  --signoff::
>  	Add Signed-off-by line at the end of the commit message.
> +	See the signoff option in linkgit:git-commit[1] for more information.
>  
>  --strategy=<strategy>::
>  	Use the given merge strategy.  Should only be used once.
