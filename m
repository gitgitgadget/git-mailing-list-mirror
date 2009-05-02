From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 2 May 2009 13:36:35 -0500
Message-ID: <b4087cc50905021136l5209777bs2209bab385deeef6@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <20090424231632.GB10155@atjola.homenet>
	 <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com>
	 <20090502155348.GB6135@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 02 20:37:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0K5A-00014k-Ab
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 20:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbZEBSgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 14:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbZEBSgg
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 14:36:36 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:50624 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbZEBSgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 May 2009 14:36:35 -0400
Received: by qyk34 with SMTP id 34so4352553qyk.33
        for <git@vger.kernel.org>; Sat, 02 May 2009 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BgQcYCSiAy4r8XvEnmfngtCiaFh+H6fZVpEnqRnM12A=;
        b=V2TDlomzET49QUXQxtT6qohP082ZnCiaIrQkruAC0tIVSkFh+Vvht9XKh35Mb5vJeZ
         NwMf62f1aQkSJoXM7MKaTFnRIcJxOuNN5boB6IY8pwDrNAkOudXgW1IrB9vN9nQtE78R
         O9/qY3NFnLB1IRI31AoQoi/QaD1MTpb7/qgVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XwjS7OLCA1DXbhsoTb3okQFq/Eg+GHh8quLKSUPMyq6bWzzMh7EFMVZ56MFI2KDkxs
         0TAvYIMsVnlUqFvn6zTNenlMsPbfi872kkeWoAfk+V8LL/FzzSrY1G3AgK3/F7nXzEOs
         TgDUXiEwfRgcFKF0/P8GMSTVtlXe/4bRQwIjw=
Received: by 10.224.60.138 with SMTP id p10mr4357279qah.236.1241289395444; 
	Sat, 02 May 2009 11:36:35 -0700 (PDT)
In-Reply-To: <20090502155348.GB6135@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118141>

2009/5/2 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> As I've stated: "address", "pointer", and "handle" are an analogy to
>> terminology that has been around for ages. In fact, another name for
>> "pointer" is "reference".
>
> AFAIK a pointer is just one kind of reference. C++ references are
> another kind...

Actually, a C++ reference is a pointer with restrictions (AFAIK).

> A reference is one piece of data that lets me access a different
> piece of data.

The key word there is 'access', which implies some kind of storage (or =
memory).

>
> And there are probably plenty of examples where you could apply that
> analogy, yet nobody (I know) does. Arrays, database tables, ...

Well, this terminology is certainly used with arrays in C, because
array elements can be accessed with pointers.

Also, databases use a much different scheme for addressing information
than does memory.

However, you're probably correct that pointer terminology doesn't
exist much outside of C/C++ and older languages (Ada?).

>
> And "memory" usually means "RAM" to me, not "WORM"-memory (well,
> actually, you can also delete and then rewrite, but not modify).

Well, I don't see how Random Access Memory really conflicts. One
certainly can access objects in the object memory/store randomly. The
main difference is that the computer store is addressed by location,
wheras the git store is addressed by content.

Also, I would say that conceptually deletion is an implementation
detail. Because git's object store is content addressable, one could
think of it as already containing all possible objects (of course, I'm
assuming that the 160-bit hash is also an implementation detail; an
infinite number of objects implies infinitely large addresses, though
the nonsignificant zeros could be disregarded as with real numbers or
something. I don't know, I'm making this up as I go :-D). That the git
tools ever complain no such object exists is an implementation detail
resulting from our finite storage in reality.

> So the
> analogy would even hurt my mental model (just like the "commit --amen=
d"
> command might be consider harmful, because it actually creates a new
> commit, but some users actually think the original commit is modified=
).

Actually, this is why it's so important to have the underlying
concepts at hand. Understanding that objects are simply addressed by
content (that is, objects are immutable) completely extirpates this
kind of confusion.

>> >> So, a pointer variable's value is an object address that is the
>> >> location of an object in git 'memory'. I think using this approac=
h
>> >> would make things significantly more transparent.
>> >
>> > But then HEAD would be a pointer pointer variable (symbolic ref), =
unless
>> > you have a detached HEAD.
>>
>> We call those handles.
>
> Isn't a handle basically an opaque/abstract reference, at least in
> "modern" usage? Symvolic references aren't. The user is free to creat=
e
> and manipulate them, and gets full access to the things referenced by
> them. And saying that HEAD is a reference, that might be symbolic is
> IMHO by far easier to understand than saying that HEAD might be a
> pointer or a handle.

=46air enough. Call them symbolic pointers; however, I don't really see
the problem with pointer pointers.

In any case, I *think* my point is that it's important to understand
that git uses content addressing; at first I was emphatic about the
idea of 'addressing', so I went with pointer terminology (which works
quite well, in my opinion). However, I think the 'content' part is
more important, which is why 'object hash' is loads better than
'object name' or 'object id'. Also, at least the documentation could
say that 'objects are addressed by their hashes', which says a whole
lot in one quick sentence about how git works.
