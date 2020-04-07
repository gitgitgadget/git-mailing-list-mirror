Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D101CC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 01:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13352076E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 01:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vIS0vsSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDGBsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:48:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51640 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgDGBsg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Apr 2020 21:48:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB2BC6052F;
        Tue,  7 Apr 2020 01:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586224114;
        bh=BwUQEJtGGNFsXemEzELsUQGhEX7Cy/MrLF5mtyOGzGE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vIS0vsSBAWhY6tfvfQ4cvUW5kngp9dBihylJ60Tpu6aARQ+yHNUUG1RxjXFSLlsHv
         Fc0e3WQA8bQcDdEai/csUA4mfj6cEyKoUVWG4yLogHwKftqxUkykfPKqIzK8mesHdv
         u4lL58g59Y/+yczpvf+4IuijghtoYDDL8CYxi85R5BVU7zgBd5gl1zZ4LI2GbnVINd
         8Z3IDLtLB1XKzNeDuZpEJ1Zf+S+TeeafBOYwGYSNxEeNM0KJ8UQMySSKwM8fL7BXmz
         X/bhfIvZrQqvabtOp1b7IwpwdPj7w74JrvAEhn7LDjA4q0sDdkK1TmETKeV01NK5Nq
         JIx9kpKLfdBS5Z+pa44UVNs2zW4w4p/gXbRXJMn187j5PxbebaMT6+sueVfgyKJg5s
         IcF8Ix7HJIc7anKC6u78eNmz+Yj2FNBys7EBvkJi2zUkS3vUQOVBZtgUJU9scB+HpF
         BueRcB15AUOJrj/o44ZCAZbRFgvhCodCOXEdZbyjzLrvjHmiliy
Date:   Tue, 7 Apr 2020 01:48:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
Message-ID: <20200407014829.GL6369@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
 <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z1OTrj3C7qypP14j"
Content-Disposition: inline
In-Reply-To: <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Z1OTrj3C7qypP14j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-04 at 00:16:21, Derrick Stolee wrote:
> On 4/3/2020 5:40 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >=20
> >>  * git run-job <job-name>: This builtin will run a single instance of a
> >>    maintenance job.
> >>=20
> >>  * git job-runner [--repo=3D<path>]: This builtin will run an infinite=
 loop
> >>    that executes git run-job as a subcommand.
> >=20
> > What does this have to do with "git", though?  IOW, why does this
> > have to be part of Git, so that those who would benefit from having
> > a mechanism that makes it easy to run regular maintenance tasks but
> > are not Git users (or those that want to do such maintenance tasks
> > that are not necessarily tied to "git") must use "git" to do so?
> >=20
> > I'll find out later why it is so after reading thru 15 patches
> > myself, so no need to give a quick answer to the above; it was just
> > my knee-jerk reaction.
>=20
> That's a reasonable reaction. The short version of my reasoning is that
> many many people _use_ Git but are not Git experts. While a Git expert
> could find the right set of commands to run and at what frequency to
> keep their repo clean, most users do not want to spend time learning
> these commands. It's also worth our time as contributors to select what
> a good set of non-intrusive maintenance tasks could be, and make them
> easily accessible to users.
>=20
> This series gets us half of the way there: a user interested in doing
> background maintenance could figure out how to launch "git run-job" on
> a schedule for their platform, or to launch "git job-runner" at start-
> up. That's a lot simpler than learning how the commit-graph,
> multi-pack-index, prune-packed, pack-objects, and fetch builtins work
> with the complicated sets of arguments.

If there are periodic tasks that should be done, even if only on large
repos, then let's have a git gc --periodic that does them.  I'm not sure
that fetch should be in that set, but nothing prevents users from doing
"git fetch origin && git gc --periodic".  Let's make it as simple and
straightforward as possible.

As for handling multiple repositories, the tool to do that could be as
simple as a shell script which reads from ~/.config/git/repo-maintenance
(or whatever) and runs the same command on all of the repos it finds
there, possibly with a subcommand to add and remove repos.

> The second half would be to create a command such as
>=20
> 	git please-run-maintenance-on-this-repo
>=20
> that initializes the background jobs and enables them on the repo they
> are using. This allows the most casual of Git user to work efficiently
> on very large repositories.

I'm not opposed to seeing a tool that can schedule periodic maintenance
jobs, perhaps in contrib, depending on whether other people think it
should go.  However, I think running periodic jobs is best handled on
Unix with cron or anacron and not a custom tool or a command in Git.

I've dealt with systems that implemented periodic tasks without using
the existing tools for doing that, and I've found that usually that's a
mistake.  Despite seeming straightforward, there are a lot of tricky
edge cases to deal with and it's easy to get wrong.

We also don't have to reimplement all the features in the system
scheduler and can let expert users use a different tool of their choice
instead if cron (or the Windows equivalent) is not to their liking.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Z1OTrj3C7qypP14j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXovb7AAKCRB8DEliiIei
gQm5AQDAaUos0rSxuNSfIRnRBfszo/WtHwQeFFnV0EWADVx5DgEAhINYDkYW/3n9
3KoNkrQxpOx8/82/JqIUKiFnTbzPEQU=
=f+Oy
-----END PGP SIGNATURE-----

--Z1OTrj3C7qypP14j--
