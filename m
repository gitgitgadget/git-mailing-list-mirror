Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB40207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 21:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdFZV22 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 17:28:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34208 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFZV20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 17:28:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id f134so2548226wme.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bK14f8+1ZHFyw7GPvrWm/BJLdDicH527zsDHTYziYCc=;
        b=KnVTBy9SFgEOphAN3Ktcm45IrJNF0Lczz3ks2g/ueaGeIcynOLbKIAf2HfXMoy9YVA
         3FEwonQ83B70NNNd+qeKqgsR7AXgJV+gCZvFBrypjy4GbnNta3CA1/4ENWUOGMX6C13b
         VkSxMmFZMtkfb7I185Vh8+K56QUqRqXWy6SltuAKnoakBmwyKzMmsEkhOqGn+0bkeGHK
         bGnYx/3Acoz4O0UclyQ3dy+erFYiRlFAlNKNtffZMjfDUCaVdJ4habB6U6t6UUXjD6Eh
         toY2TtfkhRKNMMfVW3lmCMSeMf/S7N2IZaDiFSlzFoBWiJntXhDruC7FtPA/Duvkubpq
         prRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bK14f8+1ZHFyw7GPvrWm/BJLdDicH527zsDHTYziYCc=;
        b=oMfMoLFhgXgtba3pO6BAG29x0t2R72hnQa2e0Vim1FLkvsYa8HUPbA6a0+B3imuTUz
         1sPwrOLVM7Zu67H4U2OQ1J9wZhbNf93jXg3unaDG7oVN5BwysHBr4ZyyKDK11xRjduyu
         muJSOGtJh4FYCuTPezTdLLcu/+5eFlAWR+q6XXW3xDleYshEl3sQpYwCOrKOWYBHcwqh
         SqIkPtnWSSnqaAXgTNoHUGx5WV1ZPnGME2JzXRHNlHgz3o0yTMLuR/IRQCjtEnwz2Nua
         RfilXOGXkWbX0Grn+NqnkikRtBPu4JSrcmd9I2luRIJKT35RUpQ3JPqVX5jMUrc/7HK8
         IrSw==
X-Gm-Message-State: AKS2vOzLztWo+TDsdsFtdCWsyfpqK2s8Z9Eau2fo92CpyKl9k0pv1rn6
        o0TQdMrCdI/Naw==
X-Received: by 10.28.169.207 with SMTP id s198mr987993wme.8.1498512504409;
        Mon, 26 Jun 2017 14:28:24 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4308.dip0.t-ipconnect.de. [93.219.67.8])
        by smtp.gmail.com with ESMTPSA id r187sm916792wmg.15.2017.06.26.14.28.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 14:28:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 6/6] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzicu4lnq.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Jun 2017 23:28:21 +0200
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F72755BA-6296-4C37-9EFA-4D7BCE9F1082@gmail.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com> <20170625182125.6741-7-larsxschneider@gmail.com> <xmqqzicu4lnq.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Jun 2017, at 21:02, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> Some `clean` / `smudge` filters might require a significant amount of
>> time to process a single blob (e.g. the Git LFS smudge filter might
>> perform network requests). During this process the Git checkout
>> operation is blocked and Git needs to wait until the filter is done =
to
>> continue with the checkout.
>=20
> Good motivation.  I'd say s/might/may/ to stress the fact that this
> is addressing a real-world problem, i.e. some filters incur network
> latencies.

Agreed.


>> Teach the filter process protocol (introduced in edcc858) to accept =
the
>=20
> When referring to an old commit, we recommend this format
>=20
>    edcc8581 ("convert: add filter.<driver>.process option", =
2016-10-16)
>=20
> (with or without dq around the title) which helps readers by telling
> them how old the thing is and what it was about.

Agreed.


> ...
>=20
>> +Delay
>> +^^^^^
>> +
>> +If the filter supports the "delay" capability, then Git can send the
>> +flag "can-delay" after the filter command and pathname. This flag
>> +denotes that the filter can delay filtering the current blob (e.g. =
to
>> +compensate network latencies) by responding with no content but with
>> +the status "delayed" and a flush packet.
>> +------------------------
>> +packet:          git> command=3Dsmudge
>> +packet:          git> pathname=3Dpath/testfile.dat
>> +packet:          git> can-delay=3D1
>> +packet:          git> 0000
>> +packet:          git> CONTENT
>> +packet:          git> 0000
>> +packet:          git< status=3Ddelayed
>> +packet:          git< 0000
>> +------------------------
>> +
>> +If the filter supports the "delay" capability then it must support =
the
>> +"list_available_blobs" command. If Git sends this command, then the
>> +filter is expected to return a list of pathnames of blobs that are
>> +available. The list must be terminated with a flush packet followed
>=20
> Is it correct to read the above "pathnames of blobs that are
> availble" as "pathnames, among which Git earlier requested to be
> filtered with "can-delay=3D1", for which the filtered result is
> ready"?  I do not mean to suggest this awkward wording to replace
> yours, but I found yours a bit too fuzzy for first time readers.
>=20
> Perhaps my brain has rotten by hearing the "delayed/lazy transfer of
> large blobs", but it went "Huh?" upon seeing "...are available".

Maybe this?
    [...] If Git sends this command, then the
    filter is expected to return a list of pathnames representing blobs=20=

    that have been delayed earlier and are now available. [...]


>> +by a "success" status that is also terminated with a flush packet. =
If
>> +no blobs for the delayed paths are available, yet, then the filter =
is
>> +expected to block the response until at least one blob becomes
>> +available.
>=20
> Ahh, this is better, at least you use "the delayed paths".
>=20
> What if the result never gets available (e.g. resulted in an error)?

As soon as the filter responds with an empty list, Git stops asking.
All blobs that Git has not received at this point are considered an
error.

Should I mention that explicitly?


> Or is it considered "we _now_ know the result is an error" and such
> a delayed path that failed to retrieve from LFS store "available" at
> that point?

No. "list_available_blobs" only returns blobs that are immediately
available. Errors are not available.


> It may be too late to raise to a series that went to v6, but this
> smells more like "ready" not "available" to me.

You mean you would call it "list_ready_blobs"? I am no native speaker
but I feel "available" sounds better. I also contemplated "retrievable".

I think I understand your reasoning, though. In the case of GitLFS all =
these=20
blobs are "available". Only the ones that GitLFS has downloaded are=20
ready, though. However, other filters might delay blobs for non-network
related reasons and then "available" and "ready" would be the same, no?

I would like to keep "available".

> ...

>> diff --git a/cache.h b/cache.h
>> index ae4c45d379..2ec12c4477 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1551,8 +1552,11 @@ struct checkout {
>> };
>> #define CHECKOUT_INIT { NULL, "" }
>>=20
>> +
>> #define TEMPORARY_FILENAME_LENGTH 25
>=20
> You probably do not need that new blank line.

Agreed! I have no idea why/how that got in.


> ...
>> diff --git a/convert.c b/convert.c
>> index e55c034d86..6452ab546a 100644
>> --- a/convert.c
>> +++ b/convert.c
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
>>=20
>> 	for (;;) {
>> 		cap_buf =3D packet_read_line(process->out, NULL);
>> @@ -549,6 +551,8 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
>> 			entry->supported_capabilities |=3D CAP_CLEAN;
>> 		} else if (!strcmp(cap_name, "smudge")) {
>> 			entry->supported_capabilities |=3D CAP_SMUDGE;
>> +		} else if (!strcmp(cap_name, "delay")) {
>> +			entry->supported_capabilities |=3D CAP_DELAY;
>> 		} else {
>> 			warning(
>> 				"external filter '%s' requested =
unsupported filter capability '%s'",
>=20
> The above makes me wonder if we want to introduce a table, e.g.
>=20
> 	static const struct {
> 		const *name;
> 		unsigned cap;
> 	} known_caps[] =3D {
> 		{ "clean", CAP_CLEAN },
> 		{ "smudge", CAP_SMUDGE },
> 		{ "delay", CAP_DELAY },
> 	};
>=20
> and drive everything (i.e. capability announcement in hunk +534,8
> and parsing of request in hunk +551,8) off of it.
>=20
> That would be overkill for two capabilities, but adding another to
> make it three is when such a refactoring starts to become plausible.

I agree with this way for many capabilities. I'll check if it makes
sense for 3.

>=20
>> @@ -590,9 +594,11 @@ static void handle_filter_error(const struct =
strbuf *filter_status,
>>=20
>> static int apply_multi_file_filter(const char *path, const char *src, =
size_t len,
>> 				   int fd, struct strbuf *dst, const =
char *cmd,
>> -				   const unsigned int wanted_capability)
>> +				   const unsigned int wanted_capability,
>> +				   struct delayed_checkout *dco)
>> {
>> 	int err;
>> +	int can_delay =3D 0;
>> 	struct cmd2process *entry;
>> 	struct child_process *process;
>> 	struct strbuf nbuf =3D STRBUF_INIT;
>> @@ -647,6 +653,14 @@ static int apply_multi_file_filter(const char =
*path, const char *src, size_t len
>> 	if (err)
>> 		goto done;
>>=20
>> +	if ((entry->supported_capabilities & CAP_DELAY) &&
>> +	    dco && dco->state =3D=3D CE_CAN_DELAY) {
>> +		can_delay =3D 1;
>> +		err =3D packet_write_fmt_gently(process->in, =
"can-delay=3D1\n");
>> +		if (err)
>> +			goto done;
>> +	}
>> +
>> 	err =3D packet_flush_gently(process->in);
>> 	if (err)
>> 		goto done;
>> @@ -662,14 +676,74 @@ static int apply_multi_file_filter(const char =
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
> The dco->state CE_CAN_DELAY is global to all the paths involved in
> this checkout, but filter_status.buf being "delayed" is per path
> (i.e. the filter can be told "can-delay=3D1" but still respond with
> success right away), and in such a case dco->state will not advance
> from CE_CAN_DELAY to CE_DELAYED (which in turn means we will show
> "can-delay=3D1" to the next path).  On the other hand, once we are
> responded by "delayed" after sending "can-delay=3D1", we will go into
> CE_DELAYED state and will not say "can-delay=3D1" to any subsequent
> path.

I am not 100% happy with design of "dco->state". You are right, I use
it as "global" flag to indicate if paths can be delayed. But I *also*
use it as "flag" to indicate if a certain path has been delayed.=20
Afterwards it is reset (see entry.c:write_entry).
Peff stumbled over that as well [1]. I need to change that!

Maybe with an additional flag "dco->delayed". This flag is reset
before any "async_convert_to_working_tree" and evaluated after.=20

[1] "Hmm. This "reset the state" bit at the end surprised me...."
=
http://public-inbox.org/git/20170624141941.usy2pyhid3jrf3ku@sigill.intra.p=
eff.net/


> This feels somewhat unsatisfactory.  =46rom the protocol exchange
> description in the documentation part of this patch, I was sort of
> expecting that Git can selectively say "You can delay response to
> this path" and "I am willing to wait until you give the filtered
> result" for each command/pathname pair.  But this code structure
> does not seem to allow that.
>=20
> I would understand it if CE_CAN_DELAY and CE_DELAYED are unified,
> and the assignment to dco->state here is removed.  You may be using
> these two states in other parts of the code to optimize between the
> case where *no* delayed path exists (even if Git is capable of
> delaying) and *some* delayed path exist, but I think that can be
> done by checking if dco->paths is empty, or something like that.
>=20
> Such a change will allow us later to add more logic (perhaps driven
> by attributes) to the decision to send "can-delay=3D1" in hunk +653,14
> above, to express "this won't be delayed".
>=20
> Alternatively, the semantics of "the entire checkout exchange is
> allowed to be delayed" can be kept but then the protocol looks too
> confusing---it shouldn't have "can-delay=3D1" after a command/pathname
> pair, as if it can be specified per path.

Actually a delay "per path" is possible. I'll try to make this more
clear with a little refactoring.


> ...
>=20
>> +int async_query_available_blobs(const char *cmd, struct string_list =
*delayed_paths)
>> +{
>> +	int err;
>> +	char *line;
>> +	struct cmd2process *entry;
>> +	struct child_process *process;
>> +	struct strbuf filter_status =3D STRBUF_INIT;
>> +
>> +	assert(subprocess_map_initialized);
>> +	entry =3D (struct cmd2process =
*)subprocess_find_entry(&subprocess_map, cmd);
>> +	if (!entry) {
>> +		error("external filter '%s' is not available anymore =
although "
>> +		      "not all paths have been filtered", cmd);
>> +		return 0;
>> +	}
>> +	process =3D &entry->subprocess.process;
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +
>> +	err =3D packet_write_fmt_gently(
>> +		process->in, "command=3Dlist_available_blobs\n");
>> 	if (err)
>> 		goto done;
>>=20
>> -	err =3D read_packetized_to_strbuf(process->out, &nbuf) < 0;
>> +	err =3D packet_flush_gently(process->in);
>> 	if (err)
>> 		goto done;
>>=20
>> +	while ((line =3D packet_read_line(process->out, NULL))) {
>> +		const char *path;
>> +		if (skip_prefix(line, "pathname=3D", &path))
>> +			string_list_insert(delayed_paths, =
xstrdup(path));
>=20
> I am assuming that the caller passes an empty string list to
> delayed_paths variable (shouldn't it be called available_paths, or
> ready_paths if we follow the earlier discussion above, by the way?),
> and it will compare the resulting set with the set of paths that got
> "delayed" response in the apply_multi_file_filter() function earlier.

Correct. I also agree with the rename although it seems a bit odd to=20
name the function "...available_blobs" and the variable =
"available_paths".
The paths itself are not "available" anyways. They just represent
the blobs that are available. Therefore it should be OK and it probably
better than just "paths".


> I am wondering whose responsibility it will be to deal with a path
> "list-available" reports that are *not* asked by Git or Git got no
> "delayed" response.  The list subtraction done by the caller is
> probably the logical place to do so.

Correct. Git (the caller) will notice that not all "delayed" paths
are listed by the filter and throw an error at the end.

>=20
>> diff --git a/entry.c b/entry.c
>> index d6b263f78e..c6d5cc01dc 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -137,6 +137,85 @@ static int streaming_write_entry(const struct =
cache_entry *ce, char *path,
>> ...
>> +static int remove_available_paths(struct string_list_item *item, =
void *cb_data)
>> +{
>> +	struct string_list *available_paths =3D cb_data;
>> +	return !string_list_has_string(available_paths, item->string);
>> +}
>> +
>> +int finish_delayed_checkout(struct checkout *state)
>> +{
>> +	int errs =3D 0;
>> +	struct string_list_item *filter, *path;
>> +	struct delayed_checkout *dco =3D state->delayed_checkout;
>> +
>> +	if (!state->delayed_checkout)
>> +		return errs;
>> +
>> +	dco->state =3D CE_RETRY;
>> +	while (dco->filters.nr > 0) {
>> +		for_each_string_list_item(filter, &dco->filters) {
>> +			struct string_list available_paths;
>> +			string_list_init(&available_paths, 0);
>=20
> STRING_LIST_INIT_NODUP?

Of course!

>=20
>> +
>> +			if (!async_query_available_blobs(filter->string, =
&available_paths)) {
>> +				/* Filter reported an error */
>> +				errs =3D 1;
>> +				filter->string =3D "";
>> +				continue;
>> +			}
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
> 	/*
>         * Our multi-line comments
> 	 * look like this.
> 	 */

Oops. Will fix.

BTW: In [1] you mentioned that you run checkpatch. Would checkpatch
catch this kind of error? If yes, is your version publicly available?

[1] =
http://public-inbox.org/git/xmqq1ste2zwu.fsf@gitster.mtv.corp.google.com/


>> +				filter->string =3D "";
>> +				continue;
>> +			}
>> +
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
> We first remove from the outstanding request list (dco->paths) what
> are now ready...
>=20
>> +			for_each_string_list_item(path, =
&available_paths) {
>=20
> ...and go over those paths that are now ready.
>=20
>> +				struct cache_entry* ce =3D =
index_file_exists(
>> +					state->istate, path->string,
>> +					strlen(path->string), 0);
>> +				assert(dco->state =3D=3D CE_RETRY);
>> +				errs |=3D (ce ? checkout_entry(ce, =
state, NULL) : 1);
>> +			}
>=20
> But we never checked if the contents of this available_paths list is
> a subset of the set of paths we originally asked the external
> process to filter.

Correct.

>  This will allow the process to overwrite any
> random path that is not even involved in the checkout.

No, not "any random path". Only paths that are part of the checkout.
There are three cases:

(1) available_path is a path that was delayed before (=3D happy case!)
(2) available_path is a path that was not delayed before,=20
    but filtered (=3D no problem, as filtering is a idempotent =
operation)
(3) available_path is a path that was neither delayed nor filtered
    before (=3D if the filter returns the blob as-is then this would
    be no problem. otherwise we would indeed have a screwed checkout)

Case 3 might introduce a problem if the filter is buggy. =20
=20
Would you be OK with this check to catch case 3?

    dco_path_count =3D dco->paths.nr;
    filter_string_list(&dco->paths, 0,
        &remove_available_paths, &available_paths);

    if (dco_path_count - dco->paths.nr !=3D available_paths.nr) {
        /* The filter responded with entries that have not
         * been delay earlier. Do not ask the filter
         * for available blobs, again, as the filter is
         * likely buggy. This will generate an error at=20
         * the end as some files are not filtered properly.
         */
        filter->string =3D "";
        error(_("The external filter '%s' responded with "
            "available blobs which have not been delayed "
            "earlier."), filter->string);
        continue;
    }


>> +		}
>> +		string_list_remove_empty_items(&dco->filters, 0);
>> +	}
>> +	string_list_clear(&dco->filters, 0);
>> +
>> +	/* At this point we should not have any delayed paths anymore. =
*/
>> +	errs |=3D dco->paths.nr;
>> +	for_each_string_list_item(path, &dco->paths) {
>> +		warning(_("%s was not filtered properly."), =
path->string);
>> +	}
>> +	string_list_clear(&dco->paths, 0);
>=20
> And "list-available" that says "path X is ready" when we never asked
> for X gets away free without detected as a bug, either.

With the addition above it would!


Thanks for the review :-)

- Lars=
