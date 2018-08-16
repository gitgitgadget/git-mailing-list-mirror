Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FD91F404
	for <e@80x24.org>; Thu, 16 Aug 2018 14:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbeHPRCZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 13:02:25 -0400
Received: from mout.web.de ([217.72.192.78]:39913 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbeHPRCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 13:02:25 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRUFI-1fSDV42ZWi-00SbnK; Thu, 16
 Aug 2018 16:03:14 +0200
Date:   Thu, 16 Aug 2018 16:03:12 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@jeffhostetler.com, git@vger.kernel.org, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180816140312.GA6102@tor.lan>
References: <20180810153608.30051-1-pclouds@gmail.com>
 <20180812090714.19060-1-pclouds@gmail.com>
 <20180815190816.GA26521@tor.lan>
 <xmqqtvnvh12u.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtvnvh12u.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:x1aElhFCPj0qIQVa+Xtet4x5ICipe+jxw+z0hD3RsYrsJTO5enf
 El9r+CRZcR8h/YGlrVPKuZzVx3LDh6odYc70uX71mlwqbmmYvkxxzOjX5bGNbHFYdR7fFE7
 Nh9dApYvC7JkfvWQpxZZxxj2f/hvkJEVlA/3eR1TQW//qpsf4kIwT+STXR15pwBhP/1kpbL
 H/ONMEW3bZH7YtIZAyRKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DPKM7yFPUW4=:kPu2rkuS/ascom/15tK94f
 SU/r4GnWrougx890oucVjXnSnr5QpphagHdQWB4Mtbgd6XjOlVrWkuZyI7YHMT9WCJGLIknWk
 YVXuXY8k5sA1QPuKDQeQRd0qcvUJ99e5F9Jn7nnfFJOtVhUfVE/b2jm8lw3zamBnNFiYRfHd1
 FUYiHQTZ2om92nSDanz6I3U3cz960Bn4GzERQFlYU/1C6UbekF5cb6MjbkEyVGyRpCwrTERJw
 epVbo36dLXWorZbC+MigwHGHt7SdLVQ5OsXk3N/2nCsEr2AScSlD3+yUKGV5BMnKZx+qqeLPw
 llJ9PK2xwnTx7csSnVwFGghZDDoxpbbm1yoffAJjVS2WOSBBKeWLzZIb3eDjp0t9ejybE8/2y
 okm5XH7L8JTUGccCdWdP+Q5uRGqcvrr1f3jfDOT/qe3mB0TvFcL8h50PKGgT/uZHZraglYiIZ
 BipB3OCPwwSbrEmjRY7maI0ZddmQz4NZFsQutawvNkV5rIFxJSPMwHMuefJtaJbvC+SvpUhZ7
 PaDr41p8jDKS3+6jI0JcLF0H0sWjT3dEiAQ+b6Lyl82u9zF/O5p1Mo0O414TKZcbJfzhxmkVp
 iZgyM7sKFcqHm8bN499f348cbe83nojOnrdaC1LWqe+2RT0peWVr/+cBJrTBSjC6TYl9fyFXQ
 qFp4TWUZgFEaGDFt+8qMLZjQ6MwmrRYA4+iHZwnbOHcxGVKUp0mv30iUJ4vXllbr+Rz9o6Q9f
 0aTy4YsPfE3dxOqMYNcSTcwotY8KLbzBWOrsQD2lGsFDcCnid2jqtwF8sJU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 12:38:49PM -0700, Junio C Hamano wrote:

This should answer Duys comments as well.
> Torsten Bögershausen <tboegi@web.de> writes:
> 
[snip]
> > Should the following be protected by core.checkstat ? 
> > 	if (check_stat) {
> 
> I do not think such a if statement is strictly necessary.
> 
> Even if check_stat tells us "when checking if a cached stat
> information tells us that the path may have modified, use minimum
> set of fields from the 'struct stat'", we still capture and update
> the values from the same "full" set of fields when we mark a cache
> entry up-to-date.  So it all depends on why you are limiting with
> check_stat.  Is it because stdev is unusable?  Is it because nsec is
> unusable?  Is it because ino is unusable?  Only in the last case,
> paying attention to check_stat will reduce the false positive.
> 
> But then you made me wonder what value check_stat has on Windows.
> If it is false, perhaps we do not even need the conditional
> compilation, which is a huge plus.

Agreed:
check_stat is 0 on Windows, and inum is allways 0 in lstat().
I was thinking about systems which don't have inodes and inum,
and then generate an inum in memory, sometimes random.
After a reboot or a re-mount of the file systems those ino values
change.
However, for the initial clone we are fine in any case.

> 
> >> +		if (dup->ce_stat_data.sd_ino == st->st_ino) {
> >> +			dup->ce_flags |= CE_MATCHED;
> >> +			break;
> >> +		}
> >> +	}
> >> +#endif
> >
> > Another thing is that we switch of the ASCII case-folding-detection-logic
> > off for Windows users, even if we otherwise rely on icase.
> > I think we can use fspathcmp() as a fallback. when inodes fail,
> > because we may be on a network file system.
> >
> > (I don't have a test setup at the moment, but what happens with inodes
> > when a Windows machine exports a share to Linux or Mac ?)
> >
> > Is there a chance to get the fspathcmp() back, like this ?
> 
> If fspathcmp() never gives false positives, I do not think we would
> mind using it like your update.  False negatives are fine, as that
> is better than just punting the whole thing when there is no usable
> inum.  And we do not care all that much if it is more expensive;
> this is an error codepath after all.
> 
> And from code structure's point of view, I think it makes sense.  It
> would be even better if we can lose the conditional compilation.

The current implementation of fspathcmp() does not give false positvies,
and future versions should not either.
All case-insentive file systems have always treated 'a-z' equal to 'A-Z'.
In FAT MS/DOS there had only been uppercase letters as file names,
and `type file.txt` (the equivilant to ´cat file.txt´ in *nix)
simply resultet in `type FILE.TXT`
Later, with VFAT and later with HPFS/NTFS a file could be stored on
disk as "File.txt".
From now on  ´type FILE.TXT´ still worked, (and all other upper-lowercase
combinations).
This all is probably nothing new.
The main point should be that fspathcmp() should never return a false positive,
and I think we all agree on that. 


Now back to the compiler switch:
Windows always set inum to 0 and I can't think about a situation where
a file in a working tree gets inum = 0, can we use the following:

static void mark_colliding_entries(const struct checkout *state,
				   struct cache_entry *ce, struct stat *st)
{
	int i;
	ce->ce_flags |= CE_MATCHED;

	for (i = 0; i < state->istate->cache_nr; i++) {
		struct cache_entry *dup = state->istate->cache[i];
		int folded = 0;

		if (dup == ce)
			break;

		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
			continue;
		/*
		 * Windows sets ino to 0. On other FS ino = 0 will already be
		 *  used, so we don't see it for a file in a Git working tree
		 */
		if (st->st_ino && (dup->ce_stat_data.sd_ino == st->st_ino))
			folded = 1;

		/*
		 * Fallback for NTFS and other case insenstive FS,
		 * which don't use POSIX inums
		 */
		if (!fspathcmp(dup->name, ce->name))
			folded = 1;

		if (folded) {
			dup->ce_flags |= CE_MATCHED;
			break;
		}
	}
}


> 
> Another thing we maybe want to see is if we can update the caller of
> this function so that we do not overwrite the earlier checkout with
> the data for this path.  When two paths collide, we check out one of
> the paths without reporting (because we cannot notice), then attempt
> to check out the other path and report (because we do notice the
> previous one with lstat()).  The current code then goes on and overwrites
> the file with the contents from the "other" path.
> 
> Even if we had false negative in this loop, if we leave the contents
> for the earlier path while reporting the "other" path, then the user
> can get curious, inspect what contents the "other" path has on the
> filesystem, and can notice that it belongs to the (unreported--due
> to false negative) earlier path.
> 
[snip]
