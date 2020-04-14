Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B36CC2BA2B
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 01:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E7F206B6
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 01:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cp61k1RS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbgDNBGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 21:06:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37062 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728387AbgDNBGi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 21:06:38 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4FFBF6042C;
        Tue, 14 Apr 2020 01:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586826366;
        bh=Dt0kiubq6eRYNkeJoWyraiG5IENhRQmFlNNgCRsjsLs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cp61k1RSHz+sXjCcUKktawo8JQF+vSUUROx8yKMzvAkvZ2HLMu2dLmY2qZtU4D+cJ
         yt5EUuyJeAkesQhyfHhdrRZx2zxID81qPMFtsmUKwTUXafEjQ19QBsM6F19GSoyLmT
         ohxPBu5N2eaCs9aRl69G3BNRUIkN9zrlhA23n/zbvmJS6jnnAKIEqJmH8lK47wIiJU
         8HiAd1K2tGRl1vkS+0IvAW3HiJO3mILS6NWwwKQY79LZvvyGQaDhv9F7CipwJIvEx/
         aW788Tl8ytN2mBfBz3LW2maEeG7FLJTwvIfNtjM43eGSNFuiOFysdxelpAATurjObj
         YBkguTxCPaCZyQTg+bCIbyMnVBO38Ii5ze2obOcswScFegs3j/t8eYxfFJcJuJc616
         O4Rdp7lRsocHaMwLQFdK7TExh1S8tTF0Har6yJ1rTsV+xH/J/OOQmF04TX+/Ri05TG
         YDYIuc/Hc2wtTFGDXZ6SAkJtpIr97IHtXoUrgM9gn2xbPhaYaQc
Date:   Tue, 14 Apr 2020 01:06:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com,
        martin.agren@gmail.com
Subject: Re: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
Message-ID: <20200414010601.GB2751707@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, emilyshaffer@google.com, martin.agren@gmail.com
References: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
 <20200413140918.4778-2-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20200413140918.4778-2-shouryashukla.oo@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-13 at 14:09:18, Shourya Shukla wrote:
> +[[rebasing-and-merging]]
> +How do I know when to merge or rebase?::
> +	Rebasing and merging two entirely different concepts with different uti=
ilites.
> +	In Git terms, rebasing means to place changes made in one branch over a=
nother branch
> +	(called base, hence the term, rebase). The commit history of the branch=
 wanting to rebase
> +	get placed over the branch on the receiving end and it appears as if th=
ose changes took
> +	place in the receiving branch itself. Merging, as the name suggests, me=
rges the latest
> +	commit of one branch onto the recent branch, making this combination ap=
pear as one separate
> +	commit.
> ++
> +Now that we have an idea of the key differences between merging and reba=
sing, we can look at the
> +circumstances when we would want to perform them. Generally, merging is =
preferred when one desires
> +to create a new feature, perform its integration testing with the origin=
al codebase, and finally
> +integrate it if all tests are passed. One would choose to create a separ=
ate branch for this purpose
> +and maybe dissolve it when the merge is done.
> ++
> +One might want to perform a rebase when they intend to retain the change=
s made in a separate branch
> +into their original branch. In that case, a rebase would place the forme=
r changes onto the commit tree
> +of the latter.
> ++
> +As an additional tip, one can use interactive rebasing, `git rebase -i`,=
 to perform rebasing
> +using a text editor GUI (the value of $GIT_EDITOR). Interactive rebase i=
s an excellent utility
> +to perform various functions such as editing commit messages, dropping/s=
quashing commits, editing
> +commits, etc., all in one package.

I like the way you've clearly delineated the two typical use cases.  As
we know, some people have more other, different workflows, but I think
you've given the right amount of detail here.

Maybe we should recommend a link to git-rebase(1) to let folks read up
on interactive rebase if they're interested in learning more.

> +[[files-in-.gitignore-are-tracked]]
> +I asked Git to ignore various files, yet they show up as changes in my s=
taging area::
> +	One uses '.gitignore' to ignore files from getting tracked in the worki=
ng tree. This ignores
> +	the aforementioned files for the whole lifetime of the project unless t=
hey area removed from
> +	the '.gitignore'. Consequently, `git add` does not list these files as =
'modified' even if any
> +	change was made in them and `git status` does not bother to track the c=
hanges in these files
> +	either.
> +
> +	But, '.gitignore' will only ignore the files which were not a part of t=
he repository when they
> +	were mentioned in the it. Hence, addition of a file to '.gitignore' aft=
er it was added to the
> +	working tree will have no effect and Git will keep tracking them. To am=
end this mistake, i.e.,
> +	to untrack and completely ignore a tracked file, one has to use `git rm=
 --cached <file>` to
> +	remove the file from the staging area(i.e. the cache) and not from the =
repository(presuming
> +	the file has been added in the 'gitignore'). This will hence make our f=
ile behave exactly like
> +	we described in the paragraph above.

I think we want to put a space before these two parentheticals, and I
believe it's customary to put a comma after "i.e." or "e.g.".  There are
some other cases below where I saw these two items as well.

> +[[changing-remote-of-the-repository]]
> +I want to change the remote of my repository. How do I do that?::
> +	A remote is an identifier for a location to which Git pushes your chang=
es as well as fetches
> +	any new changes(if any). There might be different circumstances in whic=
h one might need to change
> +	the remote:
> +
> +		1. One might want to update the url of their remote; in that case, the=
 command to use is,
> +		   `git remote set-url <name> <newurl>`.

I suspect we may have some users who don't know what name they should
use.  Should we maybe suggest using "git remote -v" somewhere here to
list the remotes and their existing URLs?  As an alternative, we could
mention that "origin" is the name of the default remote.

Also, I think we want to capitalize "URL" when we write it in prose.

> +		2. One might want to have two different remotes for fetching and pushi=
ng; this generally
> +		   happens in case of triangular workflows. In this case, it is advisa=
ble to create a
> +		   separate remote just for fetching/pushing. But, another way can be =
to change the push
> +		   url using the `--push` option in the `git set-url` command.
> +
> +[[fetching-and-pulling]]
> +How do I know if I want to do a fetch or a pull?::
> +	A fetch brings in the latest changes made upstream(i.e. the remote repo=
sitory we are working on).
> +	This allows us to inspect the changes made upstream and integrate all t=
hose changes(iff we want to)
> +	or only cherry pick certain changes. Fetching does not have any immedia=
te effects on the local
> +	repository.

Many of us are familiar with "iff", but it is a bit confusing to folks
without a mathematical background or people who aren't native English
speakers, and so it might be better to avoid it in documentation
targeted to newer users.

Can we also maybe add a sentence to explain how one accesses the
changes?  For example, if one has done "git fetch origin", maybe we
should say that the branch master on that remote can be viewed with
"origin/master".

> +	A pull is a wrapper for a fetch and merge. This means that doing a `git=
 pull` will not only fetch the
> +	changes made upstream but integrate them as well with our local reposit=
ory. The merge may go smoothly
> +	or have merge conflicts depending on the case. A pull does not allow yo=
u to review any changes made
> +	upstream but rather merge those changes on their own.
> ++
> +This is the reason why it is sometimes advised to fetch the changes firs=
t and then merge them accordingly
> +because not every change might be of utility to the user.
> +
> +[[checking-out]]
> +What is checking out a commit/branch? How do I perform one?::
> +	In Git terminology, a 'checkout' serves three purposes, namely:
> +
> +		1. Go to another commit; I would be "checking out" to that commit and =
enter a "detached HEAD"
> +		   state, meaning, that the "pointer" called HEAD which tells me where=
 I am right now in my
> +		   working tree is not where it generally should be, i.e., referring t=
o a named branch(say, master).
> +		   Instead the aforementioned pointer is referring to the specified co=
mmit. I can now work upon the
> +		   checked out commit and make any changes or just inspect the files a=
t that state.
> +
> +		2. Go to a different version of a particular file; let's say I want to=
 go to a particular version
> +		   of a file in my working tree. I can again "checkout" to that partic=
ular version(i.e., going to a
> +		   particular commit where certain changes were made). This can be don=
e by entering the SHA1 of the
> +		   commit in question.
> +
> +		3. Go to another branch or create another branch; I would be "checking=
 out" to another tree
> +		   in my local repository. One might expect to enter a detached HEAD h=
ere as well but in fact
> +		   does not. This is because HEAD would point to the tip of the checke=
d out branch, something
> +		   which is not a characteristic of a detached HEAD.

Let's phrase this so that the common case (that is, checking out a
branch) is first (both here and below).  That way, the user can say,
"Yes, that's exactly what I want to do," and skip the rest.  It's good
to mention the other parts, but there are some users who are so new that
they're not to the point of the other features, and we can help them by
letting them skip over the things they don't yet understand.

Also, it looks like there may be some trailing whitespace above (which
I've trimmed in my message).

> ++
> +To checkout to a commit, one can either pass the SHA1 of the commit to b=
e checked out or a reference to it w.r.t.
> +the HEAD. To checkout to a particular version of a file, one can use `gi=
t checkout <SHA1/reference> <file>`.
> +To checkout to an already existing branch, one should use `git checkout =
<branch-name>`. To simultaneously create
> +and checkout to a branch, one can use the `-b` option in the aforementio=
ned command.
> +One can observe how versatile the checkout command is, yet due to simpli=
fy things even further, two commands were
> +introduced in version 2.23 of Git so as to break down the functionalitie=
s of `git checkout` and make it learning
> +the command easier for a beginner. The commands being `git switch` and `=
git restore`.

Let's prefer spelling out "with regard to" (or "with respect to") for
those who aren't native speakers of English.  "i.e." and "e.g." are
extraordinarily common and are probably understandable, but my
experience as a non-native speaker of Spanish and French is that
abbreviations are tricky if you're not completely fluent, and "w.r.t."
isn't that common in most prose.

Maybe we also want to use a term other than "SHA1", such as "object ID"
or "hash", seeing as work is ongoing to add a new hash function.

> +`git restore` combines the first two features of the checkout as well as=
 functionalities of `git reset` and `git revert`
> +at one place so as to improve the functionality of the command.
> ++
> +`git switch` perfoms the third functionality of the `git checkout` comma=
nd, i.e., manipulating branches(creation).

I wonder if we should prefer teaching "git switch" and "git restore"
over the more complex features of "git checkout", and mention the
variants of "git checkout" as a backup for those using older versions of
Git.  While I don't use them personally, the feedback I've received from
others is that they are much easier to use and reason about than git
checkout.

Overall, let me say that I'm pretty happy with the way this is coming
together and I appreciate you coming up with this series.  I'm sorry I
didn't have more time to look over this earlier before v2.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXpUMeQAKCRB8DEliiIei
gQbpAQDGnnMWCoZUsajc1e0jHRpqasgZbxN00aO7h0YLD+7ruwEA89y02vD9nl21
DIYBDeqr59Br+A+iGgBDjL8H7WwogAw=
=gihR
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
