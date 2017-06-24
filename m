Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F3320401
	for <e@80x24.org>; Sat, 24 Jun 2017 17:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbdFXRWq (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 13:22:46 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32795 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdFXRWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 13:22:45 -0400
Received: by mail-wr0-f194.google.com with SMTP id x23so20384224wrb.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I1YdlXxQyVV9KlBaBkLLPi5700nZG+5oOo5pVzPqMBg=;
        b=LWtWfH3IpCIsuAoDGraUlvt4kRFYdFp0JlIMlqN9TWlWtzFip9947cbtUbfip9SJtl
         h9Ysn8aXhanLTUVHI8EhvpbaHvk2VbIQ6WQBpPq/LtYhA8prisG3SOAgfIZPepbTjIaD
         U5lqwacuzFRgSx1vRFdvDSPHMOgxNkcik92aW+vX6H3vkVesL4NKH45L6ohSls+Ou/CW
         46Rylk3AVpU2pSPhH3EypjIoeYWE/OJeW7WZ4fhQVmUlsD0b+EfWo/ZnSKLXPy4yWhYv
         EVUorVb+AuU6Kc/fXH7VRCGp27FHvBuPjYoTFA2BvvvbKECBu3IHhFyZt0R3V42CIJvo
         A6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I1YdlXxQyVV9KlBaBkLLPi5700nZG+5oOo5pVzPqMBg=;
        b=G+DwdRbNmclbJMqN8anrtg90O6aB8Bxx3wlawg8GeTXV4m6D4W/YPJNkTewoHqf5nb
         Ar2GH8sUGZY4N97WxPY5A9LqeXwHuQHn4Efc8K1EWU3ZUzZyBo8QFvGKGdAHU+GRRjpd
         Xazz4bA1H6EiPiU5j9EUfnCq9kRiaNvir+QVC+MFwlnaGffYPXunK5LCSozKG2dLRtkg
         H/87ldjkRFNXoZEbrJjSoZj5T4+t4sW8IzD5j1hdPJOJUFhbEwv4dXIzqvt4WWnuvclo
         W2xqb2nAi52jHt2A8q+T6A9xIfAJJdtySXLI/glcSyN4UzCym6beU/rp8vUWnRXc3cqC
         5pdw==
X-Gm-Message-State: AKS2vOzITku7jpADeonR5Lq0TDv/XiQYvgQF0kPVFxvdxSuVJKwEALdS
        bGe55xIdZc0/jClYYy4=
X-Received: by 10.28.132.210 with SMTP id g201mr8876148wmd.26.1498324963760;
        Sat, 24 Jun 2017 10:22:43 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB763B.dip0.t-ipconnect.de. [93.219.118.59])
        by smtp.gmail.com with ESMTPSA id a99sm3786808wrc.64.2017.06.24.10.22.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 10:22:42 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 5/5] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170624141941.usy2pyhid3jrf3ku@sigill.intra.peff.net>
Date:   Sat, 24 Jun 2017 19:22:40 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8FAEFDC-1ADA-4355-80DC-069A739F829C@gmail.com>
References: <20170601082203.50397-1-larsxschneider@gmail.com> <20170601082203.50397-6-larsxschneider@gmail.com> <20170624141941.usy2pyhid3jrf3ku@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Jun 2017, at 16:19, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Jun 01, 2017 at 10:22:03AM +0200, Lars Schneider wrote:
>=20
>> Some `clean` / `smudge` filters might require a significant amount of
>> time to process a single blob (e.g. the Git LFS smudge filter might
>> perform network requests). During this process the Git checkout
>> operation is blocked and Git needs to wait until the filter is done =
to
>> continue with the checkout.
>>=20
>> Teach the filter process protocol (introduced in edcc858) to accept =
the
>> status "delayed" as response to a filter request. Upon this response =
Git
>> continues with the checkout operation. After the checkout operation =
Git
>> calls "finish_delayed_checkout" which queries the filter for =
remaining
>> blobs. If the filter is still working on the completion, then the =
filter
>> is expected to block. If the filter has completed all remaining blobs
>> then an empty response is expected.
>>=20
>> Git has a multiple code paths that checkout a blob. Support delayed
>> checkouts only in `clone` (in unpack-trees.c) and `checkout` =
operations.
>=20
> It might be worth giving a reason in this last paragraph. I think the
> reason is "because it's more complicated for the caller, as they have =
to
> be OK with out-of-order processing and remembering to go back and =
handle
> the delayed cases".

Correct! However, my real reason was that these code paths process all
files of the tree. Therefore the "out-of-order" processing can be
effective.=20

How about this:

Git has a multiple code paths that checkout a blob. Support delayed
checkouts only in `clone` (in unpack-trees.c) and `checkout` operations
for now. The optimization is most effective in these code paths as all=20=

files of the tree are processed.


> Speaking of which, _are_ we OK with out-of-order processing in things
> like checkout? Certainly we care about deleting items before checking
> out new ones (so getting rid of "foo/bar" to make room for "foo" and
> vice versa).  I guess it's OK as long as the delayed items are always
> filters that check out new items.

Junio noticed that too but thinks we should be OK:
"[...] We checkout removals first to make room so
that creation of a path X can succeed if an existing path X/Y
that used to want to see X as a directory can succeed [...]"

=
http://public-inbox.org/git/xmqqvavotych.fsf@gitster.mtv.corp.google.com/


>> ...
>=20
>> +After Git received the pathnames, it will request the corresponding
>> +blobs again. These requests contain a pathname and an empty content
>> +section. The filter is expected to respond with the smudged content
>> +in the usual way as explained above.
>> +------------------------
>> +packet:          git> command=3Dsmudge
>> +packet:          git> pathname=3Dpath/testfile.dat
>> +packet:          git> 0000
>> +packet:          git> 0000  # empty content!
>> +packet:          git< status=3Dsuccess
>> +packet:          git< 0000
>> +packet:          git< SMUDGED_CONTENT
>> +packet:          git< 0000
>> +packet:          git< 0000  # empty list, keep "status=3Dsuccess" =
unchanged!
>> +------------------------
>=20
> Out of curiosity, what should happen if we re-ask for a pathname that
> wasn't mentioned in list_available_blobs? I guess it would depend on =
the
> filter implementation, but probably most would just block (since we
> wouldn't have asked for can-delay). The other option is returning an
> error, I suppose, but blocking and filling the request sounds
> friendlier.

I agree that is up to the filter. I would expect the blocking strategy.
The filter cannot delay it anymore as we have not send the "can-delay"
flag.


> ...
>> diff --git a/cache.h b/cache.h
>> index ae4c45d379..523ead1d95 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1543,16 +1543,20 @@ extern int ident_cmp(const struct ident_split =
*, const struct ident_split *);
>> struct checkout {
>> 	struct index_state *istate;
>> 	const char *base_dir;
>> +	struct delayed_checkout *delayed_checkout;
>> 	int base_dir_len;
>=20
> Should base_dir_len and base_dir be kept together?
>=20
> I suspect you ordered it this way because...
>=20
>> 	unsigned force:1,
>> 		 quiet:1,
>> 		 not_new:1,
>> 		 refresh_cache:1;
>> };
>> -#define CHECKOUT_INIT { NULL, "" }
>> +#define CHECKOUT_INIT { NULL, "", NULL }
>> +
>=20
> ...you wanted to add the NULL to the initializer here. But it's not
> necessary. Once one element of a struct is initialized, all the
> remaining members are initialized according to the usual static rules
> (so NULL for pointers). We're already using that to zero out
> base_dir_len and the flags (the "" is necessary because we want a real
> empty string, not NULL).
>=20
> Since you want NULL for your new member, you can just leave the
> initializer as-is and it will do the right thing.

That was indeed my reasoning. I am no C expert and I wasn't sure about
the initialization. The "Once one element of a struct is initialized"
thing is news to me :-) Thanks!

I'll keep the base_dir* together then!


>> @@ -533,7 +534,8 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
>> 	if (err)
>> 		goto done;
>>=20
>> -	err =3D packet_writel(process->in, "capability=3Dclean", =
"capability=3Dsmudge", NULL);
>> +	err =3D packet_writel(process->in,
>> +		"capability=3Dclean", "capability=3Dsmudge", =
"capability=3Ddelay", NULL);
>=20
> Why do we need to tell the filter we know about delay? Shouldn't it =
just
> need to tell us that it knows about delay, and then we choose whether =
to
> ask for can-delay for particular entries?

Because in the protocol I defined that the filter needs to answer with
a strict subset of this list [1]. I thought that this would make the =
protocol
more future proof/backward compatible. Because the filter is not allowed =
to
answer with something that Git does not understand.

[1] =
https://github.com/git/git/blob/5402b1352f5181247405fbff1887008a0cb3b04a/D=
ocumentation/gitattributes.txt#L408-L411


>=20
>> @@ -647,6 +653,14 @@ static int apply_multi_file_filter(const char =
*path, const char *src, size_t len
>> 	if (err)
>> 		goto done;
>>=20
>> +	if (CAP_DELAY & entry->supported_capabilities &&
>> +	    dco && dco->state =3D=3D CE_CAN_DELAY) {
>=20
> In a complicated conditional with bit operations, we usually put the =
bit
> operation in its own parentheses so it's more obvious that it wasn't
> supposed to be "&&". Like:
>=20
>  if ((CAP_DELAY & entry->supported_capabilities) &&
>      dco && dco->state =3D=3D CE_CAN_DELAY))

Agreed!


> The operator precedence is such that it works without them, so this is
> just a style question (I'd also usually put the flags field before the
> flag itself, but that's really getting into aesthetics).

You mean (entry & CAP_DELAY) instead of (CAP_DELAY & entry)?


> The dco check here is basically asking if can-delay is enabled for the
> whole checkout. Would we ever need to mark a specific entry as
> not-delayable? Probably not from the start, but I wondered if =
something
> might get marked as a failure and need to be retried without delay or
> similar. It's probably not worth going down that road until some =
caller
> needs it.

Agreed.

>=20
>> @@ -662,14 +676,78 @@ static int apply_multi_file_filter(const char =
*path, const char *src, size_t len
>> 	if (err)
>> 		goto done;
>>=20
>> -	err =3D strcmp(filter_status.buf, "success");
>> +	if (can_delay && !strcmp(filter_status.buf, "delayed")) {
>> +		dco->state =3D CE_DELAYED;
>> +		string_list_insert(&dco->filters, cmd);
>> +		string_list_insert(&dco->paths, path);
>=20
> These string_list_insert()s have bad worst-case performance, because
> they keep the list sorted. So the worst case is reverse-sorted input,
> where each entry goes at the front of the existing array and we have =
to
> memmove() the whole array on each insert, and we do O(n^2) byte =
copies.
>=20
> The best case is when the input is already sorted. And I think in
> general that's how we'll iterate over paths to checkout. The cmds are
> more likely to be random, but we're also not likely to have more than =
a
> handful of them. So this is probably an OK data structure to use, at
> least for now.

Agreed! Up until now I tested the delayed technique only with my small =
test=20
case. It will become really interesting when GitLFS implements this =
feature.
Then I can test it with our repos that have +20k filtered files. At this =
point
I will be able to identify the spots that require more optimization.


>> +	for (;;) {
>> +		const char* pre =3D "pathname=3D";
>> +		const int pre_len =3D strlen(pre);
>> +		line =3D packet_read_line(process->out, NULL);
>> +		if (!line)
>> +			break;
>> +		err =3D strlen(line) <=3D pre_len || strncmp(line, pre, =
pre_len);
>> +		if (err)
>> +			goto done;
>> +		string_list_insert(delayed_paths, =
xstrdup(line+pre_len));
>> +	}
>=20
> I think the prefix matching can be done more simply (and slightly more
> efficiently) with:
>=20
>  const char *path;
>  ...
>  err =3D !skip_prefix(line, "pathname=3D", &path);
>  if (err)
> 	goto done;
>  string_list_insert(delayed_paths, xstrdup(path));
>=20
> I notice we loop here, though. Would we want to be resilient to seeing
> other keys besides pathname? Something like:
>=20
>  while ((line =3D packet_read_line(process->out, NULL)) {
> 	const char *path;
> 	if (skip_prefix(line, "pathname=3D", &path))
> 		string_list_insert(delayed_paths, xstrdup(path);
> 	else
> 		; /* ignore unknown keys */
>  }
>=20
> I can imagine some future where the filter passes back additional
> information about the delayed item. It would be nice if older versions
> of Git would just quietly ignore that if they don't know how to handle
> it.

I agree with all the above. skip_prefix is neat! Although it's so
dominant in the source code I never noticed it.


>> +int finish_delayed_checkout(struct checkout *state)
>> +{
>> +	int errs =3D 0;
>> +	struct string_list_item *filter, *path;
>> +	struct delayed_checkout *dco =3D state->delayed_checkout;
>> +
>> +	if (!state->delayed_checkout) {
>> +		return errs;
>> +	}
>=20
> Style: we'd usually omit the braces here.

Sure! I'll remove it.

(This is the only rule of the Git style guide that
don't agree with :-)=20

>=20
>> +			if (available_paths.nr <=3D 0) {
>> +				/* Filter responded with no entries. =
That means
>> +				   the filter is done and we can remove =
the
>> +				   filter from the list (see
>> +				   "string_list_remove_empty_items" call =
below).
>> +				*/
>=20
> This is true because we know the filter would block until it had at
> least one item to return.
>=20
> It does seem to put a lot of faith in the filter. What happens if we =
hit
> this conditional and we know that we still have entries in dco->paths =
to
> be handled?

We check this later as you noticed below.


>> +			/* In dco->paths we store a list of all delayed =
paths.
>> +			   The filter just send us a list of available =
paths.
>> +			   Remove them from the list.
>> +			*/
>> +			filter_string_list(&dco->paths, 0,
>> +				&remove_available_paths, =
&available_paths);
>=20
> This is O(m log n), which is fine. Since both lists are sorted, we =
could
> technically do it in an O(m+n) merge, but I don't think we have a
> function to do that easily.
>=20
> Sorry to harp on run-times, but it's one place I think it would be =
easy
> to subtly screw this up, so I'm trying to pay close attention.

No worries at all! Thanks for thinking it through on that level.
As I wrote above - I plan to really profile it under "real life =
conditions"
as soon as we have full GitLFS support.


>> ...
>=20
>> +	/* At this point we should not have any delayed paths anymore. =
*/
>> +	errs |=3D dco->paths.nr;
>=20
> And I guess this answers my question above about a filter with no
> entries. When we bail from the loop, we'll hit this point and =
complain.
>=20
> We probably should call string_list_clear(&dco->paths) here to avoid
> leaking the paths on error (possibly we should also print them? Or =
maybe
> they'd be warned about elsewhere).

Agreed, I will clear the list. I'll also print the items because as far
as I can see they are not printed elsewhere.

Git just says:
fatal: unable to checkout working tree
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry the checkout with 'git checkout -f HEAD'

How about this?

	errs |=3D dco->paths.nr;
	for_each_string_list_item(path, &dco->paths) {
		warning("%s was not processed properly.", path->string);
	}
	string_list_clear(&dco->paths, 0);

The output would be:

warning: test-delay10.a was not processed properly.
warning: test-delay10.b was not processed properly.
warning: test-delay11.a was not processed properly.
warning: test-delay20.a was not processed properly.
fatal: unable to checkout working tree
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry the checkout with 'git checkout -f HEAD'

I contemplated about the warning text.
"$FILE was not filtered properly." is technical more
correct but maybe it would confuse the user?

Plus, at this point I don't really know what filter should
have given me the files. That's why I can't print it in=20
the warning message.

>=20
>> @@ -179,11 +254,36 @@ static int write_entry(struct cache_entry *ce,
>> 		/*
>> 		 * Convert from git internal format to working tree =
format
>> 		 */
>> -		if (ce_mode_s_ifmt =3D=3D S_IFREG &&
>> -		    convert_to_working_tree(ce->name, new, size, &buf)) =
{
>> -			free(new);
>> -			new =3D strbuf_detach(&buf, &newsize);
>> -			size =3D newsize;
>> +		if (ce_mode_s_ifmt =3D=3D S_IFREG) {
>> +			struct delayed_checkout *dco =3D =
state->delayed_checkout;
>> +			if (dco && dco->state !=3D CE_NO_DELAY) {
>> +				/* Do not send the blob in case of a =
retry. */
>> +				if (dco->state =3D=3D CE_RETRY) {
>> +					new =3D NULL;
>> +					size =3D 0;
>> +				}
>> +				ret =3D async_convert_to_working_tree(
>> +					ce->name, new, size, &buf, dco);
>> +				if (ret && dco->state =3D=3D CE_DELAYED) =
{
>> +					free(new);
>> +					/* Reset the state of the next =
blob */
>> +					dco->state =3D CE_CAN_DELAY;
>> +					goto finish;
>> +				}
>=20
> Hmm. This "reset the state" bit at the end surprised me. I guess it's
> not wrong, but it goes against the mental model I had formed above. ;)
>=20
> We really are using dco->state as a per-entry state flag. It just
> happens to be in a persistent shared struct. I don't think it's wrong,
> it was mostly just surprising. I don't know if it's worth trying to
> simplify, but I think you could do it by:
>=20
>  1. Passing back the "was delayed" state from async_convert... in the
>     return value or via a separate out-parameter.

In the beginning I had it implemented that way. But that meant that I
had to pass two variables through the entire convert stack:

async_convert_to_working_tree
-> convert_to_working_tree_internal
--> apply_filter
---> apply_multi_file_filter

>=20
>  2. Setting dco->state to CE_RETRY at the top of finish_delayed... so
>     that it's clear that it's about what phase of the conversation
>     we're in.

I could do that. However, I thought it is safer to set the state =
*before*
every checkout operation in case convert.c messes with this field (it
should not in this phase).


> But I'm OK with it as-is, too.

I'll try 2.


>> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
>> index 5e43faeec1..f0dc0aff4a 100644
>> --- a/t/t0021/rot13-filter.pl
>> +++ b/t/t0021/rot13-filter.pl
>=20
> I'll admit to skimming the perl changes here, but I didn't see =
anything
> obviously wrong.


Thanks a lot for the review,
Lars

