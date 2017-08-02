Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C701208B5
	for <e@80x24.org>; Wed,  2 Aug 2017 01:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbdHBBvU (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 21:51:20 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49793 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751368AbdHBBvT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Aug 2017 21:51:19 -0400
X-AuditID: 1207440d-a1fff70000000c0c-4b-598130163dd6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.30.03084.61031895; Tue,  1 Aug 2017 21:51:18 -0400 (EDT)
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com [209.85.214.48])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v721pGXc007927
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 1 Aug 2017 21:51:17 -0400
Received: by mail-it0-f48.google.com with SMTP id 77so16712305itj.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 18:51:17 -0700 (PDT)
X-Gm-Message-State: AIVw112H8V2DHFL+JTDlMgkZUIyz2haHSoHo7QrwUY8/li9zT9/1KQaD
        sVBJkJzUHAe+EalNL4/7s1pYVYotkQ==
X-Received: by 10.36.117.204 with SMTP id y195mr4055331itc.34.1501638676630;
 Tue, 01 Aug 2017 18:51:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Tue, 1 Aug 2017 18:51:14 -0700 (PDT)
In-Reply-To: <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com> <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Tue, 1 Aug 2017 18:51:14 -0700
X-Gmail-Original-Message-ID: <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
Message-ID: <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqCtm0BhpcHmDhEXXlW4mB0aPz5vk
        AhijuGxSUnMyy1KL9O0SuDI+nj/MVnDYteLZ4wmMDYwzTLsYOTkkBEwkVi2/y9TFyMUhJLCD
        SWL5vFcsEM5DJoljX/+wQji9jBJvjk5mhWjJl9j9qI0Rwi6RODDhBTOIzSsgKHFy5hMWEFtI
        QE7i1YYbQDUcQLaXRONnSxCTUyBQYsseE4iRdxgl5navYwcpZxPQlVjU08wEYrMIqEhsmdoB
        tSpRYvbMI1DjAyRmvV7OBmILCxhJdFzYBxYXEVCT2H6hB+xOZoGpjBLHZhwDK2IW0JRo3f6b
        fQKj8Cwk581CklrAyLSKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIySMeXcw
        /l8nc4hRgINRiYeXo70hUog1say4MvcQoyQHk5Ior2JPfaQQX1J+SmVGYnFGfFFpTmrxIUYJ
        DmYlEd5yvcZIId6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK83SKNg
        UWp6akVaZk4JQpqJgxNkOA/Q8ASw4cUFibnFmekQ+VOMlhxXrqz7wsQx5cB2INn0/eN3JiGW
        vPy8VClx3ge6QA0CIA0ZpXlwM2Fp6RWjONCLwryfQMbyAFMa3NRXQAuZgBZKltaCLCxJREhJ
        NTDKZqjcEK1Z5JapYDLF+Pnyu/bnP0yfs2vCNIai2kufm/881Qlx35/T6vvp5aYtQVYXput/
        ubpjKg9HW/DzyQsei3tXVD+c3u41ceIjMw7NAqGTjkF+c0/x7DoV25HZ4tcRdr27gmnGL4sz
        i97UVB889n3Kjmq/o2cF18of3Xn0FnNssY+Yf6SqEktxRqKhFnNRcSIAJwlQAyYDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 4:27 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>> 4th iteration of the reftable storage format.
>>> [...]
>>
>> Before we commit to Shawn's reftable proposal, I wanted to explore
>> what a contrasting design that is not block based would look like.
>
> I forgot to look at a 1k chunk size, as you suggested that might also
> be suitable. Here is the more complete experiment table:
>
>        | size   | seek_cold | seek_hot  |
> mh  1k | 29.4 M | 20.6 usec | 10.7 usec |   <== Row fixed
> mh  4k | 28.3 M | 24.5 usec | 14.5 usec |
> sp  4k | 29.2 M | 63.0 usec |  5.8 usec |
> sp 64k | 27.7 M | 35.6 usec | 23.3 usec |

At least in this case, the 1k block size seems like a good tradeoff.
Did 1k vs 4k change the number of index levels required?

> A couple of other notes about your contrasting design:
>
>>     elif chunk_type == INDEX {
>>         chunk_length : varint
>
> Using a varint for the chunk length made for a complicated reader.
> JGit doesn't have the luxury of mmap to access the file, so we have to
> allocate a byte[] and read data from a file descriptor to do anything
> fancy like decoding a varint. For my experiment I wound up just
> hardcoding the IO to read 1k or 4k from whatever address.
>
> A "real" implementation would likely prefer to read a fixed width
> field here such that chunks have a 3 byte header (1 byte chunk_type, 2
> byte chunk_length), and then issue a second read to acquire the rest
> of the chunk. Given that encoding a chunk length of 1024 or 4096 both
> requires 2 bytes of varint, its always going to be 2 bytes in your
> design anyway. With the way chunks are scanned, I don't think you want
> chunks as large as 16k, which would have caused the varint to go to 3
> bytes (but still fits in a fixed 2-byte chunk_length).

That's a good point for INDEX and OBJS_INDEX blocks. Though for REFS
blocks that include reflogs, the block size has to be large enough to
hold the whole reflog for a reference, which can be arbitrarily large.
(Maybe this is a weakness of the design?) OBJS blocks can also be
unbounded in size if very many references point at the same object,
thought that is perhaps only a theoretical problem.

> My reftable proposal should still do well in a mmap region. Most of
> the cold start penalty for reftable is JGit copying the ref index from
> the file descriptor to the memory block where we can parse the format.
> That is why the cold_seek time declines for a larger block size, the
> index is smaller.
>
>
>>         first_child : {
>>             refname : varstr
>>             index_payload
>>         }
>>         other_children : {
>>             # Length of prefix being carried over from the previous
>>             # record:
>>             prefix_len : varint
>>             suffix : varstr
>>             index_payload
>
> Having no prefix_len on first_child made for a slightly funkier
> parser. It does save you a byte, but the parser has to know if its
> looking at the first child, or an other_children to know if it should
> expect the prefix_len. Its a simple condition, but it kind of grated
> on me when I wrote that particular section of the experiment. For the
> majority of records the parser considers, the prefix_len is always
> present.
>
> That is why I proposed the restart_offsets point to the prefix_len,
> and prefix_len = 0 at restart points. It slightly simplified the
> parser.

Yes, that seems like a reasonable compromise.

>>     elif chunk_type == OBJS_INDEX {
>>         chunk_length : varint
>>
>>         # The offset, relative to the start of this chunk, of the
>>         # chunk containing the next level of the obj index, for each
>>         # of the possible "next" bytes in the SHA-1, or zero if there
>>         # are no references with the given next byte.
>>         child_offset : varint * 256
>
> This is space saving and cute, but kind of annoying. If it was fixed
> width 32 bit you can address up to 4G away from this chunk's address,
> and you can directly jump to the byte of interest. By being varints
> you do save a little space, as most files will probably only need 3
> byte varints, and the 0s do collapse down to 1 byte, but you have to
> linearly walk the list to find any specific byte.

The reason I used varint here was mostly because I expect the lowest
level of the OBJS_INDEX to be placed close to the OBJS chunks that it
refers to; hopefully within a 2-byte varint. Let me consider more
carefully whether that is realistic...

An OBJS_INDEX should be well under 1kB in size. The lowest-level
OBJS_INDEX will presumably be relatively but not totally full
(otherwise you'd add another OBJS_INDEX level); suppose 1/2 of its
entries are filled. Most of those entries should contain only a single
SHA-1.

An obj_record will typically be 3 bytes plus the size of one
`child_addr`. The latter is in the earlier part of the file, but for
your 30 MB example, that will probably be 4 bytes per address. So the
total size of the obj_records would be about 7 bytes * 128 which is
also less than a kB.

So a 2-byte varint should be more than enough for child_offset for the
lowest-level OBJS_INDEXes (which in turn are by far the most common
types of OBJS_INDEXes). And if the OBJ_INDEX is less full, the zeros
can be stored in one byte.

Indeed, it might make sense to special-case the lowest-level
OBJS_INDEX chunk type to use uint16 pointers and store the obj_records
directly in the chunk, following the child_offsets.

The higher-level OBJS_INDEXes might have to point further away. I
think it would be a bad idea to limit reftable file sizes to 4 GB,
though maybe it's not unreasonable to limit the OBJS_INDEX part of the
file to that size so that a uint32 to be used?

Peff and I discussed off-list whether the lookup-by-SHA-1 feature is
so important in the first place. Currently, all references must be
scanned for the advertisement anyway, so avoiding a second scan to vet
SHA-1s received from the client is at best going to reduce the effort
by a constant factor. Do you have numbers showing that this
optimization is worth it?

OTOH a mythical protocol v2 might reduce the need to scan the
references for advertisement, so maybe this optimization will be more
helpful in the future?

>> ref_payload = {
>>     value_type : enum NO_VALUE
>>                     | DELETED
>>                     | VALUE | VALUE_PEELED
>>                     | SYMREF | SYMREF_PEELED
>>                     | SPECIAL
>>     log_type : enum NO_REFLOG | REFLOG | REFLOG_COMPRESSED
>>     symref_target : bool
>
> FWIW I didn't implement log_type or symref_target in my experiment, so
> the size per ref was maybe a few bytes smaller than what you outlined
> here.

But value_type, log_type, and symref_target should all fit within a
single byte, no?

>>     # This field is used to keep backwards links from references to
>>     # any symrefs that point at them, to make it tractable to update
>>     # the reflog of the symref if the reference is changed directly:
>>     if symref_target {
>>         referer : varstr
>>         varint(0)
>>     }
>
> I wonder how desirable this feature is. Most updates are done through
> HEAD, which is a symref and can therefore update both HEAD and the
> target's reflogs in the same operation. It seems to me its rare to
> issue an update directly on the ref that HEAD points at. Its even
> rarer to have a non-HEAD symbolic reference whose reflog you expect to
> track something else.
>
> Is this for refs/remotes/origin/HEAD to be a symref and have its
> reflog mirror the fetch operations that touched the underlying ref?

What I was thinking is that we don't update symrefs' reflogs correctly
if the pointed-to reference is updated (except for HEAD) and it would
be nice to fix that problem. Your case of `refs/remotes/origin/HEAD`
is an example. Or on GitHub's servers, if we wanted to store all of
the forks of a repo in a single repository, we might want to use a
namespace for each fork, like `refs/forks/NNNN/*`, and store the
fork's default branch in `refs/forks/NNNN/HEAD`. The current refs code
wouldn't know to update such a symref's reflog (though of course it
could be special-cased in like HEAD is now).

That's what I was thinking. But I've yet to hear anybody complain
about missing reflogs for symrefs if the underlying reference is
updated directly, so maybe we should just leave that "problem"
unsolved. It is certainly simpler and less brittle not to have to keep
backreferences like these in sync with the forward references.

Michael
