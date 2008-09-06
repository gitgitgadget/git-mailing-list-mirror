From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Git Community Book
Date: Sat, 6 Sep 2008 11:14:22 -0700
Message-ID: <d411cc4a0809061114k6b9f01b9sdf479360d4cb4c41@mail.gmail.com>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
	 <7vmyimv0qr.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0809051434g4e92790fsa38d12487630aa9f@mail.gmail.com>
	 <20080906063325.GD28035@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"git list" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 06 20:15:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc2Jn-0004ad-Oo
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 20:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbYIFSOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 14:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYIFSOY
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 14:14:24 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:29003 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYIFSOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 14:14:23 -0400
Received: by wa-out-1112.google.com with SMTP id j37so655379waf.23
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yeheCSssIUJqNNpzQqbHsRWEQVSbONgSiF2iryqYHYc=;
        b=jva+kgVlFQbbTwlh6mINbwEBYp99j/GCKwPmQ42aFw/HTNbGd6YufriYSvJ6AyEd6y
         L0uLRsZMIM7C8L/J69dNutLIBnSiip+2EQrjdQpxwurHZjk3CSDomUDq2av2Fcp2uTry
         SehrE02zrQ4JbZee8Hm9z4uj50nFsZZT5oCuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fZVyChJPj6BE2VWJLLPwE8xN0rLZ6vG8WQTxXz+oupE2U7PLGNOd9fdyiNIvbGWD3r
         NpkJEJEQrBu3CryHJMV6ddiwtTfyrB4rztb0axCaX37mrmlhLjqJ4Us9m9be2uAHiRQw
         M+s4uB0X2FFdDRNXZTg4A+ouA9DzK1u/LQM94=
Received: by 10.114.47.12 with SMTP id u12mr11089925wau.187.1220724862480;
        Sat, 06 Sep 2008 11:14:22 -0700 (PDT)
Received: by 10.114.135.18 with HTTP; Sat, 6 Sep 2008 11:14:22 -0700 (PDT)
In-Reply-To: <20080906063325.GD28035@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95086>

Thanks a ton for this, I'll incorporate all of this.

On Fri, Sep 5, 2008 at 11:33 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Scott Chacon <schacon@gmail.com> wrote:
>> On Fri, Sep 5, 2008 at 12:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > "Scott Chacon" <schacon@gmail.com> writes:
>> >
>> >> Also, the last section of the book is on some of the plumbing - mostly
>> >> stuff I've found difficult to pick up with the existing documentation
>> >> while re-implementing stuff in Ruby.  I would really appreciate it if
>> >> someone could proofread some of these chapters for errors:
>> >>
>> >> http://book.git-scm.com/7_the_packfile.html
>
> OK, time for me to throw in comments.  ;-)
>
> I do like this book, its organized and concise.  Thanks for doing it.
>
>
> http://book.git-scm.com/7_how_git_stores_objects.html:
>
> The loose object formatting of
>
>  header = "#{type} #{size}#body"
>  store = header + content
>
> I can't read Ruby so I'm not sure what the header value computes
> out to here.  #body should be a \0.  I'm also not sure that the
> prior line setting size = content.length.to_s is very clear for
> the non-Ruby people to understand how a size is formatted.
>

Sorry, the markdown thingy is translating all the '\0's to '#body' for
some freaking reason unless I write it as '\\0'.  I'll fix this - it's
difficult for me to find these sometimes.  As for the rest of the ruby
stuff, I think I'll add some comments.

> If the code shown here is the Ruby implementation I'm a little
> concerned about it writing directly into the loose object.  If the
> write is partial then you have a partial object which is at the
> right name, but is unusable.  That can give you corruption that
> is difficult to track down and fix.  C Git and JGit both write
> to temporary files then atomically move the temporary file into
> position under its proper name only after it has been fully written.

That is a good idea - I don't do it that way and I certainly will
change the implementation to do so and modify these docs to reflect
that advice.

> "When objects are written to disk, it is often in the loose format,
> since that format is less expensive to access."
>
> I'm not sure that statement is true.  Access from packs tends
> to scream compared to access from loose objects.  The overheads
> of opening and closing the file descriptors, even on Linux, is
> what kills performance for data access.  However Git writes to
> loose objects first and packs later for _safety_ not efficiency.
> Although it is a lot more efficient to write a 2 KB loose object
> and avoid rewriting a 50 MB pack, but its also less likely to fail
> and make you lose your work.

Thanks for the clarification.  I write to loose objects first largely
because it's so much easier to do.  But also because I don't mmap
objects, so packfile access is not faster for implementations that
can't do that very well.  Also, I had originally meant "less expensive
to write", but I can see that is not clear.


> http://book.git-scm.com/7_the_git_index.html:
>
> I wouldn't say that the index stores permissions.  More like it
> stores the "class" or "type" of the thing located at that path.
> There are 4 major classes:
>
>        - regular file
>        - executable file
>        - symbolic link
>        - git submodule
>
> The 5th class is the subtree, but only appears in trees and not
> in the index since the index file is actually flat.

Interesting.  This documentation is actually from the User Manual -
I'll update this chapter first and if it looks better, I'll submit a
patch to the UM, too.

> http://book.git-scm.com/7_the_packfile.html:
>
> You should probably point out that the .idx file uses network byte
> order for the numeric fields like the version number and the file
> offsets.

Will do.

>
> I'd also point out that the offsets in index v1 are unsigned and
> from the start of the pack file.  The offsets in index v2 are
> also unsigned, but the 1<<31 is tested in the 32 bit offset to
> see if a 64 bit offset is used.  The algorithm there is:
>
>        if offset32 & 1<<31:
>                offset = ofs64_table[offset32 & ~(1<<31)]
>        else
>                offset = offset32
>
> Its also rather unclear how the fan out table can be used to limit
> the binary search.  What you are missing is describing that fanout[X]
> holds the number of objects whose first byte of their SHA-1 is <= X.
> Hence fanout[0] has the number of objects whose SHA-1 starts with
> "00" and fanout[0x15] has the number of objects whose SHA-1 starts
> with "15", "14", "13", ..., "00".  Thus fanout[0xff] has the total
> number of objects in the pack.
>
> In the pack file section I'd also point out the version and entry
> count are unsigned network byte order.  This is not clear from the
> Ruby code, although one can guess at it if one knows the git.git
> code very very well (like I do).
>
> "After that, you get a series of packed objects, in order of thier SHAs"
>
> Aside from s/thier/their/ this is not a correct statement _AT ALL_.
>
> The ordering of objects in the packfile is very carefully planned
> by the packer to maximize data locality from most recent -> least
> recent information, making the most recent revisions of a project
> the fastest to access.  This has _NOTHING_ to do with their SHA-1
> names.
>
> Technically a pack may store objects in any random order.  Heck,
> you can wire up an RNG to the packer to always produce a different
> ordering each time you pack.  Practically an implementation shouldn't
> be that stupid and should instead try to order objects by recency,
> like git.git and JGit both do.
>
> "At the end of the packfile is a 20-byte SHA1 sum of all the shas
> (in sorted order) in that packfile."
>
> Also incorrect.  The 20-byte checksum at the end of the pack file
> is a checksum of all bytes preceeding the checksum itself.  We use
> it as an end-to-end data integrity check, especially on the network
> transport to verify that every bit sent by the one side is received
> correctly on the other side.
>

I'm an idiot.  I say this because I actually implemented a bunch of
this stuff (in Ruby) and ran into most of these issues when trying to
implement it.  So I knew these things not 3 weeks ago, but I still
wrote it this way.  Dur.  Thanks for the corrections, I'll update
everything accordingly.

> BTW, can I just say, I love the graphics in this book.  They are
> quite well done.  Very worthwhile.

Thanks.

>
>
> http://book.git-scm.com/7_transfer_protocols.html:
>
> You might as well explain that the stream returned by upload-pack
> uses the same 4 byte line length framing to form "packets", with
> the 5th byte (really first byte of the payload) indicating the
> "stream":
>
>        - stream 1 ('\001') is the PACK data
>        - stream 2 ('\002') is progress data/information
>        - stream 3 ('\003') is the OH S**T we are aborting, died, dead
>
> You may also want to explain that the way you know the end of the
> pack is to read the header, get the entry count, and then read that
> many objects from the stream, and then verify the pack checksum.
>
> --
> Shawn.
>

Thanks again for all the time it must have taken to review all of this
- I'll make sure it gets into the book, and where appropriate, back
into the UM or other internal git docs.

Scott
