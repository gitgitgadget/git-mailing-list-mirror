Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E2082027C
	for <e@80x24.org>; Sun, 16 Jul 2017 17:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdGPReE (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 13:34:04 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:44421 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751216AbdGPReB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Jul 2017 13:34:01 -0400
X-AuditID: 1207440e-6b5ff70000002a7d-16-596ba3877c0c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B6.A1.10877.783AB695; Sun, 16 Jul 2017 13:33:59 -0400 (EDT)
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com [209.85.214.51])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v6GHXw6E019373
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 13:33:59 -0400
Received: by mail-it0-f51.google.com with SMTP id l132so4041877ita.1
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 10:33:58 -0700 (PDT)
X-Gm-Message-State: AIVw111x9lXWVpg0+yF51b7o82HbiUHGMx1j2w8TdRzjTnLrzWjeVQS3
        ZjTscgyDjjYVIxOVU2Sd/DvkDIdidg==
X-Received: by 10.36.118.80 with SMTP id z77mr2402189itb.53.1500226436766;
 Sun, 16 Jul 2017 10:33:56 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.16.36 with HTTP; Sun, 16 Jul 2017 10:33:55 -0700 (PDT)
In-Reply-To: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Sun, 16 Jul 2017 10:33:55 -0700
X-Gmail-Original-Message-ID: <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com>
Message-ID: <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1G1fnB1p8LTTyqLrSjeTA6PH501y
        AYxRXDYpqTmZZalF+nYJXBkrrtgVdD9irPhz8DJ7A+PMLYxdjJwcEgImEmd7XrB0MXJxCAns
        YJKYO+cyM4TziEni8J0vbCBVQgJ9jBJbTwZDdORL3D73H6iDA8gukli5zQ4kzCsgKHFy5hMW
        iHI5iVcbbjBC2F4SazsfsIPYnAKBEkc+v2MEaRUSCJDY+4cTJMwmoCuxqKeZCcRmEVCVuLPw
        MdRtiRJ/Hi4F28QLVP7rDwdIWBio/MXHLWCbRATUJLZf6GEFKWEWkJV4fFYVJMwsoCnRuv03
        +wRG4VlIbpuFJLWAkWkVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkj48u1g
        bF8vc4hRgINRiYf3RnJWpBBrYllxZe4hRkkOJiVR3ots2ZFCfEn5KZUZicUZ8UWlOanFhxgl
        OJiVRHitpgPleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvFsWATUK
        FqWmp1akZeaUIKSZODhBhvMADb8DUsNbXJCYW5yZDpE/xWjJceXKui9MHFMObAeSTd8/fmcS
        YsnLz0uVEucNA2kQAGnIKM2DmwlLR68YxYFeFOYtBqniAaYyuKmvgBYyAS1sy8oAWViSiJCS
        amBc+fT1V9VFjhXazOv2evod+tDhM3vqXSP5Pfrha1Zw+nH1rF6XMm/9hiDVA1rNGXLOE7rn
        Bz20Ne959jlht7bokS3KC0Q6u9pWr39+4OlCeb3yAA8fm37zJHvzGwlf50h8FNVR33tkw0d7
        J55ZkX25JhnvXh69/HSp8Lw6wYMe0697csj/MPZTYinOSDTUYi4qTgQAu9M76SIDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your reftable proposal. It would solve a lot of scalability
problems that we currently have, and do it in a way that is
implementable in both C and Java, which is very nice.

There are two mostly orthogonal components to your proposal:

1. What does a single reftable file look like?
2. How can multiple reftable files be used together to avoid having to
rewrite data more than necessary?

For example (just for the sake of argument), many of the goals could
be achieved by stacking traditional packed-refs files together (i.e.,
component 2 of your proposal), with the single extension that a
packed-refs file can assign some "nil" value to a reference to
indicate that the reference has been deleted. As long as references
are sought in packed-refs files using binary search, lookup and
iteration would both be O(n + lg N) (where N is the total number of
references and n is the number being iterated over), and updates would
(I think) be amortized O(n), where n is the number of references being
updated or deleted. Stacked packed-refs files would, of course, not
yield the compression benefits of your reftable proposal.

Overall comments/questions:

* Do you propose to store *all* references (i.e., including the
references that we call pseudorefs, like `HEAD`, `FETCH_HEAD`, etc) in
reftables, or only the references under `refs/`? If the former, then
you need to consider that some pseudorefs contain additional
information besides the SHA-1 or linked-to reference. If the latter,
then you could get some additional compression by making the `refs/`
prefix implicit rather than storing it in the "restart" records
explicitly.

  Personally, I don't think it makes sense to store pseudorefs in
reftables. HEAD, though it doesn't include any supplemental
information, is read so frequently that it seems like a bad idea to
have to go through the lookup process rather than storing it in a
separate flat file. Moreover, HEAD is written very *infrequently*, so
(absent special treatment) it would tend to sink deep in the reftable
stack, making reads even more expensive.

* You have obviously designed your proposal to be friendly to whatever
non-local storage system you are using at Google. It would probably
help us understand your design tradeoffs better if you could tell us a
little about that storage system.

So let's examine the components one after the other...

1. The structure of a single reftable file

* You use int32 and int24 values in a number of places. Couldn't these
be uint32 and uint24?

* You use int32 values in a number of places where a smaller size
would suffice. For example, the block size is limited to 24 bits, so
surely restart_offset, record_end_offset, and number_of_restarts
needn't be larger than 24 bits?

   OK, actually the *index* block size is not limited to 24 bits, so
it's not a no-brainer.

* I'm a little bit concerned that the structure is fixed to be a one-
or two-level indexing scheme; i.e., the (optional) index block plus
the restart index table within a block. This forces (as I understand
it) the block size to be chosen based on the overall file size to
prevent the index block from becoming too large, whereas for a
low-latency local filesystem implementation like SSDs it would
probably be preferable to set the block size to agree with the page
size to minimize reads and memory usage.

  So I ask myself whether it might be worthwhile to allow deeper
levels of indexing. The main index block could divide the namespace
into as many segments as fit in one block, but if necessary point at a
second-level index block that further divides the namespace before
pointing at the ref block that ultimately contains the value. Those of
us using local SSDs might tune the system to use 4k block sizes
throughout, basically preferring to read three or even four disjoint
4k blocks rather than two disjoint 64k blocks.

* The tuning parameter number_of_restarts currently trades off space
(for the full refnames and the restart_offsets) against the need to
read and parse more ref_records to get the full refnames. ISTM that
this tradeoff could be made less painful by defining a blockwide
prefix that is omitted from the refnames as used in the restarts. So
the full refname would change from

      this_name = prior_name[0..prefix_length] + suffix

  to

      this_name = block_prefix + prior_name[0..prefix_length] + suffix

  I would expect this to allow more frequent restarts at lower space
cost. Combining this idea with the previous idea, non-top-level index
blocks could also have a block_prefix to make their restarts cheaper,
too.

  If we are willing to force all reads to consider the indexes, the
block_prefix could be taken from the index_record that points at it.

* Does the format need to insist on fixed-size blocks? The alternative
would be to allow index_records to point at arbitrary offsets in the
file. Admittedly, the file offsets would take more bits to store them
than the block_idx. But it would allow the blocks to be matched better
to the logical structure of the refs namespace, making the
block_prefix work better and making it easier to find a particular
namespace in one jump. For example, you could add an extra top-level
index entry for the HEAD branch, on the assumption that it will be
read frequently. You could also add an entry for `refs/replace`, which
is read for almost every command invocation. You could even add an
entry for `refs/replace` and an entry for the first reference
following `refs/replace`, which would allow the client to determine
that there are zero `refs/replace` references (the usual case) from
the top-level index alone by seeing that the two offsets are
identical.

  BTW, just because the file format doesn't insist on fixed-size
blocks wouldn't mean that particular implementations couldn't choose
to write fixed-size blocks, as your implementation might do. If this
is an important use case, the extra bits needed to store arbitrary
file offsets could be avoided by allowing a filewide offset_multiplier
to be defined.

* What is the rationale for the footer? Is it important for the file
to be written as a stream, as opposed to seeking back to the beginning
of the file to add the index_size there? The CRC, I suppose, is meant
to make it possible to detect a file that has been truncated
accidentally?

2. The stacking of multiple reftable files together

* I like the ideas later in the thread to have a file of pointers to
the files that make up the stack. (I think of it as a "table of
contents"). I think without it there will be unavoidable races
involving readdir().

* The spec should describe the protocol for reading references. The
only interesting thing here is that

* I think that geometric repacking of reftable files will be essential
to performance for very active repositories with many references, and
that the steady state of such a repository will involve O(lg N)
retable files.

* I would like to propose adding another design goal: that reference
repacking can be done without blocking other *writers* (let alone
readers, obviously). I think that something like this could work:

  Suppose the stack currently consists of reftable files (from oldest
to newest) A, B, C, and D, with table-of-contents file reftable. If I
want to repack files B and C together, then I

  * Obtain lock reftable.lock and read the file.
  * Obtain locks B.lock and C.lock. My ownership of these locks
prevents other processes from trying to repack these files.
  * Release reftable.lock.
  * Repack B and C into a new file, X.lock.
  * Obtain lock reftable.lock.
  * Verify that B, and C are still in the stack, in that order. This
should always be the case, assuming that other processes are adhering
to the locking protocol.
  * Rename X.lock to X.
  * Write the new stack to reftable.lock, replacing B and C with X.
  * Rename reftable.lock on top of reftable.
  * Delete B and C (perhaps after a short sleep to avoid forcing
readers to backtrack).

  I think that this algorithm would allow reference updates to
continue while the repack is happening, and would even allow reftables
higher or lower in the stack than B and C to be repacked at the same
time (though maybe that won't be necessary).

* A very frequent operation will be to read a single reference. This
could get expensive if a reftable stack grows deep, because every
single reftable might have to be inspected. One way to reduce this
cost might be to store a bloom filter in large reftable files. This
could allow a quick determination that the file doesn't contain the
reference being sought.

I haven't reviewed your proposal for storing reflogs in reftables in
any detail, though I must say that my first reaction is surprise that
you want to store reflogs (which are mostly immutable, rarely read,
and can be an order of magnitude bigger) in the same files as
references.

Michael

On Wed, Jul 12, 2017 at 5:17 PM, Shawn Pearce <spearce@spearce.org> wrote:
> We've been having scaling problems with insane number of references
> (>866k), so I started thinking a lot about improving ref storage.
>
> I've written a simple approach, and implemented it in JGit.
> Performance is promising:
>
>   - 62M packed-refs compresses to 27M
>   - 42.3 usec lookup
>
> You can read a rendered version of this here:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>
>
> ## Overview
>
> ### Problem statement
>
> Some repositories contain a lot of references (e.g.  android at 866k,
> rails at 31k).  The existing packed-refs format takes up a lot of
> space (e.g.  62M), and does not scale with additional references.
> Lookup of a single reference requires linearly scanning the file.
>
> Atomic pushes modifying multiple references require copying the
> entire packed-refs file, which can be a considerable amount of data
> moved (e.g. 62M in, 62M out) for even small transactions (2 refs
> modified).
>
> Repositories with many loose references occupy a large number of disk
> blocks from the local file system, as each reference is its own file
> storing 41 bytes.  This negatively affects the number of inodes
> available when a large number of repositories are stored on the same
> filesystem.  Readers are also penalized due to the larger number of
> syscalls required to traverse and read the `$GIT_DIR/refs` directory.
>
> ### Objectives
>
> - Near constant time lookup for any single reference, even when the
>   repository is cold and not in process or kernel cache.
> - Occupy less disk space for large repositories.
> - Support atomic pushes with lower copying penalities.
>
> ### Description
>
> A reftable file is a portable binary file format customized for
> reference storage. References are sorted, enabling linear scans,
> binary search lookup, and range scans.
>
> Storage in the file is organized into blocks.  Prefix compression
> is used within a single block to reduce disk space.  Block size is
> tunable by the writer.
>
> ### Performance
>
> Space used, packed-refs vs. reftable:
>
> repository | packed-refs | reftable | % original | avg ref
> -----------|------------:|---------:|-----------:|---------:
> android    |      62.2 M |   27.7 M |     44.4%  | 33 bytes
> rails      |       1.8 M |  896.2 K |     47.6%  | 29 bytes
> git        |      78.7 K |   27.9 K |     40.0%  | 43 bytes
> git (heads)|       332 b |    204 b |     61.4%  | 34 bytes
>
> Scan (read 866k refs) and lookup (single ref from 866k refs):
>
> format      | scan    | lookup
> ------------|--------:|---------------:
> packed-refs |  380 ms | 375420.0 usec
> reftable    |  125 ms |     42.3 usec
>
> ## Details
>
> ### Peeling
>
> References in a reftable are always peeled.
>
> ### Reference name encoding
>
> Reference names should be encoded with UTF-8.
>
> ### Ordering
>
> Blocks are lexicographically ordered by their first reference.
>
>
> ## File format
>
> ### Header
>
> A 8-byte header appears at the beginning of each file:
>
> - 4-byte magic is: `\'1', 'R', 'E', 'F'`
> - 1-byte version number, `1`.
> - 3-byte `block_size` in bytes (network byte order).
>
> ### Block size
>
> The `block_size` is arbitrarily determined by the writer, and does not
> have to be a power of 2.  The block size must be larger than the
> longest reference name used in the repository, as references cannot
> span blocks.
>
> ### First block
>
> The first block shares the same block as the file header, and is 8
> bytes smaller than all other blocks in the file.  The first block
> immediately begins after the file header, at offset 8.
>
> ### Block format
>
> A block is written as:
>
>     ref_record*
>     padding?
>     int32( restart_offset )*
>     int32( record_end_offset )
>     int32( number_of_restarts )
>
> Blocks begin with a variable number of `ref_record`, describing
> reference names and values. The format is described below.
>
> The middle of the record may be filled with `padding` NUL bytes to
> fill out the block to the common `block_size` as specified in the file
> header.  Padding may be necessary to ensure `number_of_restarts`
> occupies the last 4 bytes of the block.  Padding may be omitted if the
> block is the last block of the file, and there is no index block.
> This allows reftable to efficiently scale down to a small number of
> refs.
>
> A variable number of 4-byte, network byte order `restart_offset`
> values follows the padding.  Offsets are relative to the start of the
> block and refer to the first byte of any `ref_record` whose name has
> not been prefixed compressed.  Readers can start linear scans from any
> of these records.
>
> The 4-byte, network byte order `record_end_offset` follows, providing
> the block-relative offset after the end of the last `ref_record`.  If
> `padding` is present this is the offset of the first byte of padding,
> or the first byte of the first `restart_offset` entry.
>
> The 4-byte, network byte order `number_of_restarts` stores the number
> of entries in the `restart_offset` list.  Readers can use the restart
> count to binary search between restarts before starting a linear scan.
> This field must be the last 4 bytes of the block; the `padding` field
> must be used to ensure this is true.
>
> #### ref record
>
> A `ref_record` describes a single reference, storing both the name and
> its value(s). Records are formatted as:
>
>     varint( prefix_length )
>     varint( (suffix_length << 2) | type )
>     suffix
>     value?
>
> The `prefix_length` field specifies how many leading bytes of the
> prior reference record's name should be copied to obtain this
> reference's name.  This must be 0 for the first reference in any
> block, and also must be 0 for any `ref_record` whose offset is listed
> in the `restart_offset` table at the end of the block.
>
> Recovering a reference name from any `ref_record` is a simple concat:
>
>     this_name = prior_name[0..prefix_length] + suffix
>
> The second varint carries both `suffix_length` and `type`.  The
> `suffix_length` value provides the number of bytes to copy from
> `suffix` to complete the reference name.
>
> The `value` immediately follows.  Its format is determined by `type`,
> a 2 bit code, one of the following:
>
> - `0x0`: deletion; no value data (see transactions, below)
> - `0x1`: one 20-byte object id; value of the ref
> - `0x2`: two 20-byte object ids; value of the ref, peeled target
> - `0x3`: symbolic reference: `varint( target_len ) target`
>
> Symbolic references use a varint length followed by a variable number
> of bytes to encode the complete reference target.  No compression is
> applied to the target name.
>
> ### Index block
>
> The index stores the name of the last reference from every block in
> the file, enabling constant O(1) disk seeks for all lookups.  Any
> reference can be found by binary searching the index, identifying the
> containing block, and searching within that block.
>
> If present, the index block appears after the last block of the file.
>
> An index block should only be written if there are at least 4 blocks
> in the file, as cold reads using the index requires 2 disk reads, and
> binary searching <= 4 blocks also requires <= 2 reads.  Omitting the
> index block from smaller files saves space.
>
> Index block format:
>
>     '\1' 'i'
>     index_record*
>     int32( restart_offset )*
>     int32( record_end_offset )
>     int32( number_of_restarts )
>
> Index blocks begin with a magic prefix, `\1i`, where other blocks
> would have started with `\0` for the first ref record's prefix length.
> This supports stopping sequential scans at the index block, without
> prior knowledge of its position.
>
> Unlike other blocks, the index block is not padded.
>
> The `restart_offset`, `record_end_offset`, and `number_of_restarts`
> fields are identical in format, meaning and usage as in `ref_record`.
>
> To reduce the number of reads required for random access in very large
> files, the index block may be larger than the other blocks.  However,
> readers must hold the entire index in memory to benefit from this, so
> its a time-space tradeoff in both file size, and reader memory.
> Increasing the block size in the writer decreases the index size.
>
> #### index record
>
> An index record describes the last reference of another block.
> Index records are written as:
>
>     varint( prefix_length )
>     varint( (suffix_length << 2) )
>     suffix
>     varint( block_idx )
>
> Index records use prefix compression exactly like `ref_record`.  The
> `suffix_length` is shifted 2 bits without a `type` to simplify unified
> reader/writer code for both block types.
>
> Index records store `block_idx` after the suffix, specifying which
> block of the file ends with this reference. The block is located at
> position `block_idx * block_size`.
>
> ### Reading the index
>
> Readers loading the index must first read the footer (below) to
> determine `index_size`.  The index is located at position:
>
>     file_length - (index_size + 16)
>
> ### Footer
>
> After the last block of the file (or index block, if present), a file
> footer is written.  This is similar in structure to the file header,
> but extended with additional data.
>
> A 16-byte footer appears at the end:
>
> - 4-byte magic is: `\'1', 'R', 'E', 'F'`
> - 1-byte version number, 1.
> - 3-byte `block_size` in bytes (network byte order).
> - 4-byte `index_size` in bytes (network byte order).
> - 4-byte CRC-32 of the preceding 12 bytes (network byte order).
>
> Like the index block magic header, the footer begins with `\1R` to
> allow sequential scans to recognize the end of file has been reached.
>
> #### Reading the footer
>
> Readers must seek to `file_length - 16` to access the footer.  A
> trusted external source (such as `stat(2)`) is necessary to obtain
> `file_length`.  When reading the footer, readers must verify:
>
> - 4-byte magic is correct
> - 1-byte version number is recognized
> - 4-byte CRC-32 matches the other 12 bytes read
>
> Once verified, the `block_size` and `index_size` may be accessed from
> the footer.
>
> ### Varint encoding
>
> Varint encoding is identical to the ofs-delta encoding method used
> within pack files.
>
> Decoder works such as:
>
>     val = buf[ptr] & 0x7f
>     while (buf[ptr] & 0x80) {
>       ptr++
>       val++
>       val = val << 7
>       val = val | (buf[ptr] & 0x7f)
>     }
>
> ### Binary search
>
> Binary search within a block is supported by the `restart_offset`
> fields at the end of the block.  Readers can binary search through the
> restart table to locate between which two restart points the sought
> reference should appear.
>
> Each reference identified by a `restart_offset` stores the complete
> reference name in the `suffix` field of the `ref_record`, making the
> compare operation during the binary search straightforward.
>
> Once a restart point lexicographically before the sought reference has
> been identified, readers can linearly scan through the following
> `ref_record` entries to locate the sought reference, stopping when the
> current `ref_record` sorts after (and therefore the sought reference
> is not present).
>
> #### Restart point selection
>
> Writers determine the restart points at file creation.  The process is
> arbitrary, but every 16 or 64 references is recommended.  Every 16 may
> be more suitable for smaller block sizes (4k or 8k), every 64 for
> larger block sizes (64k).
>
> More frequent restart points reduces prefix compression and increases
> space consumed by the restart table, both of which will increase the
> overall file size.
>
> Less frequent restart points makes prefix compression more effective,
> decreasing overall file size, with increased penalities for readers
> who must walk through more references after the binary search step.
>
> ## Considerations
>
> ### Lightweight refs dominate
>
> The reftable format assumes the vast majority of references are single
> SHA-1 valued with common prefixes, such as Gerrit Code Review's
> `refs/changes/` namespace, GitHub's `refs/pulls/` namespace, or many
> lightweight tags in the `refs/tags/` namespace.
>
> Annotated tags storing the peeled object cost only an additional 20
> bytes per reference.
>
> ### Low overhead
>
> A reftable with very few references (e.g.  git.git with 5 heads) uses
> only 204 bytes for reftable vs.  332 bytes for packed-refs.  This
> supports reftable scaling down, to be used for transaction logs
> (below).
>
> ### Block size
>
> For a Gerrit Code Review type repository with many change refs, larger
> block sizes (64 KiB) and less frequent restart points (every 64) yield
> better compression due to more references within the block able to
> compress against the prior reference.
>
> Larger block sizes reduces the index size, as the reftable will
> require fewer blocks to store the same number of references.
>
> ### Minimal disk seeks
>
> Assuming the index block has been loaded into memory, binary searching
> for any single reference requires exactly 1 disk seek to load the
> containing block.
>
> ## Repository format
>
> When reftable is stored in a file-backed Git repository, the stack is
> represented as a series of reftable files:
>
>     $GIT_DIR/reftable
>     $GIT_DIR/reftable.1
>     $GIT_DIR/reftable.2
>     $GIT_DIR/reftable.3
>     ...
>     $GIT_DIR/reftable.10
>
> where a larger suffix ordinal indicates a more recent table.
>
> ### Transactions
>
> Although reftables are immutable, they can be stacked in a search
> pattern, with each reference transaction adding a new reftable to the
> top of the stack.  Readers scan down the reftable stack from
> most-recent (`reftable.10`) to the base file (`reftable`).
>
> ### Update process
>
> Updating references follows an update protocol:
>
> 1. Atomically create `$GIT_DIR/reftable.lock`.
> 2. `readdir($GIT_DIR)` to determine the highest suffix ordinal, `n`.
> 3. Compute the update transaction (e.g. compare expected values).
> 4. Write only modified references as a reftable to `reftable.lock`.
> 5. Rename `reftable.lock` to `reftable.${n + 1}`.
>
> Because a single `reftable.lock` file is used to manage locking, the
> repository is single-threaded for writers.  Writers may have to
> busy-spin (with some small backoff) around creating `reftable.lock`,
> for up to an acceptable wait period, aborting if the repository is too
> busy to mutate.  Application servers wrapped around repositories (e.g.
> Gerrit Code Review) can layer their own in memory thread lock/wait
> queue to provide fairness.
>
> ### Reference deletions
>
> Deletion of any reference can be explicitly stored by setting the
> `type` to `0x0` and omitting the `value` field of the `ref_record`.
> This entry shadows the reference in lower files in the stack.
>
> ### Compaction
>
> A stack of reftables can be compacted by merging references using a
> straightforward merge join across all reftables, selecting the most
> recent value for output, and omitting deleted references that do not
> appear in remaining, lower reftables.
>
> The stack can be collapsed as part of any update transaction.  If the
> current number of files is larger than a threshold (e.g.  4), writers
> can perform an lstat(2) on each reftable file to determine how many
> bytes would have to be read/copied from an existing file into the
> new file, enabling deletion of the existing file.
>
> Writers can select to collapse the most recent files (e.g.  10, 9, 8,
> ...), up to a collapse IO threshold (e.g.  4 MiB).  Each file selected
> for collapse must have its references merged into the new reftable
> that is being prepared.
>
> Compaction is similar to the update process, but an explicit temporary
> file must be used:
>
> 1. Atomically create `$GIT_DIR/reftable.lock`.
> 2. `readdir($GIT_DIR)` to determine the highest suffix ordinal, `n`.
> 3. Compute the update transaction (e.g. compare expected values).
> 4. Select files from (2) to collapse as part of this transaction.
> 5. Create temp file by `mktemp("$GIT_DIR/.reftableXXXXXX")`.
> 6. Write modified and collapsed references to temp file.
> 7. Rename temp file to `reftable.${n + 1}`.
> 8. Delete collapsed files `reftable.${n}`, `reftable.${n - 1}`, ...
> 9. Delete `reftable.lock`.
>
> Because `reftable.9` can disappear after `reftable.10` is created,
> readers receiving ENOENT when opening `reftable.9` must peform
> another readdir to look for new reftables.
>
> Rebuilding the base `$GIT_TABLE/reftable` follows the same protocol,
> except in step 7 the temp file is renamed to `reftable`, and step 8
> removes all files with an ordinal suffix.
>
> ## Alternatives considered
>
> ### bzip packed-refs
>
> `bzip2` can significantly shrink a large packed-refs file (e.g. 62
> MiB compresses to 23 MiB, 37%).  However the bzip format does not support
> random access to a single reference. Readers must inflate and discard
> while performing a linear scan.
>
> Breaking packed-refs into chunks (individually compressing each chunk)
> would reduce the amount of data a reader must inflate, but still
> leaves the problem of indexing chunks to support readers efficiently
> locating the correct chunk.
>
> Given the compression ratios achieved by reftable's simple encoding
> (e.g.  44%), without using a standard compression algorithm, it does
> not seem necessary to add the complexity of bzip/gzip/zlib.
>
> ### JGit Ketch RefTree
>
> [JGit Ketch][ketch] proposed [RefTree][reftree], an encoding of
> references inside Git tree objects stored as part of the repository's
> object database.
>
> The RefTree format adds additional load on the object database storage
> layer (more loose objects, more objects in packs), and relies heavily
> on the packer's delta compression to save space.  Namespaces which are
> flat (e.g.  thousands of tags in refs/tags) initially create very
> large loose objects, and so RefTree does not address the problem of
> copying many references to modify a handful.
>
> Flat namespaces are not efficiently searchable in RefTree, as tree
> objects in canonical formatting cannot be binary searched. This fails
> the need to handle a large number of references in a single namespace,
> such as GitHub's `refs/pulls`, or a project with many tags.
>
> [ketch]: https://dev.eclipse.org/mhonarc/lists/jgit-dev/msg03073.html
> [reftree]: https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/
>
> ### LMDB
>
> David Turner proposed [using LMDB][dt-lmdb], as LMDB is lightweight
> (64k of runtime code) and GPL-compatible license.
>
> A downside of LMDB is its reliance on a single C implementation.  This
> makes embedding inside JGit (a popular reimplemenation of Git)
> difficult, and hositing onto virtual storage (for JGit DFS) virtually
> impossible.
>
> A common format that can be supported by all major Git implementations
> (git-core, JGit, libgit2) is strongly preferred.
>
> [dt-lmdb]: https://public-inbox.org/git/1455772670-21142-26-git-send-email-dturner@twopensource.com/
>
> ## Future
>
> ### Longer hashes
>
> Version will bump (e.g.  2) to indicate `value` uses a different
> object id length other than 20.  The length could be stored in an
> expanded file header, or hardcoded as part of the version.
