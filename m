From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Fri, 6 Apr 2012 13:15:44 +1000
Message-ID: <CAKTdtZm9THdFaSjAONStmOdbs_QxHK5ZWc6_sVaySufKJ6CgEw@mail.gmail.com>
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
	<CAKTdtZkyLfjsqzoVNA0VocWBf+wh3YDtTwx_x4tFTxnr1fJyAw@mail.gmail.com>
	<CAKTdtZmzGyH+BUPjBPLxSTJp5OPr+uKAeu_No9VSoTgUAH2SEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 05:15:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFzeQ-0005U8-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 05:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab2DFDPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 23:15:45 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61062 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2DFDPp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 23:15:45 -0400
Received: by gghe5 with SMTP id e5so1128984ggh.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 20:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=JY8ytBUd8aCwogc5V3eRcyBQHvn4hrsP0nYioFUI9RY=;
        b=h6VjgZuyFkOubaY4z/he/KQFxJBXXOFsx1bOIvchC34oo/PFkLqfwAdU3tKR9BtQLs
         s35TzhBWV0PBStM/Sc0twKYFGdHQFHDGGolM3zdniwDA1A5XviaeA2gN1z/q8sear5mO
         k/UKo98uQ3fncvs6wrtwfMoVsm6824yd72aaaTdY7lN8qzMwnT/so3NmPLu+A9fLvj+G
         7CjoJBEIzcWnhO0/kz8lLbShj50NDti2DEHlr5RCVH36Zz8IzlXCmJbqGDR9o0wlxn8V
         c7HlQVaEn+7myyQCZLYcYHHtd5MTJSPOzvMtgCcsaNCmOawaOpY8ynTfRRV6CNUxDOeH
         jcug==
Received: by 10.236.161.232 with SMTP id w68mr5169836yhk.56.1333682144577;
 Thu, 05 Apr 2012 20:15:44 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Thu, 5 Apr 2012 20:15:44 -0700 (PDT)
In-Reply-To: <CAKTdtZmzGyH+BUPjBPLxSTJp5OPr+uKAeu_No9VSoTgUAH2SEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194841>

NOTE:
Please ignore the

>- checkpoint : interleave with items in the block, 1 for every 100 ite=
ms
> =A0 =A0 =A0 4-byte offset to next checkpoint

That's irrelevant.

Cheers,
Elton

On Fri, Apr 6, 2012 at 1:13 PM, elton sky <eltonsky9404@gmail.com> wrot=
e:
> Thank you everyone for ideas, clues, explanations and questions.
> Collectively I wrote my proposal. This one is mostly based on Duy's
> suggestion with minor changes.
>
>
> Problem:
> Current index store all files in a list. This implies that:
> 1. Each operation has to read the whole index and write the whole ind=
ex back.
> 2. computing the checksum for the whole index.
> These become expensive when the repo is large.
>
> Requirement:
> Suppose n is the number objects in a repo
> -Keep the read/write time <=3D O(logn).
> -Keep the checksum computed against only necessary objects.
> -New format is easy to parse.
> -Backward compatible.
> -Potentially use faster hash method.
>
> Proposed solution:
>
> Store the repo structure in a canonical tree. Each directory is a tre=
e
> block. A tree block contains blobs and offsets to sub directories. It
> has its own checksum. A read/write will be done on tree block base. A
> tree block also contains an offset points to its previous version (if
> there's one).
>
> The root of offset is stored in trailer, which stays at the end of
> file. Each update creates a new trailer which points to the new tree.
> (details below)
>
> To save the pain of modify a tree block and track the free spaces in
> the index, changed blocks are appended at the end. Based on the
> assumption that user won't change too many files each time, for an
> updated file, all its parent blocks to Root was copied and appended t=
o
> index. In other words, all traversed blocks are copied. The offset of
> previous version of the updated block is stored in the new block. A
> new generation number is stored in copied and updated blocks. Other
> blocks are not copied. They are referenced by offsets. After update a
> new trailer is created at the end. In this way, there's no harm to
> read, and makes write fast.
>
> Trailer stores the offset of previous trailer. It makes tracking old
> versions easy.
>
> Each operation will load and rewrite the header and visited trailer .
>
> Checksum for non identifier purpose will use crc32. Otherwise it uses=
 sha1.
>
> For compatibility, old format of index will be transformed to new
> format in the first operation.
>
> =3D=3D
> Index format:
>
> - A 8-byte header consisting of
>
> =A0 =A04-byte signature:
> =A0 =A0 =A0The signature is { 'T', 'R', 'E', 'E' }
>
> =A0 =A04-byte version number:
> =A0 =A0 =A0The current supported versions are 4.
>
> =A0- A number of blocks of variable size
>
> =A0 =A0 1-byte block type
>
> =A0 =A0 3-byte content size in byte
>
> =A0 =A0 block content
>
> =A0 =A0 4-byte crc32 of all above
>
> =A0- A 20-byte trailer consisting of
>
> =A0 =A0 4-byte trailer signature:
> =A0 =A0 =A0 The signature is { 'R', 'O', 'O', 'T' }
>
> =A0 =A0 4-byte root block offset
>
> =A0 =A0 4-byte extension table offset:
> =A0 =A0 =A0 Zero means no extension
>
> =A0 =A0 4-byte offset to previous trailer
>
> =A0 =A0 4-byte checksum:
> =A0 =A0 =A0 CRC32 of the header and the trailer (excluding this field=
)
>
> =3D=3D
> Tree block:
>
> Tree block content is basically the list of entries in a specified
> path, with all attributes we store in the index now. This entry list
> is sorted by pathname. For doing a bsearch in the list, pathnames are
> stored at the end of block, which makes the size of entry fixed. The
> pathname is pointed from each entry with 2 byte offset (relative to a
> block). This should not be problem as a block is never modified.
>
> It stores the generation number and the offset to old block. It also
> integrates the content of cache-tree.
>
> A tree block content consists of
>
> =A0- 4-byte tree object size
>
> =A0- 20-byte SHA-1 of the cached tree object
>
> - checkpoint : interleave with items in the block, 1 for every 100 it=
ems
> =A0 =A0 =A0 =A04-byte offset to next checkpoint
>
> =A0- a list attributes corresponding to tree object's item, in the sa=
me
> =A0 order. These attributes are the same as in DIRC entry format
> =A0 except that entry name is removed, and a tree block offset is
> =A0 added in case the item is a directory.
>
> =A0 32-bit ctime seconds, the last time a file's metadata changed
> =A0 =A0 this is stat(2) data
>
> =A0 32-bit ctime nanosecond fractions
> =A0 =A0 this is stat(2) data
>
> =A0 32-bit mtime seconds, the last time a file's data changed
> =A0 =A0 this is stat(2) data
>
> =A0 32-bit mtime nanosecond fractions
> =A0 =A0 this is stat(2) data
>
> =A0 32-bit dev
> =A0 =A0 this is stat(2) data
>
> =A0 32-bit ino
> =A0 =A0 this is stat(2) data
>
> =A0 32-bit mode, split into (high to low bits)
>
> =A0 =A0 4-bit object type
> =A0 =A0 =A0 valid values in binary are 1000 (regular file), 1010 (sym=
bolic link)
> =A0 =A0 =A0 and 1110 (gitlink)
>
> =A0 =A0 3-bit unused
>
> =A0 =A0 9-bit unix permission. Only 0755 and 0644 are valid for regul=
ar files.
> =A0 =A0 Symbolic links and gitlinks have value 0 in this field.
>
> =A0 32-bit uid
> =A0 =A0 this is stat(2) data
>
> =A0 32-bit gid
> =A0 =A0 this is stat(2) data
>
> =A0 32-bit file size
> =A0 =A0 This is the on-disk size from stat(2), truncated to 32-bit.
>
> =A0 160-bit SHA-1 for the represented object if blobs or the offset
> =A0 =A0 to another tree block if trees
>
> =A0 A 32-bit 'flags' field split into (high to low bits)
>
> =A0 =A0 1-bit assume-valid flag
>
> =A0 =A0 1-bit extended flag (must be zero in version 2)
>
> =A0 =A0 2-bit stage (during merge)
>
> =A0 =A0 12-bit name length if the length is less than 0xFFF; otherwis=
e 0xFFF
> =A0 =A0 is stored in this field.
>
> =A0 =A0 1-bit skip-worktree flag (used by sparse checkout)
>
> =A0 =A0 1-bit intent-to-add flag (used by "git add -N")
>
> =A0 =A0 14-bit unused, must be zero
>
> =A0 =A0 =A0A 16-bit offset, relative to the beginning of this block, =
to the
> pathname of this entry
>
> - 2-byte generation number, starts from 1
>
> - 4-byte previous version offset
>
> =A0- a list of NUL-terminated pathnames, pointed to from the 16-bit o=
ffset
> =A0 above
>
> =3D=3D Extension table block
>
> Extension table has block type 'X'. It consists of a series of 4-byte
> extension block offset.
>
> =3D=3D Extension block
>
> Extension block has block type 'E'. Extension content is the same as
> in the old format.
>
>
>
> Time line:
>
> 24/04 ~ 21/05: get familiar with code base and revise proposal
> benchmark with linux kernel on major operations
> write prototype to prove feasibility of proposed solution
> consult mailing list & irc
>
> 22/05 ~ 25/06 write code, test and benchmark
> =A0 =A0 =A0 =A0modify tree lib
> =A0 =A0 =A0 =A0modify index format operations
> =A0 =A0 =A0 =A0modify git operations
> =A0 =A0 =A0 =A0transform from old to new
>
> 26/06 ~ 30/07 revise things according to benchmark
>
> 31/07 ~ 13/08 update documentation
>
>
> About me
>
> My name is Elton Tian, I am from China. I have been living in
> Australia for quite a few years. I am currently a Master student from
> Australia National University. After graduate I worked on linux based
> web development (using tcl) for 2.5 years. I have been programming
> with c, c#, java, tcl, php, javascript and shell script. But I prefer
> c, which gives me the feeling of full control over the program. I am
> interested in data intensive computing. I played with hadoop and
> mapreduce since 2010. I maintained my 3 node cluster behind my desk.
> As linus hates cvs with a passion, I still want to mention I was usin=
g
> cvs in work, don't like it though. And I guess this is the good chanc=
e
> to get over it.
>
> On Thu, Apr 5, 2012 at 2:22 AM, elton sky <eltonsky9404@gmail.com> wr=
ote:
>> Hello,
>>
>> Some updates for Nguyen's index:
>>
>> On Wed, Apr 4, 2012 at 10:20 PM, Nguyen Thai Ngoc Duy <pclouds@gmail=
=2Ecom> wrote:
>>> On Wed, Apr 4, 2012 at 3:26 PM, elton sky <eltonsky9404@gmail.com> =
wrote:
>>>> I am not sure how the trailer works.
>>>> I assume there can be multiple trailers, each update will generate=
 a
>>>> new one. Every trailer will point to the root tree (i.e. all trail=
ers
>>>> point to the same block?). So if there are some changes to root, l=
ike
>>>> rename, trailers all point to the latest root block?
>>>
>>> Each trailer points to the whole new tree. Because trees are
>>> immutable, changing in a tree meangs creating a new one and will al=
so
>>> make a new parent tree (to point to the updated tree because old
>>> parent will always point to old tree). This eventually leads to roo=
t
>>> tree change, recorded by the trailer.
>>>
>>>> Is the index looks like :
>>>> | HEADER | TREE BLOCKS | TRAILER | =A0TREE BLOCKS | TRAILER | TREE
>>>> BLOCKS | TRAILER | ...
>>>>
>>
>> Once an update happened to a block, all parent blocks to root will b=
e
>> copied to the end of the index. And the updated block will be at lea=
f
>> of the new tree. Finding this path costs logn time anyway. This is n=
o
>> harm for read for the whole tree. But in order to find all previous
>> changes to a block, we have to go through all trailers and trees.
>>
>> Otherwise, just modify the original tree. Let the parent points to t=
he
>> updated block and let the updated block points to the old block:
>>
>> parent
>> =A0 =A0|
>> =A0 V
>> updated =A0 =A0 =A0 =A0 =A0 =A0old =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
old
>> block (v3) =A0--> =A0 block(v2) =A0--> =A0block (v1)
>> =A0 =A0|
>> =A0 V
>> child
>> blocks
>>
>> A version number in a tree block is used to track the changes.
>> In this way, there's still no harm to read, and it's more easy to
>> trace the change history of a block. Also, we don't need to create
>> interleaved blocks and trailers. There's only one trailer in the end
>> of file. We also need to add another offset points to previous
>> version.
>>
>> Trailer is kept at the end of index, as its size is variable. It
>> contains offset to root and list of free spaces.
>>
>> Changes to format:
>>
>>> =3D The git index file has the following format
>>
>> As is, except there's only one trailer now. And trailer contains lis=
t
>> of free spaces.
>>
>>>- A 18-byte trailer consisting of
>>>
>>> =A0 =A0 =A04-byte trailer signature:
>>> =A0 =A0 =A0 =A0The signature is { 'R', 'O', 'O', 'T' }
>>>
>>> =A0 =A0 =A02-byte generation:
>>> =A0 =A0 =A0 =A0 The first trailer is 0, the second 1 and so on.
>>>
>>> =A0 =A0 =A04-byte root block offset
>>>
>>> =A0 =A0 =A04-byte extension table offset:
>>> =A0 =A0 =A0 =A0Zero means no extension
>>>
>> =A0 =A0 =A0 =A0list of free spaces
>> =A0 =A0 =A0 =A0- 4 byte offset
>> =A0 =A0 =A0 =A0- 2 byte length
>>
>>> =A0 =A0 =A04-byte checksum:
>>> =A0 =A0 =A0 =A0CRC32 of the header and the trailer (excluding this =
field)
>>
>> Free space list is read/written in whole for each operation, togethe=
r
>> with trailer.
>>
>>>
>>> =3D=3D Tree block
>>> ...
>>
>> Above as is.
>>
>> - 1 byte version num
>>
>> - 4 byte offset to previous version block
>>
>>>
>>> =A0 =A0160-bit SHA-1 for the represented object if blobs or the off=
set
>>> =A0 =A0 =A0to another tree block if trees
>>>
>>> =A0 =A0A 32-bit 'flags' field split into (high to low bits)
>>>
>>> =A0 =A0 =A01-bit assume-valid flag
>>>
>>> =A0 =A0 =A01-bit extended flag (must be zero in version 2)
>>>
>>> =A0 =A0 =A02-bit stage (during merge)
>>>
>>> =A0 =A0 =A012-bit name length if the length is less than 0xFFF; oth=
erwise 0xFFF
>>> =A0 =A0 =A0is stored in this field.
>>>
>>> =A0 =A0 =A01-bit skip-worktree flag (used by sparse checkout)
>>>
>>> =A0 =A0 =A01-bit intent-to-add flag (used by "git add -N")
>>>
>>> =A0 =A0 =A014-bit unused, must be zero
>>>
>>> =A0 =A0A 16-bit offset, relative to the beginning of this block, to=
 the
>>> =A0 =A0 =A0pathname of this entry. FIXME: make it 32-bit, relative =
to the
>>> =A0 =A0 =A0beginning of the file, so that we can reuse pathnames fr=
om other
>>> =A0 =A0 =A0(old) blocks?
>>>
>>
>> -Elton
