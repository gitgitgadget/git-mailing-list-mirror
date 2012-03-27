From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Tue, 27 Mar 2012 14:20:07 +1100
Message-ID: <CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 05:20:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCMxC-0003js-Lx
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 05:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab2C0DUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 23:20:10 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56340 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395Ab2C0DUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 23:20:08 -0400
Received: by vbbff1 with SMTP id ff1so3077528vbb.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 20:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6odp6zmJo3VNUqQiLrYxmqPowWUEqV4M/gw4aVUBojE=;
        b=rvo8krpctLjkiJ1I0ZJS4kqLQEymhOBYoNQIOVEsGLwHnQAc7VZr7MkuC2nl7TaK2z
         3GzT5c6U1Yxz7ZScFKwz6Q0NVpbRJplR8+FWdkf8hPxSzgCaRJIv7iNNIgozCV59ksvm
         0T3v4kl8qBpkMCFXUXny5DPvt0R1/z2g7HmJqRD/VUcZMnJeyAUtF7kKmmDyH8iMGDTl
         dHiIcCEBzVKxyUiJnJccxbaS61Lh7kODDgHU/8LN23fLSNRR3HPqzmkjuSVMhc9M8B0Y
         oUew11gvJDaCXufkBmNS+URVZ5tqsHBbNfhH2/uYYy0osIN7y+cZ1GDhqC0+rGR6ch6A
         YxMQ==
Received: by 10.220.226.3 with SMTP id iu3mr11242200vcb.50.1332818407948; Mon,
 26 Mar 2012 20:20:07 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Mon, 26 Mar 2012 20:20:07 -0700 (PDT)
In-Reply-To: <CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193998>

Hi Nguyen,

Thanks for the idea. just a few questions

On Tue, Mar 27, 2012 at 3:19 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Mon, Mar 26, 2012 at 9:28 PM, Thomas Rast <trast@student.ethz.ch> =
wrote:
>> Doesn't that venture into database land?
>
> How about this (a bit like memory management). Maybe it's simpler tha=
n
> a database and fits us better.
>
> The header consists of crc32 and three uint32_t, one points to the
> root tree, one the first extension block, the last one the free list
> at the end of the file. The rest of the file contains sizable blocks.
> There can be free space between them. Free spaces (offset and size)
> are recorded at the end of the file, pointed in header. The header's
> crc32 covers the header and free list.

How do you record free spaces at the end of file? Are you gonna have a
fixed size for the index and reserve space for free spaces offsets.

>
> When we need a new block, we look up in free list. If we cannot find =
a
> suitable space, we append to the end of the file (moving free list
> further to keep it always the end of the file). Removing a block mean=
s
> marking it in free list. We only truncate if there is free space at
> the end. Operations that we know will scratch the whole index are our
> opportunity to rewrite the index and make it compact again. No random
> garbage collection (iow disk is cheap).
>

I agree with you. Maybe we just ignore free spaces in the index and
let a background thread to compact it.

> A block starts with a signature (a tree block, or an extension...). A
> tree block consists of:
>
> =A0- uint32_t tree object's size
> =A0- sha-1 of tree object
> =A0- crc32 of the rest of the block except tree object
> =A0- maybe reference counter of a block can be refered by many blocks=
??
> =A0- tree object (i.e. something that tree-walk.c can parse)

Do you mean each block contains a tree and all its blobs? So the tree
object here, effectively a dir, also contains files in the dir ? In
this way, some blocks can be very big.

> =A0- other index attributes, stored separately in the same order as i=
n
> tree object above, uint32_t block offset of subdirectories.

There can be many sub dirs some times. But maybe not a prob.

As tree object and =A0offset of subdirectories are variables, how do yo=
u
make a block resizable?

>
> An extension block basically consists of what we have now in an
> extension plus uint32_t offset to the next extension block, so we can
> keep track of all extensions. crc32 is used for extension blocks.
>
> This way we only need to verify checksum of the header (and free list=
)
> and blocks we visit. We don't need cache-tree extension because it's
> part of the format. There will be headache with unpack-trees.c becaus=
e
> of entry order change. But in the end we would use the same order tre=
e
> objects are using now, much simpler for us.
> --
> Duy

Cheers,
Elton
