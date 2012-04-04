From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Thu, 5 Apr 2012 02:22:10 +1000
Message-ID: <CAKTdtZkyLfjsqzoVNA0VocWBf+wh3YDtTwx_x4tFTxnr1fJyAw@mail.gmail.com>
References: <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
	<CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
	<CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
	<CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
	<CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
	<87iphrjv23.fsf@thomas.inf.ethz.ch>
	<CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
	<CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
	<CACsJy8BjYLAKqFDeGRyUj+SDKOTRbjW8shomhnhORM082HM9yw@mail.gmail.com>
	<CAKTdtZkSEs7Z+0NrfEaFDt-LJEPCLg5FhHgSGAsF32gqQB+DCg@mail.gmail.com>
	<20120402123146.GA24813@do>
	<CAKTdtZm4JFkWOq7D=tHC-t8C5yd=AG6MEkKD46z5D7fCRDEfZQ@mail.gmail.com>
	<CACsJy8A+0GxePYPSJh9g_N83QXY8cf8HHGT65M_eNGBeAs-5uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:22:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFSyX-0003QP-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 18:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab2DDQWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 12:22:18 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54029 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab2DDQWL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 12:22:11 -0400
Received: by vbbff1 with SMTP id ff1so291307vbb.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=SxamCElz2cBFLP+YHkQPrWu/vhIXuCpzgkjkwZNU8pI=;
        b=D3G1RPsDgved5z/4xhOBqORNcoHe6xcaTMFX04UOqX9Q/Lp2ZA+EnsURcABbQBUG1r
         zaLY7n2pbgIyEAcyZvVOcJgMNdZBy+zct+UvaeeaR7/HYu6DmisjoMun5q+ZCxGN+vhs
         4Z3t+zrz9y4OoEf9Jb7loHwJYH2WPaJJDZuG6XVfEpb3JAqLY+AAUcHjExfoq+UoJKoL
         HIDRUKX8HWDBz/rh/ECk6N7hZy5qj89OceiP2OOUjxTEWtObuw7I0hGUP2/1TFBfssNL
         wz+ngVyE9BHwlRh01eB+MIs59JAqZxZHBzc3zJRv8SLgp7laqqbwCOURIEWavIJraPaP
         ZhXQ==
Received: by 10.52.29.244 with SMTP id n20mr6919898vdh.22.1333556530269; Wed,
 04 Apr 2012 09:22:10 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Wed, 4 Apr 2012 09:22:10 -0700 (PDT)
In-Reply-To: <CACsJy8A+0GxePYPSJh9g_N83QXY8cf8HHGT65M_eNGBeAs-5uQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194704>

Hello,

Some updates for Nguyen's index:

On Wed, Apr 4, 2012 at 10:20 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Wed, Apr 4, 2012 at 3:26 PM, elton sky <eltonsky9404@gmail.com> wr=
ote:
>> I am not sure how the trailer works.
>> I assume there can be multiple trailers, each update will generate a
>> new one. Every trailer will point to the root tree (i.e. all trailer=
s
>> point to the same block?). So if there are some changes to root, lik=
e
>> rename, trailers all point to the latest root block?
>
> Each trailer points to the whole new tree. Because trees are
> immutable, changing in a tree meangs creating a new one and will also
> make a new parent tree (to point to the updated tree because old
> parent will always point to old tree). This eventually leads to root
> tree change, recorded by the trailer.
>
>> Is the index looks like :
>> | HEADER | TREE BLOCKS | TRAILER | =A0TREE BLOCKS | TRAILER | TREE
>> BLOCKS | TRAILER | ...
>>

Once an update happened to a block, all parent blocks to root will be
copied to the end of the index. And the updated block will be at leaf
of the new tree. Finding this path costs logn time anyway. This is no
harm for read for the whole tree. But in order to find all previous
changes to a block, we have to go through all trailers and trees.

Otherwise, just modify the original tree. Let the parent points to the
updated block and let the updated block points to the old block:

parent
=A0 =A0|
=A0 V
updated =A0 =A0 =A0 =A0 =A0 =A0old =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0o=
ld
block (v3) =A0--> =A0 block(v2) =A0--> =A0block (v1)
=A0 =A0|
=A0 V
child
blocks

A version number in a tree block is used to track the changes.
In this way, there's still no harm to read, and it's more easy to
trace the change history of a block. Also, we don't need to create
interleaved blocks and trailers. There's only one trailer in the end
of file. We also need to add another offset points to previous
version.

Trailer is kept at the end of index, as its size is variable. It
contains offset to root and list of free spaces.

Changes to format:

> =3D The git index file has the following format

As is, except there's only one trailer now. And trailer contains list
of free spaces.

>- A 18-byte trailer consisting of
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
=A0 =A0 =A0 =A0list of free spaces
=A0 =A0 =A0 =A0- 4 byte offset
=A0 =A0 =A0 =A0- 2 byte length

> =A0 =A0 =A04-byte checksum:
> =A0 =A0 =A0 =A0CRC32 of the header and the trailer (excluding this fi=
eld)

=46ree space list is read/written in whole for each operation, together
with trailer.

>
> =3D=3D Tree block
> ...

Above as is.

- 1 byte version num

- 4 byte offset to previous version block

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
>

-Elton
