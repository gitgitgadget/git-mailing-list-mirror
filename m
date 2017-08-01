Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A0020899
	for <e@80x24.org>; Tue,  1 Aug 2017 06:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdHAGp3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 02:45:29 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62554 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751295AbdHAGp2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Aug 2017 02:45:28 -0400
X-AuditID: 12074413-655ff70000000aee-5f-598022b4c16a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.F7.02798.4B220895; Tue,  1 Aug 2017 02:41:56 -0400 (EDT)
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com [209.85.223.179])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v716ftr6013268
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 1 Aug 2017 02:41:56 -0400
Received: by mail-io0-f179.google.com with SMTP id m88so4548451iod.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 23:41:55 -0700 (PDT)
X-Gm-Message-State: AIVw110UxWp9GFx1ty8gguNU1PaPxqOVT3/OFYylBYMqTvTogA/IwDeH
        Vn1SsdzM827pYCKz3NSmqeeDzFbO/A==
X-Received: by 10.107.187.129 with SMTP id l123mr20307619iof.122.1501569715057;
 Mon, 31 Jul 2017 23:41:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Mon, 31 Jul 2017 23:41:54 -0700 (PDT)
In-Reply-To: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Mon, 31 Jul 2017 23:41:54 -0700
X-Gmail-Original-Message-ID: <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
Message-ID: <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1N2i1BBpsHSPtkXXlW4mB0aPz5vk
        AhijuGxSUnMyy1KL9O0SuDJW7W5lLWgpq+jdMIW9gfFZSBcjJ4eEgIlE79xe9i5GLg4hgR1M
        Ervf3WKBcJ4wScy8uZEJwuljlHg+7Q4bREu+xLym86wQdrnE3MMtYDavgKDEyZlPWEBsIQE5
        iVcbbjB2MXIA2d4SD36BlXAKBEr8/DMbqiRA4ue1BUwgNpuArsSinmYwm0VAVeLYv3ksEOMT
        JdbM28cEMT5AYuuUNrC4sICRRMeFfcwgtoiAmsT2Cz2sIHcyC0xllDg24xjYncwCmhKt23+z
        T2AUnoXkvFlIUgsYmVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihISx8A7G
        XSflDjEKcDAq8fB2mNZHCrEmlhVX5h5ilORgUhLlVewBCvEl5adUZiQWZ8QXleakFh9ilOBg
        VhLhrZFoiBTiTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwblcEahQs
        Sk1PrUjLzClBSDNxcIIM5wEa/gKkhre4IDG3ODMdIn+K0ZjjypV1X5g4phzY/oVJiCUvPy9V
        SpzXGaRUAKQ0ozQPbhosFb1iFAd6Tpi3GaSKB5jG4Oa9AlrFBLRKsrQWZFVJIkJKqoHRvvnJ
        /quFExb679ZjLP6/xiUg8zlviN3Jw7HvYpk3pAVeya0J2GzlfKJv3VJjZ8st/9ds3qt1ef4D
        ++Cw1jVLiko6VhUs0Xt9mvW77+u5/1jaa2NsRPdv7N7BevSRdVuTxa+pmyt/W832i3t6+Oqv
        W0fyZrNM+/Pgo/6fCw75LkoPHwUWMsWWKbEUZyQaajEXFScCAEapU40gAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
> 4th iteration of the reftable storage format.
> [...]

Before we commit to Shawn's reftable proposal, I wanted to explore
what a contrasting design that is not block based would look like. So
I threw together a sketch of such a design. It is not as refined as
Shawn's, and I haven't had time to program an implementation or
collect statistics, but maybe it is interesting anyway.

The design benefits from a lot of Shawn's ideas, plus a lot of the
discussion from the mailing list. First let me explain in words the
major differences and why I think they might be promising.

It seems to me that the block-orientation of Shawn's spec adds a lot
of complication to the design (e.g., padding, optional blocks, varying
block sizes for different parts of the file). It also seems that the
format has been heavily optimized to be read in 64k blocks, whereas
most users will be storing their references to local hard disks or
(increasingly) to local SSDs. So I tried to come up with a design that
is friendlier to the latter, hopefully without being much worse for
the former.

One thing that I realized is that, assuming that reference values and
reflogs are usually compacted separately, there will basically be
three types of reftable files:

1. Accumulated references and their values (potentially very large)

2. Accumulated reflogs (potentially gigantic)

3. Recent transaction(s), which include both refs and reflogs (usually
   quite small).

The first two types of file don't benefit from separating reference
data from reflog data in the file (because they only include one or
the other). The third kind of file doesn't care because such files
will be small.

So let's store all of the data related to a single reference in one
spot. This simplifies the file format and removes the need for two
separate indexes and/or variants that special-case the omission of an
index. A disadvantage is that, it prevents compression of reflog
entries across references. I think that is a reasonable tradeoff,
because most reflog entries (in the repositories I checked; that might
differ in Gerrit-managed repos) correspond to references that have
been updated many times. To partly compensate for the resulting
reduction in compression, I added some features to reduce the storage
of redundant information in reflog entries.

I also wanted to support multiple-level indexes, so that one isn't
forced to choose rather large blocksizes for repositories with lots of
references.

On the other hand, this design does not support binary searching for
refnames. Instead, the refnames are distributed into a multiple-level
tree. When looking for a reference, each tree node on the way to the
reference needs to be parsed serially. But the nodes are small enough
(due to the multilevel indexing scheme) that I hope that isn't a
problem. I'd rather read less data at the expense of parsing a little
bit more.


The primary data structure consists of `INDEX` and `REFS` chunks.
Basically the `INDEX` chunks are interior nodes of the tree, and the
`REFS` chunks are the leaf nodes. But both types of nodes are N-way.

* Prefix compression occurs within a single node chunk, but not across
  nodes. In that way, the node chunks are analogous to a restart plus
  the subsequent prefix-compressed references in Shawn's design (but
  they will typically be bigger).

* A chunk must be read and processed serially to make sense of it.
  Chunks are also the unit of addressing.

* Indexes can be multi-level to keep each level of the tree small.
  This reduces the total amount of data that needs to be read to
  access a reference, but might require an additional seek if the
  required index chunks are not close together.

* Node chunks can be read serially starting at any chunk without
  referring to any index. Also, data are always written in order by
  reference name, both within single chunks and regarding the ordering
  of multiple `REFS` chunks. So references can be iterated over
  without regard to the indexes.

* I feel like the size of a chunk should be roughly 1-4 kiB, and will
  usually fit in one disk block (though it might cross disk blocks,
  requiring two to be read).

* Multiple related chunks can be stored in a 64 kiB block (interesting
  for people who prefer to read files in 64k segments). By storing
  related chunks near each other, the number of seeks will probably
  typically be smaller than the number of chunks that have to be
  accessed.

* Padding can be added between any two chunks (e.g., to avoid
  splitting chunks across 64 kiB blocks), but it is entirely optional
  and probably would not be used for data stored on local storage.

* In many cases, cross-references between chunks are relative, so that
  they can be stored compactly using varint encoding. This is more
  important than in Shawn's proposal because we don't have block
  indexes, so we have to store arbitrary disk offsets.

* The file can be written in two possible ways: with cross-references
  between chunks always pointing to later parts of the file (probably
  preferable if the data will be read from a local hard disk) or
  always pointing to earlier parts of the file (to accomodate writers
  who need to write their data in order). See the `offsets_negative`
  field in the header. (I'm not sure that the former variant is
  actually needed.)

Because we don't have blocks, it is more difficult to store the object
references compactly. I've arranged them in a radix-256 tree with
relative references. The lowest internal nodes are stored sparsely,
and contain absolute references that point at the containing chunk.


Definitions:

Varint encoding is similar to the unsigned varint encoding used for
protocol buffers; i.e., a little-endian base-128 format where the most
significant bit is used to indicate that another byte is coming.
Decoding is as follows:

```
val = *ptr & 0x7f
while (*ptr++ & 0x80) {
    val = (val << 7) | (*ptr & 0x7f)
}
```

Strings are usually encoded using `varstr` encoding, which is the same
as how strings are encoded in protocol buffers. A `varstr` consists of
a `varint` length followed by the specified number of bytes holding
the contents of the string. `varstr` strings are not intrinsically
NUL-terminated.

The `chunk_length` fields encode the total size of the containing
chunk, including its `chunk_type` field.

```
varstr(s) = {
    varint(strlen(s))
    s
}
```

```
reftable = {
    header

    # The choice to order ref_chunks before obj_chunks is not crucial
    # to the design, but probably makes sense.
    [ref_chunk | padding]*
    [obj_chunk | padding]*

    footer
}

header = {
    'REFT'
    uint8( version_number = 1 )

    # if `contains_values` is false, this file *must not* contain any
    # reference values; i.e., `value_type` must always be `NO_VALUE`.
    contains_values : bool

    # if `contains_logs` is false, this file *must not* contain any
    # reflog entries; i.e., `log_type` must always be `NO_REFLOG`.

    contains_logs : bool

    # If `offsets_negative` is true, then all `*_offset` fields point
    # backwards in the file; i.e., the corresponding varint value is
    # negated before use.
    offsets_negative : bool

    min_update_index : uint64
    max_update_index : uint64

    # To accomodate systems that have to write files serially, the
    # following two entries can be zeroed out in the header to tell
    # the reader that it has to read the corresponding values from the
    # footer.

    # The file offset of the chunk containing the root of the
    # reference tree:
    ref_root_chunk_addr : uint64

    # The file offset of the chunk containing the root of the object
    # tree. This value must be zero if `contains_values` is false:
    obj_root_chunk_addr : uint64
}

footer = {
    header
    uint32(CRC-32 of previous part of footer)
}

chunk = {
    # The `chunk_type` determines how to interpret the payload, and
    # influences how to compute its length (which is needed to advance
    # to the next chunk).

    chunk_type : enum PAD_BYTE | PADDING
                    | INDEX | REFS
                    | OBJS_INDEX | OBJS

    if chunk_type == PAD_BYTE {
        # This chunk type can be used to add a single byte of padding,
        # which would otherwise be impossible because a `PADDING`
        # chunk requires a minimum of two bytes.
    }
    elif chunk_type == PADDING {
        # A form of padding that's cheaper to skip over than
        # `PAD_BYTE`.

        # The total number of bytes in this chunk, including
        # `chunk_type`. The contents will otherwise be ignored:

        chunk_length : varint
    }
    elif chunk_type == INDEX {
        chunk_length : varint
        first_child : {
            refname : varstr
            index_payload
        }
        other_children : {
            # Length of prefix being carried over from the previous
            # record:
            prefix_len : varint
            suffix : varstr
            index_payload
        }*
    }
    elif chunk_type == REFS {
        chunk_length : varint
        first_ref : {
            refname : varstr
            ref_payload
        }*
        other_refs : {
            # Length of prefix being carried over from the previous
            # record:
            prefix_len : varint
            suffix : varstr
            ref_payload
        }*
    }
    elif chunk_type == OBJS_INDEX {
        chunk_length : varint

        # The offset, relative to the start of this chunk, of the
        # chunk containing the next level of the obj index, for each
        # of the possible "next" bytes in the SHA-1, or zero if there
        # are no references with the given next byte.
        child_offset : varint * 256
    }
    elif chunk_type == OBJS {
        chunk_length : varint
        obj_record*
    }
}
```

```
index_payload = {
    # The number of bytes from the begining of this chunk to the child
    # chunk. If child_offset is zero, then there are no entries in
    # this reftable whose refnames start with the specified prefix.
    #
    # The child pointed at is of type INDEX (another index chunk
    # containing the next finer level of detail) or of type REFS. In
    # either case, the first record in the pointed-to chunk must have
    # `prefix_len == 0` and contain the entire key as `suffix`.
    child_offset : varint
}

ref_payload = {
    value_type : enum NO_VALUE
                    | DELETED
                    | VALUE | VALUE_PEELED
                    | SYMREF | SYMREF_PEELED
                    | SPECIAL
    log_type : enum NO_REFLOG | REFLOG | REFLOG_COMPRESSED
    symref_target : bool

    if value_type == NO_VALUE {
        # This type is used if we need to store a reflog entry but
        # have no reference value to store in this file.
    }
    elif value_type == DELETED {
        # This type indicates that the reference has been deleted,
        # regardless of what any reftables deeper in the stack claim.
    }
    elif value_type == VALUE {
        # This is a normal (non-symbolic) reference.
        sha1 : uchar[20]
    }
    elif value_type == VALUE_PEELED {
        # This is a normal (non-symbolic) reference that points at a
        # tag. `peeled` is the reference peeled down to a non-tag.
        sha1 : uchar[20]
        peeled : uchar[20]
    }
    elif value_type == SYMREF {
        # This is a symref that points at a non-existent branch.
        target : varstr
    }
    elif value_type == SYMREF_PEELED {
        # This is a symref that points at a branch that has the
        # specified value.
        target : varstr
        peeled : uchar[20]
    }
    elif value_type == SPECIAL {
        # This is one of the special references (like FETCH_HEAD,
        # MERGE_HEAD). The contents are stored as they would be in a
        # loose reference file:
        contents : varstr
    }

    # This field is used to keep backwards links from references to
    # any symrefs that point at them, to make it tractable to update
    # the reflog of the symref if the reference is changed directly:
    if symref_target {
        referer : varstr
        varint(0)
    }

    if log_type == NO_REFLOG {
    }
    elif log_type == REFLOG {
        log_entry_length : varint
        log_entry
    elif log_type == REFLOGS_COMPRESSED {
        zlib_length : varint
        zlib_deflate(
            log_entry*
        )
    }
}

# Log entries are stored from oldest to newest. The "chained" variants
# of `log_type` take their `new_id` from the current value of the
# reference (if it is the first log entry for the references) or from
# the preceding (i.e., next newest) log record's `old_id` value.
log_entry = {
    # `CREATE_CHAINED` and `UPDATE_CHAINED` take their `new_id` from
    # the preceding (i.e., next newest) record's `old_id` value.
    log_type : enum END_OF_LOG | LOG
    old_type : enum ABSENT | REF | SYMREF
    new_type : enum ABSENT | REF | SYMREF | CHAINED

    if log_type != END_OF_LOG {
        # The update_index of this entry, or 0 if there are no more entries:
        update_index : varint

        # `PUSHER_CHAINED` takes its `name` and `email` from the preceding
        # (i.e., next newest) record's fields.
        pusher_type : enum PUSHER_EXPLICIT | PUSHER_CHAINED

        if new_type == ABSENT {
        }
        elif new_type == REF {
            new_id : uchar[20]
        }
        elif new_type == SYMREF {
            new_ref : varstr
        }
        elif new_type == CHAINED {
        }

        if old_type == ABSENT {
        }
        elif old_type == REF {
            old_id : uchar[20]
        }
        elif old_type == SYMREF {
            old_ref : varstr
        }

        time_seconds : uint32
        tz_offset_minutes : sint16
        if pusher_type == PUSHER_EXPLICIT {
            name : varstr
            email : varstr
        }

        # The reflog message. For a bit more compression:
#
# * Many messages contain old/new SHA-1s for the reference
#   updates. That redundancy could be eliminated by replacing
#   the old SHA-1 with `%o`, the new one with `%n`, and `%`
#   with `%%`.
        #
        # * Some "standard" log messages (i.e., the ones generated by
#   Git itself) could be hard-coded as additional `log_type`
#   constants.
        message : varstr
    }
}

obj_record = {
    # The "next" two bytes of the SHA-1 being described:
    bytes : uchar[2]

    # The number of of child_addrs:
    count : varint

    # File offsets of the chunks containing references that point at
    # objects with this prefix:
    child_addr+ : varint
}
```

Michael
