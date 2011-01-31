From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/branch: briefly explain what a branch
 is
Date: Sun, 30 Jan 2011 18:51:11 -0800
Message-ID: <7v4o8pbxb4.fsf@alter.siamese.dyndns.org>
References: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
 <20110130160556.GI5713@localhost.localdomain>
 <20110130213258.GA10039@burratino> <20110130213510.GC10039@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	=?utf-8?Q?Jo=C3=A3o?= Paulo Melo de Sampaio 
	<jpmelos@gmail.com>, GIT Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 03:51:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjjra-000476-EY
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 03:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128Ab1AaCv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 21:51:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1AaCv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 21:51:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 552CA42C3;
	Sun, 30 Jan 2011 21:52:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VcaEoq6A4OF6TbeSdk3HwQNYFKM=; b=CIOxok
	ig7yPgK5taaA/520AqU8ssyJ9PMIu6keEAHqJdoyAqH65Pc1av+ph4g8nd/7UQp4
	sUbgVA5kOim5nfJgEEv2veAUqE4YVdtWCT6avdCtp59dghlT3nZ9I1cGwwxwEA6V
	NfJh2swUid6cLzST7sVpli6Rth6qdk7PG+LBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kCYmvFRIDHBPvOe/m4R21KA3SipHhsTT
	kkVZEOoIYdhdFSrOeZoaOtcwN8nzqJ+p+VQoPGpMGg/+aKpBe1YzKooOV8o21liV
	mTxFbZuuQ7Hcmv1js/TYlsGpG0cWQ4JlW2//4ggMChE/wo0UmBSA3YBlNhmZVMzC
	24ff1QCQNqM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF10342C2;
	Sun, 30 Jan 2011 21:52:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3032742BB; Sun, 30 Jan 2011
 21:52:04 -0500 (EST)
In-Reply-To: <20110130213510.GC10039@burratino> (Jonathan Nieder's message of
 "Sun\, 30 Jan 2011 15\:35\:10 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A2D068C-2CE5-11E0-A6A4-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165716>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The new reader might not know what git refs are, that history is a
> graph, the distinction between local, remote-tracking, and remote
> branches, or how to visualize what is going on.  After this change,
> those things are still probably not evident but at least there is an
> early reminder of some of it.
>
> Also explain how to create a branch before explaining how to list
> them.  Based roughly on the description of v0.99.1~53 (Add "git
> branch" script, 2005-07-11).
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/git-branch.txt |   35 ++++++++++++++++++++---------------
>  1 files changed, 20 insertions(+), 15 deletions(-)

I think these two are good readability changes.  Just a few nits though.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index d3eeb94..abad7ba 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -18,6 +18,26 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  
> +Branches are references to commit objects, representing the tip of a
> +line of history.  The branch you are working on is referred to
> +by HEAD and the corresponding reference is updated each time
> +linkgit:git-commit[1] or linkgit:git-merge[1] makes a new commit.

I think "makes a new commit" is a somewhat misleading thing to say (think
"fast forward" or "rebase that makes more than one").  The important point
is "advances your history", isn't it?  How about...

	... reference is updated with various operations that advance your
	history, e.g. linkgit:git-commit[1], linkgit:git-pull[1], etc.

Obviously we do not want to be exhausitve, so I tried to reword the above
in a way that makes it explicit that we are not trying to be.

> +'git branch' <branchname> [<start-point>]::
> +	Creates a new branch named `<branchname>`.
> +	If a starting point is specified, that will be where the branch
> +	is created; otherwise, the new branch points to the `HEAD` commit.
> ++
> +This will create a new branch, but it does not switch the working tree
> +to it.  Use "git checkout <newbranch>" to start working on the new branch.

I do not think we define what _switch_ means to explain "it does not
switch the working tree to it" anywhere in the glossary.

The operation not only "does not switcfh the working tree", but also does
not do anything to HEAD.  You and I know that, but a new reader might not,
and especially after hearing that "branch ... is referred to by HEAD",
might get a wrong impression that branch creation may do something to HEAD.

Perhaps...

	This only creates a new branch; you are still on the same branch
	you were on before.  If you want to start working on the new
	branch, say "git checkout <newbranch>".

might be less confusing (we might also want to hint "checkout -b").

Thanks.
