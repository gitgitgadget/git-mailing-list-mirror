From: Johan Herland <johan@herland.net>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 10 Nov 2011 09:02:53 +0100
Message-ID: <CALKQrgfZtELcK3H5ZYvmcW8RrtKMVRACFTvw3s5SidFvmFWkGw@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org>
	<1319969101.5215.20.camel@dabdike>
	<CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
	<1320049150.8283.19.camel@dabdike>
	<CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
	<7vy5w1ow90.fsf@alter.siamese.dyndns.org>
	<CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
	<7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
	<CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
	<7vk47jld5s.fsf@alter.siamese.dyndns.org>
	<CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
	<CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
	<CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
	<CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
	<7v62j1gitn.fsf@alter.siamese.dyndns.org>
	<7vvcr1f38j.fsf@alter.siamese.dyndns.org>
	<CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
	<7v4nydurzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Thu Nov 10 09:31:09 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ROQ2O-0005G5-Lc
	for glk-linux-kernel-3@lo.gmane.org; Thu, 10 Nov 2011 09:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933704Ab1KJIa5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 10 Nov 2011 03:30:57 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:60574 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757458Ab1KJIax convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2011 03:30:53 -0500
X-Greylist: delayed 1673 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Nov 2011 03:30:53 EST
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ROPb7-00001e-9I; Thu, 10 Nov 2011 09:02:57 +0100
Received: by iage36 with SMTP id e36so2624748iag.19
        for <multiple recipients>; Thu, 10 Nov 2011 00:02:53 -0800 (PST)
Received: by 10.42.129.137 with SMTP id q9mr6433685ics.18.1320912173728; Thu,
 10 Nov 2011 00:02:53 -0800 (PST)
Received: by 10.42.229.193 with HTTP; Thu, 10 Nov 2011 00:02:53 -0800 (PST)
In-Reply-To: <7v4nydurzh.fsf@alter.siamese.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185217>

On Wed, Nov 9, 2011 at 18:26, Junio C Hamano <gitster@pobox.com> wrote:
> =C2=A0- "git notes" is represented as a commit that records a tree th=
at holds
> =C2=A0 the entire mapping from commit to its annotations, and the onl=
y way to
> =C2=A0 transferr it is to send it together with its history as a whol=
e. It
> =C2=A0 does not have the nice auto-following property that transfers =
only the
> =C2=A0 relevant annotations.

True. However, consider these mitigating factors:

 - The annotations in question (the "signing" of commits) are all inten=
ded to
   be merged eventually (i.e. there is no reason for a developer to (af=
ter the
   fact) sign a commit that will never end up in the public record). Th=
erefore,
   most or all of the notes in the notes tree are already relevant, or
will become
   relevant in the near future (when the associated commits are merged)=
=2E

 - Additionally, you could organize these notes into two (or more) note=
s trees,
   one for merged/official annotations, and one for unmerged/pending
annotations.
   Then make the relevant tools (e.g. "git merge") transfer notes from =
one tree
   to the other, thereby making sure that the "official" record only co=
ntains
   notes that are relevant to the merged history.

 - Finally, there's always "git notes prune" to purge annotations for c=
ommits
   that ended up never being merged.

My point is that although "notes" might end up transferring more annota=
tions
than strictly necessary, I believe that in practice all the notes
being transferred
are already (or will soon become) relevant.

> =C2=A0+ "git notes" maps the commits to its annotations in the right =
direction;
> =C2=A0 the object name of an annotated object to its annotation.
>
> In the longer term, I think we would need to extend the system in the
> following way:
>
> =C2=A0- Introduce a mapping machanism that can be locally used to map=
 names of
> =C2=A0 the objects being annotated to names of other objects (most li=
kely
> =C2=A0 blobs but there is nothing that fundamentally prevents you fro=
m
> =C2=A0 annotating a commit with a tree). The current "git notes" migh=
t be a
> =C2=A0 perfectly suitable representation of this, or it may turn out =
to be
> =C2=A0 lacking (I haven't thought things through), but the important =
point is
> =C2=A0 that this "mapping store" is _local_. fsck, repack and prune n=
eed to be
> =C2=A0 told that objects that store the annotation are reachable from=
 the
> =C2=A0 annotated objects.

IMHO this is precisely what "git notes" does today.

> =C2=A0- Introduce a protocol extension to transfer this mapping infor=
mation for
> =C2=A0 objects being transferred in an efficient way. When "rev-list =
--objects
> =C2=A0 have..want" tells us that the receiving end (in either fetch/p=
ush
> =C2=A0 direction) would have an object at the end of the primary tran=
sfer
> =C2=A0 (note that I did not say "an object will be sent in this trans=
fer
> =C2=A0 transaction"; "have" does not come into the picture), we make =
sure that
> =C2=A0 missing annotations attached to the object is also transferred=
, and new
> =C2=A0 mapping is registered at the receiving end.
>
> The detailed design for the latter needs more thought. The auto-follo=
wing
> of tags works even if nothing is being fetched in the primary transfe=
r
> (i.e. "git fetch" && "git fetch" back to back to update our origin/ma=
ster
> with the master at the origin) when a new tag is added to ancient par=
t of
> the history that leads to the master at the origin, but this is exact=
ly
> because the sending end advertises all the available tags and the obj=
ects
> they point at so that we can tell what new tags added to an old objec=
t is
> missing from the receiving end. This obviously would not scale well w=
hen
> we have tens of thousands of objects to annotate. Perhaps an entry in=
 the
> "mapping store" would record:
>
> =C2=A0- The object name of the object being annotated;
>
> =C2=A0- The object name of the annotation;
>
> =C2=A0- The "timestamp", i.e. when the association between the above =
two was
> =C2=A0 made--this can be local to the repository and a simple counter=
 would
> =C2=A0 do.
>
> and also maintain the last "timestamp" this repository sent annotatio=
ns to
> the remote (one timestamp per remote repository). When we push, we wo=
uld
> send annotations pertaining to the object reachable from what we are
> pushing (not limited by what they already have, as the whole point of=
 this
> exercise is to allow us to transfer annotations added to an object lo=
ng
> after the object was created and sent to the remote) that is newer th=
an
> that "timestamp". Similarly, when fetching, we would send the "timest=
amp"
> this repository last fetched annotations from the other end (which me=
ans
> we would need one such "timestamp" per remote repository) and let the
> remote side decide the set of new annotations they added since we las=
t
> synched that are on objects reachable from what we "want".
>
> Or something like that.

You would also have to keep track of deleted annotations, to enable the=
 local
side to delete an annotation corresponding to an already-deleted annota=
tion
on the remote side.

Pretty soon, you end up having to record something similar to a DAG,
describing the history of manipulating these annotations. At that point=
, your
"timestamp" calculation starts to look very similar to the "have..want"
calculation already done when transferring "regular" refs. At which poi=
nt you
have a system that is very similar to what "git notes" does today...


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
