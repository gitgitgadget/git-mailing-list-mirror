From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 18:10:58 +0100
Message-ID: <998d0e4a0802230910o1cd087f1y6b2398cfde4cfe08@mail.gmail.com>
References: <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr>
	 <7vfxvk4f07.fsf@gitster.siamese.dyndns.org>
	 <20080223020913.GL27894@ZenIV.linux.org.uk>
	 <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com>
	 <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com>
	 <20080223113952.GA4936@hashpling.org>
	 <998d0e4a0802230508w12f236baiaf2d9ab5f364670a@mail.gmail.com>
	 <20080223131749.GA5811@hashpling.org>
	 <998d0e4a0802230536w74e93ec3s40c77d52b183a419@mail.gmail.com>
	 <20080223140153.GB5811@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Charles Bailey" <charles@hashpling.org>,
	LKML <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 18:12:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSxvD-0002v8-4G
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 18:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYBWRLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 12:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbYBWRLG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 12:11:06 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:4798 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbYBWRLC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 12:11:02 -0500
Received: by ti-out-0910.google.com with SMTP id 28so535388tif.23
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 09:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=m6Tz2jDNohbB33yWisH0pErKsnr++EmzvBqibHpTfzQ=;
        b=BvXcZ/qKMlRtMs3ri9dp4jJVgRQvPU8vsVQJ0hJWkGbZUbCNsW0GmjZnineide49SBTHNpZoZNZiqrzaqAmwUT9PSlUB6PylRDW8M42NkqPp/mx4OUo6Wb/JHKm6SacWX/kkwR6Md2Ef0uTgOHoUXr/GBdPXUTqh3raeG/Q0Tws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kgNVBSESNmC8x7tIHIOYOoB5sjgSdIn5MvnEeWYro5tiFNH2ckYepKe+5zVe3kZXJN0E1slILTMZtmz6+NuHjDKhILEXJFieThWDNgghwFK1wSq3wLU/Chj0ruIBDqdC0lWimqBCozYQzSFz8EoYYRBYPp1T4azGcvWEnTvmyBo=
Received: by 10.110.20.17 with SMTP id 17mr396824tit.47.1203786658782;
        Sat, 23 Feb 2008 09:10:58 -0800 (PST)
Received: by 10.70.40.12 with HTTP; Sat, 23 Feb 2008 09:10:58 -0800 (PST)
In-Reply-To: <20080223140153.GB5811@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74828>

On 2008/2/23, Charles Bailey <charles@hashpling.org> wrote:
> On Sat, Feb 23, 2008 at 02:36:59PM +0100, J.C. Pizarro wrote:
>  > On 2008/2/23, Charles Bailey <charles@hashpling.org> wrote:
>  > >
>
> > > It shouldn't matter how aggressively the repositories are packed or what
>  > >  the binary differences are between the pack files are. git clone
>  > >  should (with the --reference option) generate a new pack for you with
>  > >  only the missing objects. If these objects are ~52 MiB then a lot has
>  > >  been committed to the repository, but you're not going to be able to
>  > >  get around a big download any other way.
>  >
>  > You're wrong, nothing has to be commited ~52 MiB to the repository.
>  >
>  > I'm not saying "commit", i'm saying
>  >
>  > "Assume A & B binary git repos and delta_B-A another binary file, i
>  > request built
>  > B' = A + delta_B-A where is verified SHA1(B') = SHA1(B) for avoiding
>  > corrupting".
>  >
>  > Assume B is the higher repacked version of "A + minor commits of the day"
>  > as if B was optimizing 24 hours more the minimum spanning tree. Wow!!!
>  >
>
>
> I'm not sure that I understand where you are going with this.
>  Originally, you stated that if you clone a 775 MiB repository on day
>  one, and then you clone it again on day two when it was 777 MiB, then
>  you currently have to download 775 + 777 MiB of data, whereas you
>  could download a 52 MiB binary diff. I have no idea where that value
>  of 52 MiB comes from, and I've no idea how many objects were committed
>  between day one and day two. If we're going to talk about details,
>  then you need to provide more details about your scenario.

I don't said that "A & B binary git repos" are binary files, but i said that
delta_B-A is a binary file.

I said ago ~15 hours "Suppose the size cost of this binary delta is e.g. around
52 MiB instead of 2 MiB due to numerous mismatching of binary parts ..."

The binary delta is different to the textual delta (between lines of texts)
 used in the git scheme (the commits or changesets use textual deltas).
The textual delta can be compressed resulting a smaller binary object.
Collecting binary objects and some more is the git repository.
You can't apply textual delta of git repository, only binary delta.
You can apply binary delta of both git-repacked repositories if there
is a program
 that generates binary delta of both directories but it's not implement yet.
The SHA1 verifier is useful for avoid the corrupting of the generated repository
 (if it's corrupted then it has to be cloned again delta or whole
until non-corrupted).
An example of same SHA1 of both directories can be implemented as same SHA1
 of sorted SHA1s of contents, filenames and properties. Anything
alterated, added
 or eliminated from them implies different SHA1.

Don't you understand i'm saying? I will give you a practical example.
1. zip -r -8  foo1.zip foo1  # in foo1 there are tons of information
as from git repo
2. mv foo1 foo2 ; cp bar.txt foo2/
3. zip -r -9 foo2.zip foo2   # still little bit more optimized (=
higher repacked)
4. Apply binary delta between foo1.zip & foo2.zip with a supposed program
     deltaier and you get delta_foo1_foo2.bin. The size(delta_foo1_foo2.bin) is
     not nearly ~( size(foo2.zip) - size(foo1.zip) )
5. Apply hexadecimal diff and you will understand why it gives the exemplar
     ~52 MiB instead of ~2 MiB that i said it.
6. You will know some identical parts in both foo1.zip and foo2.zip.
     Identical parts are good for smaller binary deltas. It's possible to get
     still smaller binary deltas when their identical parts are in
random offsets
     or random locations depending of how deltaier program is advanced.
7. Same above but instead of both files, apply binary delta of both directories.

>  Having said that, here is my original point in some more detail. git
>  repositories are not binary blobs, they are object databases. Better
>  than this, they are databases of immutable objects. This means that to
>  get the difference between one database and another, you only need to
>  add the objects that are missing from the other database.

Databases of immutable objects <--- You're wrong because you confuse.
There are mutable objects as the better deltas of min. spanning tree.

The missing objects are not only the missing sources that you're thinking,
they can be any thing (blob, tree, commit, tag, etc.). The deltas of the
minimum spanning tree too are objects of the database that can be erased
or added when the spanning tree is alterated (because the alterated spanning
tree is smaller than previous) for better repack. Best repack is still
NP-problem
and to solve this bigger NP-problem of each day is 24/365 (eternal computing).

The git database is the top-level ".git/" directory but it has repacked binary
information and has always some size measured normally in MiBs that i was
saying above.

>                                                                        If the two
>  databases are actually a database and the same database at short time
>  interval later, then almost all the objects are going to be common and
>  the difference will be a small set of objects. Using git:// this set
>  of objects can be efficiently transfered as a pack file.

You're saying    repacked(A) + new objects   with the bandwith cost of
new objects
but i'm saying  rerepacked(A+new objects)   with the bandwith cost of
binary delta
                                   where delta is repacked(A) -
rerepacked(A+new objects)
                                         and rerepacked(X) is more
time repacking again X.

>                                                                                     You may have
>  a corner case scenario where the following isn't true, but in my
>  experience an incremental pack file will be a more compact
>  representation of this difference than a binary difference of two
>  aggressively repacked git repositories as generated by a generic
>  binary difference engine.

Yes, it's more simple and compact, but the eternal repacking 24/365 can do it
 e.g. 30% smaller after few weeks when the incremental pack has made nothing.

It's good idea that the weekly user picks the binary delta and the
daily developer
 picks the incremental pack. Put both modes working in the git server.

>  I'm sorry if I've misunderstood your last point. Perhaps you could
>  expand in the exact issue that are having if I have, as I'm not sure
>  that I've really answered your last message.

   Misunderstood can be dissappeared ;)
