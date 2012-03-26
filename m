From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 26 Mar 2012 23:36:59 +1100
Message-ID: <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	<87aa3aw5z8.fsf@thomas.inf.ethz.ch>
	<CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
	<CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
	<CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
	<CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
	<CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
	<CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
	<CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
	<CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
	<CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 14:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC9Ad-0006Al-8I
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 14:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab2CZMhB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 08:37:01 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64254 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746Ab2CZMhA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 08:37:00 -0400
Received: by vbbff1 with SMTP id ff1so2565901vbb.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=MhMj5OBb55WXcs/u7sNfzCgELWatu5itmIzgkdgs54M=;
        b=tuo84G/ffNVu5+Sxk/JCMTaUvZ5vtyYM+DMTZulNYJgk1gBB1Xw6Euo1t4G4tpGtDt
         y2i/fpetGqUCBZJKkHxhCWc/5HLT9mUdVGZl9O0bbK4PTMBZtUtpOoaX+bAblLAxFq0d
         SE50EegmwdKE1XKgSSstTK+SpHQIB9Ge5PwgTE5flDtKMIFdeDEUFMoIeR1eazTCI1dT
         6x7ataG8FEk8u9CxtS03cu1/jcqqw+Sit0hSy03hhvaqn0jiw5i2Ck5lj7usK+ynA6XL
         vDZ8KcGJHqN+PETPoS9ThyHEsoezenWfJ9W2d5oA9Vju80QxXnltx9XHLkbyY1S41ZPT
         jXGQ==
Received: by 10.52.22.166 with SMTP id e6mr8414173vdf.5.1332765419450; Mon, 26
 Mar 2012 05:36:59 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Mon, 26 Mar 2012 05:36:59 -0700 (PDT)
In-Reply-To: <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193909>

Hi Nguyen,

On Mon, Mar 26, 2012 at 12:06 PM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> (I think this should be on git@vger as there are many experienced dev=
s there)
>
> On Sun, Mar 25, 2012 at 11:13 AM, elton sky <eltonsky9404@gmail.com> =
wrote:
>> About the new format:
>>
>> The index is a single file. Entries in the index still stored
>> sequentially as old format. The difference is they are grouped into
>> blocks. A block contains many entries and they are ordered by names.
>> Blocks are also ordered by the name of the first entry. Each block
>> contains a sha1 for entries in it.
>
> If I remove an entry in the first block, because blocks are of fixed
> size, you would need to shift all entries up by one, thus update all
> blocks?
>

We need some GC here. I am not moving all blocks. Rather I would
consider merge or recycle the block. In a simple case if a block
becomes empty, I ll change the offset of new block in the header point
to this block, and make this block points to the original offset of
new block. In this way, I keep the list of empty blocks I can reuse.
If a block is not empty but not full, we better merge it with adjacent
block for efficiency. But I don't know an light way to handle that
when refreshing index. But we can always run a background thread to
rebuild the index, at some stage, while system is quiet.

> Also note the sequence format means duplication because we always
> store full path.

You are right, this keeps the size of the index as current system. Use
a tree will save disk space for sure. Need think more about this.

> --
> Duy

Attach my previous email here:

The goal of this project is :
1. verify checksum for only necessary part of index
2. keep the time complexity of most git-app below logn

About the new format:

The index is a single file. Entries in the index still stored
sequentially as old format. The difference is they are grouped into
blocks. A block contains many entries and they are ordered by names.
Blocks are also ordered by the name of the first entry. Each block
contains a sha1 for entries in it.
=46or using a binary search to locate the block for an entry, the
offsets of blocks are stored in the header of the index. We reserve
100 spaces for block offsets in the header. More offsets are stored in
a meta block (see below) afterwards. An offset of the first meta block
is stored.
The checksum is computed on block. After we locate the block, the
checksum is recomputed for the block. And only the this block will be
read and write back later. As the block is read into ram, it is easy
to do a binary search for entries in a block when they are in ram.
When the index doesn't have many entries, it works very similar with
current format. When more entries git-added, blocks will come into
play.

=46ormat:

Head:
* 4-byte signature
* 4-byte version num
* 4-byte num of entries blocks
* 4-byte offset for new block
* list of offsets for blocks (e.g. 96, 14096, 8192, ..) : For binary
search. Each offset is 8 bytes, we reserve 100 x 4 =3D 400 bytes for
first 100 blocks. More offsets (if applicable) will be stored in a
meta blocks.
* 4-byte offset to the first meta block
* 20-byte sha1 for above and meta blocks

List of Blocks:
* sha1 for all entries
* list of entries

Meta block:
* offset to next meta block
* list of offsets

Extensions:
=A0 =A0 =A0 TBD. Have not hacked cache tree yet. Need more knowledge of=
 cache tree...


Block Split & Delete:
=A0 =A0 =A0 TBD.


-Elton
