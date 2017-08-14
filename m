Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E966720899
	for <e@80x24.org>; Mon, 14 Aug 2017 12:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbdHNMNb (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 08:13:31 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56965 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753083AbdHNMN3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Aug 2017 08:13:29 -0400
X-AuditID: 1207440e-743ff70000000b23-e7-599193e8dfbc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 40.B2.02851.8E391995; Mon, 14 Aug 2017 08:13:28 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC431.dip0.t-ipconnect.de [87.188.196.49])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7ECDOVV005239
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 14 Aug 2017 08:13:26 -0400
Subject: Re: reftable [v6]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <7271a556-8aaf-ae69-8b45-45efbc5f91a5@alum.mit.edu>
Date:   Mon, 14 Aug 2017 14:13:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqPti8sRIg+XbzC1O91xht+i60s1k
        0dB7hdniR0sPs8Xmze0sFvMPTWR1YPNYsKnU41nvHkaPi5eUPf6c38Pq8XmTXABrFJdNSmpO
        Zllqkb5dAlfG7893mQtOJlZc7fvI2MC4wreLkYNDQsBEYuWTqC5GLg4hgR1MEusvdrBAOOeZ
        JFobv7F2MXJyCAsYSRye9J8RpEFEIFXi5fdCkDCzQI3ErZavzCC2kECAxML7c9hBbDYBXYlF
        Pc1MIDavgL3Es7Nv2EBsFgFViXmdJ1lAbFGBCIm+t5fZIWoEJU7OfAIW5xQIlFg7r5UJYr66
        xJ95l5ghbHGJW0/mQ8XlJba/ncM8gVFgFpL2WUhaZiFpmYWkZQEjyypGucSc0lzd3MTMnOLU
        ZN3i5MS8vNQiXWO93MwSvdSU0k2MkPDn28HYvl7mEKMAB6MSD6/D1QmRQqyJZcWVuYcYJTmY
        lER5E3x6I4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8Ca1T4wU4k1JrKxKLcqHSUlzsCiJ86ot
        UfcTEkhPLEnNTk0tSC2CycpwcChJ8HoC41xIsCg1PbUiLTOnBCHNxMEJMpwHaPiMSSDDiwsS
        c4sz0yHypxiNOTpm/PzGxNH0/eN3JiGWvPy8VClx3jKQUgGQ0ozSPLhpsBT2ilEc6Dlh3sMg
        VTzA9Ac37xXQKiagVX0gP/IWlyQipKQaGBvr3k2T+R/94nOSx/MferEHiqzLVq0QMDnWOcd9
        NaNM4uJww8k5cT+4v9xym3e/dFfGOetjMbG9wZ3p339a3Y8+/edLRujOkuVz/Z6+vFScOYc1
        duOpj/t05qxWmivy2lt2n55738JCg3j3/4yGkyO6Cv5faxNofFFoEpez0/bDRtaypMfzpymx
        FGckGmoxFxUnAgAEMKD7PAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/07/2017 03:47 AM, Shawn Pearce wrote:
> 6th iteration of the reftable storage format.

Thanks!

> Changes from v5:
> - extensions.refStorage = reftable is used to select this format.
> 
> - Log records can be explicitly deleted (for refs/stash).
> - Log records may use Michael Haggerty's chained idea to compress before zlib.
>   This saved ~5.8% on one of my example repositories.

Meh. Do you think that's worth the complexity? The percentage savings
will presumably be even lower for repositories that store significant
information in their reflog messages.

> [...]
> #### ref record
> 
> A `ref_record` describes a single reference, storing both the name and
> its value(s). Records are formatted as:
> 
>     varint( prefix_length )
>     varint( (suffix_length << 3) | value_type )
>     suffix
>     value?
> 
> [...]
> - `0x0`: deletion; no value data (see transactions, below)
> - `0x1`: one 20-byte object id; value of the ref
> - `0x2`: two 20-byte object ids; value of the ref, peeled target
> - `0x3`: symref and text: `varint( text_len ) text`
> 
> Symbolic references use `0x3` with a `text` string starting with `"ref: "`,
> followed by the complete name of the reference target.  No
> compression is applied to the target name.  Other types of contents
> that are also reference like, such as `FETCH_HEAD` and `MERGE_HEAD`,
> may also be stored using type `0x3`.

I'm still relatively negative on storing "other" references (except
`HEAD`) in reftable. Here are my thoughts:

* "Other" references are not considered for reachability, so there
  is no need for their modification to be done atomically.

* "Other" references don't have or need reflogs.

* The refs API would have to provide a way for other Git code to
  read and write "other" references including their extra
  information, and the users of that information would have to
  be rewritten to use the new API.

* Presumably there are other programs in the wild (e.g., scripts)
  that want to read that information. They wouldn't be able to
  extract it from reftable files themselves, so we would also have
  to provide a command-line tool to read (and write?) such files.

> Types `0x4..0x7` are reserved for future use.

Regardless, I suggest allocating separate `value_type`s for generic
symrefs (which then wouldn't need a `ref: ` prefix) vs. for "other"
references.

> [...]
> ### Ref index

It wasn't clear to me whether (in the case of a multi-level index) ref
index blocks have to be aligned in `block_size` blocks (both their
maximum size and their alignment). I don't see a reason for that to be
required, though of course a compactor implementation might choose to
block-align these blocks based on the filesystem that is in use.

For that matter, I don't see an intrinsic reason that object blocks or
object index blocks need to be block aligned.

In fact, the only way I can see that the current reftable proposal makes
use of `block_size` is so that `obj_record`s can record `block_delta` in
units of `block_size` rather than in units of bytes. (And given that I'm
skeptical about the value of the object index, that justification seems
thin.)

I totally accept that *you* want to align your blocks, and I'm totally
supportive of a format that permits a reftable compactor to write
reftables that are block-aligned. It just still seems to me that it
imposes more complexity than necessary on *other* reftable compactor
implementations that don't care about block alignment.

Aside from the object index, I think it would be straightforward to
write a reftable reader that is totally ignorant of `block_size`.

So unless I've overlooked something, I think the following plan wouldn't
cause you any extra trouble, but would make it easier to implement a
compactor that doesn't care about block sizes or object indexes:

If a reftable has an object index, then `block_size` must be specified,
and ref blocks *must* be aligned to start at multiples of `block_size`.

However, if a reftable has no object index, then its `block_size` is
only a hint about the typical block size; e.g., "if you want to read a
full block, then try reading `block_size` and you'll probably get the
whole thing". And if `block_size` is zero, then readers get no guidance
about the typical block size (which would be just fine for an mmap-based
reader).

Essentially, choices about block alignment would become a
quality-of-implementation issue for reftable compactors, and readers
would hardly need to care.

> [...]
> #### index record
> 
> An index record describes the last entry in another block.
> Index records are written as:
> 
>     varint( prefix_length )
>     varint( (suffix_length << 3) | 0 )
>     suffix
>     varint( block_position )
> 
> Index records use prefix compression exactly like `ref_record`.
> 
> Index records store `block_position` after the suffix, specifying the
> absolute position in bytes (from the start of the file) of the block
> that ends with this reference.

Is there a reason that the index lists the *last* refname that is
contained in a block rather than the *first* refname? I can't think of a
reason to choose one vs. the other, but your choice was initially
surprising. I don't think it matters either way; I was just curious.

Do I understand correctly that all `block_position`s are *byte*
addresses, even in the `ref_index` where they should all be multiples of
the block size (except the zeroth one)? I think that's OK, but note that
it will waste more than a byte per `ref_index` and `obj_index` record,
on average.

> Readers must examine the block header at `block_position` to determine
> if the next block is another level index block, or the leaf-level ref
> block.

For scanning through a whole namespace, like `refs/tags/`, I guess you
only need to use a binary search to find the beginning of the range.
Then you would read serially forwards from there, continuing from one
`ref_block` to the next, until you find a refname that doesn't start
with `refs/tags/`. In other words, there is no reason to binary search
to find the end of the namespace, correct? [1]

The same approach would be used to scan the reflog of a reference.

[1] I suppose binary searching to find the end of the namespace might be
useful for a high-latency filesystem, as you could initiate a pre-fetch
for all of the storage blocks that are expected to be needed rather than
initiating the read of the next block only after having processed the
previous block.

> [...]
> #### log record
> [...]
>     log_chained {
>       old_id
>       varint( time_seconds )
>       not_same_committer {
>         sint16( tz_offset )
>         varint( name_length    )  name
>         varint( email_length   )  email
>       }?
>       not_same_message {
>         varint( message_length )  message
>       }?
>     }
> ```
> 
> Log record entries use `log_type` to indicate what follows:
> 
> - `0x0`: deletion; no log data.
> - `0x1`: standard git reflog data using `log_data` above.
> - `0x2..0x3`: reserved for future use.
> - `0x4..0x7`: `log_chained`, with conditional members.
> 
> [...]
> For `log_type = 0x4..0x7` the `log_chained` section is used instead to
> compress information that already appeared in a prior log record.  The
> `log_chained` always includes `old_id` for this record, as `new_id` is
> implied by the prior (by file order, more recent) record's `old_id`.
> 
> The `not_same_committer` block appears if `log_type & 0x1` is true,
> `not_same_message` block appears if `log_type & 0x2` is true.  When
> one of these blocks is missing, its values are implied by the prior
> (more recent) log record.

Just to make sure that we are on the same page...

`old_id` and `new_id` in adjacent reflog entries are not always
identical. If you run `git reflog expire` or `git reflog delete` without
the `--rewrite` option, then the to-be-deleted entries are just dropped
without changing the neighboring entries to chain together again.

This would have to be supported in your proposal by writing a full
`log_data` record for the entry following such a gap.

> [...]
> #### Importing logs
> 
> When importing from `$GIT_DIR/logs` writers should globally order all
> log records roughly by timestamp while preserving file order, and
> assign unique, increasing `update_index` values for each log line.
> Newer log records get higher `update_index` values.
> 
> Although an import may write only a single reftable file, the reftable
> file must span many unique `update_index`, as each log line requires
> its own `update_index` to preserve semantics.

Thinking out loud here: A really high-quality importer might want to
group together, under the same `update_index`, ref updates that are
thought originally to have been done in the same transaction.

* Only group entries with the same timestamps and log messages
  should be grouped together.

* There should not be more than one update to a particular
  reference in a single transaction.

* Ideally, it would avoid creating states between `update-index`es
  where references D/F-conflict with each other. (Given that reflogs
  can be expired, this is not always possible in the general case.)

* It could theoretically even reconstruct "branch rename" operations
  that required temporary reference names into a single `update_index`.

But I doubt that it is worth the effort. (The whole idea gives me nasty
flashbacks from working on cvs2svn/cvs2git.)

> [...]
> ### Layout
> 
> The `$GIT_DIR/refs` path is a file when reftable is configured, not a
> directory.  This prevents loose references from being stored.
> 
> A collection of reftable files are stored in the `$GIT_DIR/reftable/`
> directory:
> 
>     00000001_UF4paF
>     00000002_bUVgy4
> 
> where reftable files are named by a unique name such as produced by
> the function:
> 
>     mktemp "${update_index}_XXXXXX"

Please note that if reflogs are compacted into a separate "reflog-only"
file, then the same `update_index` might appear in the filename of both
a "reflog-only" file and a value-only file. I don't think that this is a
problem, but we shouldn't bake assumptions about uniqueness into the system.

I'm a little bit worried that users might automatically think that a
filename that includes a string like `UF4paF` is a temporary file and
"clean it up" (with disastrous consequences). It might be prudent to
give the files names that don't look so garbagy.

And wouldn't it be nice to tack a filename extension onto the end of
these filenames to make them more easily recognizable?

> The stack ordering file is `$GIT_DIR/refs` and lists the current
> files, one per line, in order, from oldest (base) to newest (most
> recent):
> 
>     $ cat .git/refs
>     00000001_UF4paF
>     00000002_bUVgy4
> 
> Readers must read `$GIT_DIR/refs` to determine which files are
> relevant right now, and search through the stack in reverse order
> (last reftable is examined first).
> 
> Reftable files not listed in `refs` may be new (and about to be added
> to the stack by the active writer), or ancient and ready to be pruned.

It might be good to think about how readers should work. The easy
implementation would be:

1. Open and read the `refs` file
2. Open each of the reftable files that it mentions
3. If any of the files is missing, goto 1 (with some checks to avoid
   infinite loops).
4. Read from the now-open files as long as you need to.

This would give you a self-consistent snapshot of the global reference
state. However, a long-running program (especially one dealing with
reachability) might want to check at strategic moments that the `refs`
file hasn't changed out from under it while it was running, or even lock
the `refs` file during critical operations.

It would be possible to avoid opening all of the reftable files right
away in the hope that the reference that you seek is in one of the top
few files. But this quickly gets tricky because you might read some
references from the top reftable, then need to dig deeper for another
reference only to find out that one of the deeper files is no longer in
the stack. So in one program run you might end up seeing reference
values from two different snapshots.

> [...]

Michael
