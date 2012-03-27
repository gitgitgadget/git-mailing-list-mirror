From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Tue, 27 Mar 2012 13:43:27 +0700
Message-ID: <CACsJy8BjYLAKqFDeGRyUj+SDKOTRbjW8shomhnhORM082HM9yw@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
 <87aa3aw5z8.fsf@thomas.inf.ethz.ch> <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
 <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
 <CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
 <CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
 <CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
 <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
 <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
 <87iphrjv23.fsf@thomas.inf.ethz.ch> <CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
 <CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:44:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCQ8R-0003Uz-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876Ab2C0Gn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 02:43:59 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54430 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab2C0Gn6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 02:43:58 -0400
Received: by wibhj6 with SMTP id hj6so5058317wib.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 23:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NAflTd6w7WMavlAhf/mlSZSp5TKQir/PyOZgFkaoR/k=;
        b=W8HSYaHF9og3lhzaB2Yj/0v1VY1oe5Pgc8I6kgXvDEPEYKRGoeKC+HpQhTBk+3OYd7
         i6mdu7YjS2jjHE7IZcXH53xh6SZat+WORPrZ4cirowJ7XvktBlkeeOL5zUAuwuntuWxe
         uA+4KlXjV2Gr8JDoDrOFRiCX0CJEpiLecP22Dbvhk++s0sB8riciHAaS9/SnnOpoOCTs
         n4lRPkzVKm8Pd+qCP51aAQqWKWGKvLWCx0mDdH3M7kHr2ACUTbpAsUNCKfsX+BWHEdjS
         HpwgSSg4V8TKYOIGlA4Pt+3ASNE7C4s64ar2YdNPe1vyuo98hqqt/u4tJ5IEjJBOYJS+
         63uA==
Received: by 10.180.24.66 with SMTP id s2mr24842459wif.7.1332830637419; Mon,
 26 Mar 2012 23:43:57 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 26 Mar 2012 23:43:27 -0700 (PDT)
In-Reply-To: <CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194026>

On Tue, Mar 27, 2012 at 10:20 AM, elton sky <eltonsky9404@gmail.com> wr=
ote:
> On Tue, Mar 27, 2012 at 3:19 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> The header consists of crc32 and three uint32_t, one points to the
>> root tree, one the first extension block, the last one the free list
>> at the end of the file. The rest of the file contains sizable blocks=
=2E
>> There can be free space between them. Free spaces (offset and size)
>> are recorded at the end of the file, pointed in header. The header's
>> crc32 covers the header and free list.
>
> How do you record free spaces at the end of file? Are you gonna have =
a
> fixed size for the index and reserve space for free spaces offsets.

A list of (offset,size) with (0,0) to terminate. No index can shrink
or expand at will. Free list is always at the end of the index.

>> A block starts with a signature (a tree block, or an extension...). =
A
>> tree block consists of:
>>
>> =C2=A0- uint32_t tree object's size
>> =C2=A0- sha-1 of tree object
>> =C2=A0- crc32 of the rest of the block except tree object
>> =C2=A0- maybe reference counter of a block can be refered by many bl=
ocks??
>> =C2=A0- tree object (i.e. something that tree-walk.c can parse)
>
> Do you mean each block contains a tree and all its blobs? So the tree
> object here, effectively a dir, also contains files in the dir ? In
> this way, some blocks can be very big.

No, the tree object contains pathname, mode and SHA-1 of its entries,
one level only (try "git ls-tree HEAD"). If an entry is a directory
and we have not built it yet, we won't have its sha-1, so it will be
zero (similar to invalid cache-tree).

>> =C2=A0- other index attributes, stored separately in the same order =
as in
>> tree object above, uint32_t block offset of subdirectories.
>
> There can be many sub dirs some times. But maybe not a prob.
>
> As tree object and =C2=A0offset of subdirectories are variables, how =
do you
> make a block resizable?

If there are free space right after it, it can be expanded. Otherwise
we need to move the block elsewhere and update its parent about its
new offset, then mark where the block was as free space.
--=20
Duy
