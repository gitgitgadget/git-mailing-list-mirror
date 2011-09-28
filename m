From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Docs: git checkout --orphan: `root commit' and
 `branch head'
Date: Wed, 28 Sep 2011 13:34:22 -0700
Message-ID: <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
References: <1316960136073-6829212.post@n2.nabble.com>
 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr>
 <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr>
 <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 22:34:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R90ps-00044q-Hj
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 22:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab1I1Ue1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 16:34:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732Ab1I1Ue0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 16:34:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C22AC67D7;
	Wed, 28 Sep 2011 16:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sarekbEDaQw1
	MBoRHpu/lQjmFL4=; b=DpVH7x7FSLgHh7ETBHTCnFzg0jug8V24ROTB6YLG3m2e
	JV8Vmu82/uH3pfE4OEVt0qlpBOeMD3sCuUxUf5RTW1huBtvL8GYVAznPc0Wd20Iw
	D81EH4i8DoEzi1/nf9JC5i7/RrCaWBjXULtjQzlGuWEfgjAQd0Ci12tv9ZDAypU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S7MEda
	BwLYnDRdczawp99bATDwi6IpHF/bFvI1rGvXLf34fResbEaQyCVX13XTUaywPthT
	eiswAsw8oj2PnYUDGy+wPfcciw1CWCGuFmXUR1H6aGM3Lr6qmkFgTV4mRHCYwR++
	N/ILpgLPx83E/m94Qh1iDhTkMW2FQuxreB37I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B80CC67D6;
	Wed, 28 Sep 2011 16:34:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0436267D4; Wed, 28 Sep 2011
 16:34:24 -0400 (EDT)
In-Reply-To: <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> (Michael
 Witten's message of "Wed, 28 Sep 2011 16:23:00 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 413805DA-EA11-11E0-B34F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182365>

Michael Witten <mfwitten@gmail.com> writes:

> See:
>
>   Re: Can a git changeset be created with no parent
>   Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>   Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
>   http://article.gmane.org/gmane.comp.version-control.git/182170
>
> and:
>
>   git help glossary

I think I had to tell somebody on this list not to do this no more than=
 a
month ago.

It is a good practice to point to earlier discussions while polishing
patch, and it also is good to include pointers in the commit log messag=
e
as a _supporting material_ (additional reading), but that is *NOT* a
substitute for a properly written commit log message. You need to state
what problem you are trying to fix and how the proposed patch fixes it.

Pretty please.

As to what the updated text wants to talk about, I think most of them a=
re
improvement, but there are a few glitches and nits.

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index c0a96e6..0b6e528 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -125,29 +125,54 @@ explicitly give a name with '-b' in such a case=
=2E
>  	below for details.
> =20
> ---orphan::
> -	Create a new 'orphan' branch, named <new_branch>, started from
> -	<start_point> and switch to it.  The first commit made on this
> -	new branch will have no parents and it will be the root of a new
> -	history totally disconnected from all the other branches and
> -	commits.
> -+
> -The index and the working tree are adjusted as if you had previously=
 run
> -"git checkout <start_point>".  This allows you to start a new histor=
y
> -that records a set of paths similar to <start_point> by easily runni=
ng
> -"git commit -a" to make the root commit.
> -+
> -This can be useful when you want to publish the tree from a commit
> -without exposing its full history. You might want to do this to publ=
ish
> -an open source branch of a project whose current tree is "clean", bu=
t
> -whose full history contains proprietary or otherwise encumbered bits=
 of
> -code.
> -+
> -If you want to start a disconnected history that records a set of pa=
ths
> -that is totally different from the one of <start_point>, then you sh=
ould
> -clear the index and the working tree right after creating the orphan
> -branch by running "git rm -rf ." from the top level of the working t=
ree.
> -Afterwards you will be ready to prepare your new files, repopulating=
 the
> -working tree, by copying them from elsewhere, extracting a tarball, =
etc.
> +--orphan::
> +	Tell git to turn the next commit you create into a root commit
> +	(that is, a commit without any parent); creating the next commit
> +	is similar to creating the first commit after running "git{nbsp}ini=
t",

I do not think we ever used {nbsp} in our documentation set. Is it
absolutely necessary to use it in this context, and are you absolutely
sure this does not break various versions of documentation toolchain
people have?

> +	except that the new commit will be referenced by the branch head
> +	<new_branch> rather than "master".

The option works as a substitute for -B/-b in the sense that it takes a
name of the new branch, and the only difference is that the new branch
will start with no commit (yet).  To reduce confusion, it might make se=
nse
to update this part (and description of -b/-B) to begin like this:

	--orphan <new_branch>::

to match the new explanation text, and the output from "git checkout -h=
".
By the way, shouldn't the entry for -b in "git checkout -h" output also
say <new branch>?

Micronit: "referenced by the branch head <new_branch>" might be easier =
to
read and understand with s/branch head/branch name/. Or perhaps

	except that the new commit will be made on <new_branch> branch
        rather than "master".

might be even better.

> ++
> +Furthermore, the working tree and index are adjusted as if you ran
> +"git{nbsp}checkout{nbsp}<start_point>"; thus, by just running
> +"git{nbsp}commit", you can create a root commit with a tree that is
> +exactly the same as the tree of <start_point>.
> ++
> +Naturally, before creating the commit, you may manipulate the index
> +in any way you want. ...

What value does "Naturally, " add to the understanding here? I would
understand if it were "Alternatively, ", though.

> +... For example, if you want to create a root commit
> +with a tree that is totally different from the tree of <start_point>=
,
> +then just clear the working tree and index first: From the top level
> +of the working tree, run "git{nbsp}rm{nbsp}-rf{nbsp}.", and then
> +prepare your new working tree and index as desired.
> ++
> +There are two common uses for this option:
> ++
> +--
> +	Separate history::
> +		Suppose that for convenience, you want to maintain
> +		the website for your project in the same repository
> +		as the project itself. In such a case, it may not
> +		make much sense to interleave the history of the
> +		website with the history of the project; you can use
> +		the "--orphan" option in order to create these two
> +		completely separate histories.

I suspect this is *not* common at all, and also because you would need =
a
working tree to update both lines of histories that are not related to
each other at all at the content level, I do not believe that "for
convenience" supports or justifies the use case at all. It would be les=
s
convenient to update these two unrelated histories (switching between
branches would need to nuke the whole working tree, and the semantics t=
o
carry local changes floating on top of the tip commit of the current
branch across branch switching actively works against you).

You would be better off using another repository to keep track of "the
website for your project".

In short, I do not think we would want to list the above as if we are
somehow encouraging the use of this option for such a use. It falls int=
o
"because with --orphan you _could_", and definitely not "because having
these two unrelated projects in the same repository you work in is
convenient and/or necessary".

> +	Hidden history::
> +		Suppose you have a project that has proprietary
> +		material that is never meant to be released to the
> +		public, yet you now want to maintain an open source
> +		history that may be published widely.

This cause does make sense; you would want the local changes floating o=
n
top of the tip commit of the current branch carried across branch
switching.

> +In this case, it would not be enough just to remove the proprietary
> +material from the working tree and then create a new commit, because
> +the proprietary material would still be accessible through the new
> +commit's ancestry; the proprietary history must be hidden from the n=
ew
> +commit, and the "--orphan" option allows you to do so by ensuring th=
at
> +the new commit has no parent.

Does this "In this case" paragraph format as part of the "Hidden histor=
y"
paragraph?

> ++
> +However, removing proprietary material from ancestry is usually a ta=
sk
> +that is better performed by linkgit:git-filter-branch[1] and
> +linkgit:git-rebase[1], especially when there are multiple commits th=
at
> +are already suitable for the open source history.
> +--

In general it is true, and not "especially". When you are just abandoni=
ng
the history and publishing tidied up tree without history afresh.

I suspect this is not exactly "filter-branch is better but you could us=
e
checkout --orphan" like you made it sound in the above paragraph.  If y=
ou
are bootstrapping a new open source project from the tip of a proprieta=
ry
tree, "checkout --orphan && edit to sanitize && commit" to start your
history afresh would be perfectly adequate for your PR people to say "N=
ow
we are open", especially when you do not intend to accept fixes to olde=
r
revisions; you could filter-branch the older proprietary history but yo=
u
would not get much benefit out of the cost for doing so, I think.

Thanks.
