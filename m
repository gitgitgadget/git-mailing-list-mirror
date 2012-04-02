From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 2 Apr 2012 21:50:53 +1000
Message-ID: <CAKTdtZkSEs7Z+0NrfEaFDt-LJEPCLg5FhHgSGAsF32gqQB+DCg@mail.gmail.com>
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
	<CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
	<87iphrjv23.fsf@thomas.inf.ethz.ch>
	<CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
	<CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
	<CACsJy8BjYLAKqFDeGRyUj+SDKOTRbjW8shomhnhORM082HM9yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 13:51:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEfmm-0006uF-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 13:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab2DBLu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 07:50:56 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42919 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab2DBLuy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 07:50:54 -0400
Received: by vcqp1 with SMTP id p1so1594843vcq.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cB/ZhEIp4JnbxeWISwTVF2GYEdQ3JKjqEy2G3nCGNfc=;
        b=05lFhUCkgGI5ib8ZS/zv18keJfz4AR2qoZacLe+hfoMivA5Y/R0KWhwiLB31AUb6KN
         iRWKfSnl+yjceM7whsEqXsP7ivMqB+9jXHiphvvfNnizDmkvupW42bgw/ofGO3isWXrg
         Xwb8z5mkR+BZWvgRi6f+cY5qA1n/4z47/U3BEkC2ZXVsybq+pJHg1V9XZokL1nBz6NRY
         vsKZKoj9OYz/ShsHLX2ZfR8JHpT6MQdJncCyO/xFjei6VHhehhlcL3udEi8zzoakQ4Ud
         7Tr1nkVb06scgl/VL7N0SRuVW8YGzAf3yLojWz9kZ1yVS1zZOLN1s6AYpECM7+kJEWje
         Yy7Q==
Received: by 10.220.149.79 with SMTP id s15mr3799501vcv.60.1333367454026; Mon,
 02 Apr 2012 04:50:54 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Mon, 2 Apr 2012 04:50:53 -0700 (PDT)
In-Reply-To: <CACsJy8BjYLAKqFDeGRyUj+SDKOTRbjW8shomhnhORM082HM9yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194511>

Hi Nguyen,

Still have some questions on your idea:

On Tuesday, March 27, 2012, Nguyen Thai Ngoc Duy wrote:
>
> On Tue, Mar 27, 2012 at 10:20 AM, elton sky <eltonsky9404@gmail.com> =
wrote:
> > On Tue, Mar 27, 2012 at 3:19 AM, Nguyen Thai Ngoc Duy <pclouds@gmai=
l.com> wrote:
> >> The header consists of crc32 and three uint32_t, one points to the
> >> root tree, one the first extension block, the last one the free li=
st
> >> at the end of the file. The rest of the file contains sizable bloc=
ks.
> >> There can be free space between them. Free spaces (offset and size=
)
> >> are recorded at the end of the file, pointed in header. The header=
's
> >> crc32 covers the header and free list.
> >
> > How do you record free spaces at the end of file? Are you gonna hav=
e a
> > fixed size for the index and reserve space for free spaces offsets.
>
> A list of (offset,size) with (0,0) to terminate. No index can shrink
> or expand at will. Free list is always at the end of the index.
>
> >> A block starts with a signature (a tree block, or an extension...)=
=2E A
> >> tree block consists of:
> >>
> >> =A0- uint32_t tree object's size
> >> =A0- sha-1 of tree object
> >> =A0- crc32 of the rest of the block except tree object
> >> =A0- maybe reference counter of a block can be refered by many blo=
cks??
> >> =A0- tree object (i.e. something that tree-walk.c can parse)
> >
> > Do you mean each block contains a tree and all its blobs? So the tr=
ee
> > object here, effectively a dir, also contains files in the dir ? In
> > this way, some blocks can be very big.
>
> No, the tree object contains pathname, mode and SHA-1 of its entries,
> one level only (try "git ls-tree HEAD"). If an entry is a directory
> and we have not built it yet, we won't have its sha-1, so it will be
> zero (similar to invalid cache-tree).
>

Correct me if I am wrong, I assume:
* Although you only listed attributes in tree block,=A0in index, we hav=
e
both tree and blob block.
* Sha1 of a tree block is computed by hashing all the Sha1s of blobs
and sub trees in the directory.
* Like cache tree struct, each tree object contains list of offsets to
children blocks.

How do you store blob blocks ?=A0Is each blob object a block? just like
a tree object is a block? If so, each blob contains a sha1, the
overhead is high?

If we compute hash for a tree, and this tree happen to have 500
children do I have to access all 500 blocks to get their Sha1s?


>
> >> =A0- other index attributes, stored separately in the same order a=
s in
> >> tree object above, uint32_t block offset of subdirectories.
> >
> > There can be many sub dirs some times. But maybe not a prob.
> >
> > As tree object and =A0offset of subdirectories are variables, how d=
o you
> > make a block resizable?
>
> If there are free space right after it, it can be expanded. Otherwise
> we need to move the block elsewhere and update its parent about its
> new offset, then mark where the block was as free space.
> --
> Duy



Also I ran some quick test on git-add over kernel 2.6. When I do "time
git add .":time git add .

cmd_add: validate_pathspec takes : 0 ms
read_index_from: xmmap&close takes : 0 ms
read_index_from: verify_hdr takes : 26 ms
read_index_from: create inmem struct takes : 4 ms
read_index: read_index_from takes : 31 ms
read_directory: qsort takes : 0 ms
fill_directory: read_directory takes : 97 ms
cmd_add: prune dir takes : 0 ms
cmd_add: add_files_to_cache takes : 37 ms
cmd_add: add_files takes : 0 ms

real 0m0.172s
user 0m0.120s
sys 0m0.050s

And when I ran "time git add arch/ia64" :

cmd_add: validate_pathspec takes : 0 ms
read_index_from: xmmap&close takes : 0 ms
read_index_from: verify_hdr takes : 20 ms
read_index_from: create inmem struct takes : 4 ms
read_index: read_index_from takes : 25 ms
read_directory: read_directory_recursive takes : 10 ms
read_directory: qsort takes : 0 ms
fill_directory: read_directory takes : 10 ms
cmd_add: fill_directory takes : 10 ms
cmd_add: prune dir takes : 0 ms
cmd_add: add_files_to_cache takes : 1 ms

real 0m0.043s
user 0m0.040s
sys 0m0.000s

In both cases, the time for sha1 is quite stable (~20ms).
fill_directory drops as I specify a sub directory, which make sense.
As Junio suggested, the sha1 time (verify_hdr) is a mix a read and
sha1. And this part is our focus to optimize, isn't it? But, as growth
of the whole repo, the processing time is getting dominated by
fill_directory (if we use '.', it takes 97ms) rather than=A0verify_hdr.
In current system, The time complexity for fill_directory is nlogn (n
is number of objects). git recursively go thru sub directories and
files in it and check against current index. When searching index, it
uses binary search which makes it lg(n). If this is the case, will use
a producer/consumer model help?

Cheers,
Elton
