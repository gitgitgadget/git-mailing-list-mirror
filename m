Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDACF1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 08:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeJXQ20 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:28:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:41079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbeJXQ20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:28:26 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfSeH-1fn26C1NE1-00p7ku; Wed, 24
 Oct 2018 10:01:13 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfSeH-1fn26C1NE1-00p7ku; Wed, 24
 Oct 2018 10:01:13 +0200
Date:   Wed, 24 Oct 2018 10:01:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] shallow: offer to prune only non-existing
 entries
In-Reply-To: <xmqqmur4ovjt.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810240941230.4546@tvgsbejvaqbjf.bet>
References: <pull.9.v2.git.gitgitgadget@gmail.com> <pull.9.v3.git.gitgitgadget@gmail.com> <f085eb4f728f5cd102f56b7a90ce9b10fdb59dee.1540245934.git.gitgitgadget@gmail.com> <xmqqmur4ovjt.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gRXDS0HSgCsG+brXdSApQSh8EYEgfpmx679BBRxQ81DddMEe7k4
 yD8c15rS5YPhP3Jqcy/pBv8YrFr240Crpw5CAXz3mSeFHGwQ7dmR/3oCP1BV4d2HjyWQ5cy
 3JI1sqJFNJX6/QQ8bnf8yIzYfmOmkmJqMNoQfFIjophl4BDzRBh0V6IC9BD0PgjETDnENaC
 gXTMlITL45kKSVul3Ec4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q0sZralUWSI=:GITaKoOVAMokt8rSZHno73
 f03A9BiDM3Wyi0aGNN1p/gYcj2teChZhoK2VrC5OsMSCfiRUf4WTk5kPHUa0czLpIwLR/DO35
 h8OUVZz6DLfj3P9Yjldhx6VzF9GFrVieJmf/2hJRhCiZtmc+M4Y4LSwSYk3/Hbes6AygMu6+9
 61yY/aKq3WtJEz67MjjM+hpInYB0ijQQSCWehajTjzFtKo6xq3sr61YnsM9Xkc+5vopM8ze/J
 eMJUzJ496198aqbvzRpZEauhiLtVawt2B4uA4I8byI+/5ZfNSJffvTFPVBIIsuzaJEGRK+qvw
 XhF+jCObUozpUJMxyi5lhebkZYzDKmwyG9bAMGQvQw2wF5x2N6lw6wztyo5tIFRy/QPX3fnt+
 3aa0fjlNYsEc+BXI8EpNRK4QVf4upKcMzHtCoQ3RXh9jFUqTItizeb2lxav6ZJuHd5CU/KBKN
 okv3OsNgkAF51PbzOZBl6vH8e67v0JqO5XIVgxsb1yfziuTOZGGhRWMePKpVpXs2OPgou2e3P
 u1JwwVQKV7U0uvbGLjX5pA3X+y9rA1R4ZFDpBqDVbk0Fa1DqaIq+Eb0RFRicq9wiXSjapZYU7
 2ZFd/6jU6mNQ4CNgOAJbr/fwvTehQwm3vVad8xYF5IlgBBagi9NiX8UgVeVCVgv+ihncfWUfp
 ZCfbmymE3EhYqQVkpaLIxxxB5EQUR7RnZ8PYoAlvYmzULRMc+Y9UTfgiP0o4H2PyXU4uf+30B
 /Axw5biyGcaJBt0dZTURnxe86jIRRVEqF4ucs/rXBdqZHnX5g0cwO3EnRYIhfqGS8uVNLVbWc
 JWibmUsk6pHifXsWQM2sBKIB+YIJutWhxPdPxks64vrFZNCY6A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Jonathan,

On Wed, 24 Oct 2018, Junio C Hamano wrote:

> Jonathan, do you see any issues with the use of lookup_commit() in
> this change wrt lazy clone?  I am wondering what happens when the
> commit in question is at, an immediate parent of, or an immediate
> child of a promisor object.  I _think_ this change won't make it
> worse for two features in playing together, but thought that it
> would be better to double check.

Good point.

Instinctively, I would say that no promised object can be a shallow
commit. The entire idea of a shallow commit is that it *is* present, but
none of its parents.

Also, I would claim that the shallow feature does not make sense with lazy
clones, as lazy clones offer a superset of shallow clone's functionality.

However, I am curious whether there is a better way to check for the
presence of a local commit? Do we have an API function for that, that I
missed? (I do not really want to parse the commit, after all, just verify
that it is not pruned.)

Thanks,
Dscho

> 
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `prune_shallow()` function wants a full reachability check to be
> > completed before it goes to work, to ensure that all unreachable entries
> > are removed from the shallow file.
> >
> > However, in the upcoming patch we do not even want to go that far. We
> > really only need to remove entries corresponding to pruned commits, i.e.
> > to commits that no longer exist.
> >
> > Let's support that use case.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/prune.c |  2 +-
> >  commit.h        |  2 +-
> >  shallow.c       | 22 +++++++++++++++++-----
> >  3 files changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/builtin/prune.c b/builtin/prune.c
> > index 41230f821..6d6ab6cf1 100644
> > --- a/builtin/prune.c
> > +++ b/builtin/prune.c
> > @@ -161,7 +161,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
> >  	free(s);
> >  
> >  	if (is_repository_shallow(the_repository))
> > -		prune_shallow(show_only);
> > +		prune_shallow(show_only, 0);
> >  
> >  	return 0;
> >  }
> > diff --git a/commit.h b/commit.h
> > index 1d260d62f..ff34447ab 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -249,7 +249,7 @@ extern void assign_shallow_commits_to_refs(struct shallow_info *info,
> >  					   uint32_t **used,
> >  					   int *ref_status);
> >  extern int delayed_reachability_test(struct shallow_info *si, int c);
> > -extern void prune_shallow(int show_only);
> > +extern void prune_shallow(int show_only, int quick_prune);
> >  extern struct trace_key trace_shallow;
> >  
> >  extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
> > diff --git a/shallow.c b/shallow.c
> > index 732e18d54..0a2671bc2 100644
> > --- a/shallow.c
> > +++ b/shallow.c
> > @@ -247,6 +247,7 @@ static void check_shallow_file_for_update(struct repository *r)
> >  
> >  #define SEEN_ONLY 1
> >  #define VERBOSE   2
> > +#define QUICK_PRUNE 4
> >  
> >  struct write_shallow_data {
> >  	struct strbuf *out;
> > @@ -261,7 +262,11 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
> >  	const char *hex = oid_to_hex(&graft->oid);
> >  	if (graft->nr_parent != -1)
> >  		return 0;
> > -	if (data->flags & SEEN_ONLY) {
> > +	if (data->flags & QUICK_PRUNE) {
> > +		struct commit *c = lookup_commit(the_repository, &graft->oid);
> > +		if (!c || parse_commit(c))
> > +			return 0;
> > +	} else if (data->flags & SEEN_ONLY) {
> >  		struct commit *c = lookup_commit(the_repository, &graft->oid);
> >  		if (!c || !(c->object.flags & SEEN)) {
> >  			if (data->flags & VERBOSE)
> > @@ -371,16 +376,23 @@ void advertise_shallow_grafts(int fd)
> >  
> >  /*
> >   * mark_reachable_objects() should have been run prior to this and all
> > - * reachable commits marked as "SEEN".
> > + * reachable commits marked as "SEEN", except when quick_prune is non-zero,
> > + * in which case lines are excised from the shallow file if they refer to
> > + * commits that do not exist (any longer).
> >   */
> > -void prune_shallow(int show_only)
> > +void prune_shallow(int show_only, int quick_prune)
> >  {
> >  	struct lock_file shallow_lock = LOCK_INIT;
> >  	struct strbuf sb = STRBUF_INIT;
> > +	unsigned flags = SEEN_ONLY;
> >  	int fd;
> >  
> > +	if (quick_prune)
> > +		flags |= QUICK_PRUNE;
> > +
> >  	if (show_only) {
> > -		write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY | VERBOSE);
> > +		flags |= VERBOSE;
> > +		write_shallow_commits_1(&sb, 0, NULL, flags);
> >  		strbuf_release(&sb);
> >  		return;
> >  	}
> > @@ -388,7 +400,7 @@ void prune_shallow(int show_only)
> >  				       git_path_shallow(the_repository),
> >  				       LOCK_DIE_ON_ERROR);
> >  	check_shallow_file_for_update(the_repository);
> > -	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
> > +	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
> >  		if (write_in_full(fd, sb.buf, sb.len) < 0)
> >  			die_errno("failed to write to %s",
> >  				  get_lock_file_path(&shallow_lock));
> 
