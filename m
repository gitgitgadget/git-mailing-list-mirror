From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 23 Jun 2008 14:15:02 +0200
Message-ID: <20080623121502.GQ29404@genesis.frugalware.org>
References: <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkjwd73s3gPBwfc8"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 14:16:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAky3-0000YP-K6
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 14:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbYFWMPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 08:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbYFWMPK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 08:15:10 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50386 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbYFWMPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 08:15:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 849891B2571;
	Mon, 23 Jun 2008 14:15:07 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5DE4344697;
	Mon, 23 Jun 2008 13:50:45 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 006161190AD9; Mon, 23 Jun 2008 14:15:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85855>


--xkjwd73s3gPBwfc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 23, 2008 at 12:15:35AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> * mv/merge-in-c (Sat Jun 21 19:15:35 2008 +0200) 14 commits
>  - Add new test case to ensure git-merge reduces octopus parents when
>    possible
>  - Add new test case to ensure git-merge filters for independent
>    parents
>  - Build in merge
>  - Introduce reduce_heads()
>  - Introduce get_merge_bases_many()
>  - Add new test to ensure git-merge handles more than 25 refs.
>  - Introduce get_octopus_merge_bases() in commit.c
>  - git-fmt-merge-msg: make it usable from other builtins
>  - Move read_cache_unmerged() to read-cache.c
>  - parseopt: add a new PARSE_OPT_ARGV0_IS_AN_OPTION option
>  - Add new test to ensure git-merge handles pull.twohead and
>    pull.octopus
>  - Move parse-options's skip_prefix() to git-compat-util.h
>  - Move commit_list_count() to commit.c
>  - Move split_cmdline() to alias.c

"Add new test case to ensure git-merge reduces octopus parents when
possible" does exactly the same as "Add new test case to ensure
git-merge filters for independent parents", so I think you should drop
the later. Only the name of the test and the commit message differs, and
I think we want to avoid redundancy in the testsuite. ;-)

--xkjwd73s3gPBwfc8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhfk8YACgkQe81tAgORUJYjPQCgl/vl3OBUY9kNa50a+hdvHCNg
7RkAoIE9jCCVPBncLIKvzgLPpWi7TG5c
=xQAN
-----END PGP SIGNATURE-----

--xkjwd73s3gPBwfc8--
