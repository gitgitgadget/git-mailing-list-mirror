From: Shawn Pearce <spearce@spearce.org>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 2 Apr 2012 10:27:47 -0400
Message-ID: <CAJo=hJuVZiik6J0nhO4jpzWYenerRQoREHLMmJoFY8W0bZR+5A@mail.gmail.com>
References: <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
 <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
 <87iphrjv23.fsf@thomas.inf.ethz.ch> <CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
 <CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
 <CACsJy8BjYLAKqFDeGRyUj+SDKOTRbjW8shomhnhORM082HM9yw@mail.gmail.com>
 <CAKTdtZkSEs7Z+0NrfEaFDt-LJEPCLg5FhHgSGAsF32gqQB+DCg@mail.gmail.com> <20120402123146.GA24813@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: elton sky <eltonsky9404@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 16:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEiEx-0005CB-Pg
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 16:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab2DBO2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 10:28:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38036 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab2DBO2I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 10:28:08 -0400
Received: by pbcun15 with SMTP id un15so4601625pbc.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jDaq5yoSZ/ErV4VKz5mVdZ9fSM5eDb8mOqkw4YDk/Wk=;
        b=T4s5bJUMEhGkgNk9rVzIg1HtOWc+kTkmJ5gxzcFqmcaAwjdfcLme20Sx2V+rFAXAiH
         yZRnxKkBqlP/hs79WpVI71KER1fvdiD5eV6+PFP4Wc8Tn1iVP1SZ5jFvjVNuwZqMtiKu
         FPSdeNC0HlQimJOI9ghhofyt0R1FoUaRVhW4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=jDaq5yoSZ/ErV4VKz5mVdZ9fSM5eDb8mOqkw4YDk/Wk=;
        b=aqLNn9FtcfYwPBNFkvxgt8dHCcDmUugfQEeXK8iDvIHj714s8GjEFVx+S86Dz/0f+B
         5KVl63T5Pocid8ZrlOQVkC7+X4pX6cwRcGMVur6M/mVtFIGiVcWxJrxbmvD3ByT21VLO
         940fg+usDQa5fXLSH7Lh5Y/H3FJBY1yZ56+LsL6N08y712CN1Jia6s5Gqxl7fNsRPl1m
         DmSaa4dCni/Fll+2/Xbo0AwvC6TyLVidlsTxQVlkVvOCDxqErQcjUhtKq94ef0rHjvtU
         rNfRQMbQnbgJh+V4o5ySf83UBCq81eWxwtMcTyjec4AnY2WdwyoTQSzqLFgbdAR3oFkZ
         1xHw==
Received: by 10.68.193.170 with SMTP id hp10mr2482001pbc.65.1333376888065;
 Mon, 02 Apr 2012 07:28:08 -0700 (PDT)
Received: by 10.68.237.201 with HTTP; Mon, 2 Apr 2012 07:27:47 -0700 (PDT)
In-Reply-To: <20120402123146.GA24813@do>
X-Gm-Message-State: ALoCoQnFH0hf0hjRmG0OZ3hQwDU3aw8W1wIXmS+yjh4yvltfeB71cdchLH2oTsQh1r8d0YfXpJUh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194514>

On Mon, Apr 2, 2012 at 08:31, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> -- 8< --
> GIT index format
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This format replaces the old "DIRC" format. Compared to the old
> format, which is essentially a sorted list of pathnames, this one:
>
> =A0- is tree-based
> =A0- use crc32 as checksum
> =A0- only verify integrity on parts that git accesses, instead of who=
le
> =A0 file
> =A0- append changes to the end
> =A0- allow index versioning
>
> Updates can be made directly to the index by appending to the end. Th=
e
> index traversed by locating the root tree block from the trailer. Whe=
n
> a path is updated, all related tree blocks are updated and appended t=
o
> the end, then a new trailer (with generation increased by one) is
> written to conclude the index.
>
> The index size will increase continuously. At some point, we will nee=
d
> to repack it. Let assume a tree block is 64k on average and a path
> generally consists of 3 path components. =A0That means an entry updat=
e
> adds 192k and we can do about 80 updates before index reaches 16M (in
> addition to initial index size).

Only 3 path components? Java sources can easily have 8-10 with a long
Maven and Java package implied prefix. This will increase the
frequency of rewrites of the index file.

> At 16M or when trailer generation hits a limit (the limit can be
> configurable), we rewrite the index to reduce its size. Some heavy
> operations can also be used to rewrite index, such as checkout or
> reset.
>
> The index integrity is verified by crc32. One crc32 covers header and
> trailer. Each block has its own crc32. When the index is found
> corrupt, we could try to roll back to latest good version by looking
> for trailers from bottom up. Even when the index is not corrupt, user=
s
> can still look back this way for older index versions.

How do you deal with a partially written append to the index file?
E.g. if a prior update crashes or the filesystem doesn't write
everything out before power failure, you need to find the last good
trailer block in the file.

> =3D The git index file has the following format
>
> =A0 - A 8-byte header consisting of
>
> =A0 =A0 4-byte signature:
> =A0 =A0 =A0 The signature is { 'T', 'R', 'E', 'E' }
>
> =A0 =A0 4-byte version number:
> =A0 =A0 =A0 The current supported versions are 1.

Why not DIRC version 4?

> =A0 - A number of blocks of variable size
>
> =A0 =A0 =A01-byte block type
>
> =A0 =A0 =A03-byte content size in byte
>
> =A0 =A0 =A0block content

So you are limiting the size of a canonical tree now? Currently there
is no limit on the size a tree. But here the entire index structure
plus set of names must be under 16 MiB. Granted no project probably
hits that limit, but you are painting us into a corner with an upper
limit here that doesn't look like it will be easy to increase.

> =A0 =A0 =A04-byte crc32 of all above
>
> =A0 - A 18-byte trailer consisting of
>
> =A0 =A0 =A04-byte trailer signature:
> =A0 =A0 =A0 =A0The signature is { 'R', 'O', 'O', 'T' }
>
> =A0 =A0 =A02-byte generation:
> =A0 =A0 =A0 =A0 The first trailer is 0, the second 1 and so on.
>
> =A0 =A0 =A04-byte root block offset
>
> =A0 =A0 =A04-byte extension table offset:
> =A0 =A0 =A0 =A0Zero means no extension
>
> =A0 =A0 =A04-byte checksum:
> =A0 =A0 =A0 =A0CRC32 of the header and the trailer (excluding this fi=
eld)

See above my question about how to find the last good trailer if the
last append attempt was incomplete.

> =3D=3D Tree block
>
> =A0A tree block contains a (maybe invalid) tree object and extra
> =A0information of its companion in working directory. Tree block has
> =A0block type 'T'.
>
> =A0Tree block content is basically the list of non-recursive entries =
in
> =A0specified path, with all attributes we store in the index now. The=
re
> =A0are a few changes though to intergrate cache-tree and allow
> =A0bsearch() on mmap'd block.
>
> =A0A tree block content consists of
>
> =A0- 4-byte tree object size
>
> =A0- 20-byte SHA-1 of the cached tree object
>
> =A0- a list attributes corresponding to tree object's item, in the sa=
me
> =A0 =A0order. =A0These attributes are the same as in DIRC entry forma=
t
> =A0 =A0except that entry name is removed, and a tree block offset is
> =A0 =A0added in case the item is a directory.
>
> =A0 =A032-bit ctime seconds, the last time a file's metadata changed
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit ctime nanosecond fractions
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit mtime seconds, the last time a file's data changed
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit mtime nanosecond fractions
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit dev
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit ino
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit mode, split into (high to low bits)
>
> =A0 =A0 =A04-bit object type
> =A0 =A0 =A0 =A0valid values in binary are 1000 (regular file), 1010 (=
symbolic link)
> =A0 =A0 =A0 =A0and 1110 (gitlink)
>
> =A0 =A0 =A03-bit unused
>
> =A0 =A0 =A09-bit unix permission. Only 0755 and 0644 are valid for re=
gular files.
> =A0 =A0 =A0Symbolic links and gitlinks have value 0 in this field.
>
> =A0 =A032-bit uid
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit gid
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit file size
> =A0 =A0 =A0This is the on-disk size from stat(2), truncated to 32-bit=
=2E
>
> =A0 =A0160-bit SHA-1 for the represented object if blobs or the offse=
t
> =A0 =A0 =A0to another tree block if trees
>
> =A0 =A0A 32-bit 'flags' field split into (high to low bits)
>
> =A0 =A0 =A01-bit assume-valid flag
>
> =A0 =A0 =A01-bit extended flag (must be zero in version 2)
>
> =A0 =A0 =A02-bit stage (during merge)
>
> =A0 =A0 =A012-bit name length if the length is less than 0xFFF; other=
wise 0xFFF
> =A0 =A0 =A0is stored in this field.
>
> =A0 =A0 =A01-bit skip-worktree flag (used by sparse checkout)
>
> =A0 =A0 =A01-bit intent-to-add flag (used by "git add -N")
>
> =A0 =A0 =A014-bit unused, must be zero
>
> =A0 =A0A 16-bit offset, relative to the beginning of this block, to t=
he
> =A0 =A0 =A0pathname of this entry. FIXME: make it 32-bit, relative to=
 the
> =A0 =A0 =A0beginning of the file, so that we can reuse pathnames from=
 other
> =A0 =A0 =A0(old) blocks?

16 bit offset doesn't work well in a block that can be as large as 2^24=
=2E

If you reuse a path name list at the start of the file, how do you
handle new names?
