From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sun, 5 Sep 2010 19:05:57 +0100
Message-ID: <AANLkTi=YLx6MqbWd_N0geXbuXLdqAUOneGoym75dfthL@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
	<AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
	<4C81A67B.2060400@gmail.com>
	<alpine.LFD.2.00.1009032304560.19366@xanadu.home>
	<4C81DC34.2090800@gmail.com>
	<alpine.LFD.2.00.1009040153280.19366@xanadu.home>
	<AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
	<AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
	<alpine.LFD.2.00.1009042132500.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 05 20:06:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJbQ-0003t1-Dk
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 20:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112Ab0IESF7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 14:05:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63154 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab0IESF6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 14:05:58 -0400
Received: by vws3 with SMTP id 3so2729789vws.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sZNwhnBgB0bvKS5WIcbwrMtcsnvfwUF1widAObhAf+Y=;
        b=Iu6yUE27VlGIdl838rScSpT+IfqujFzcuWbqFgAfGXatLyzbEbytHObMZwkgPdhZvb
         dLbUZXO2mMkgQxhI93mJbO6NHyPPtIFMik+uALVwbB8k0Tyd5VQGi2n4CnQfwUMX/ciT
         9rPs1tJyUTwn/epEeW4JAeRZbAopWfNSqAQVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zv3Mlcg2V3TG/leoGuVLYA/z9z2dYvudMHnhYt74stFQvBmRYEHhs3iYEVWZVWghXq
         egzSfdQqUwnRl/EwACzf/22386eQEvVvNeBT3pVlxvxqD7UXBcB30yW4uS3OSmILixU1
         Bfda6I0i4sQ1UhI5XOZOmV9gZx8xgqFvZukts=
Received: by 10.220.62.197 with SMTP id y5mr1546547vch.3.1283709957605; Sun,
 05 Sep 2010 11:05:57 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sun, 5 Sep 2010 11:05:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009042132500.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155472>

On Sun, Sep 5, 2010 at 3:16 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 4 Sep 2010, Luke Kenneth Casson Leighton wrote:
>
>> * git-index-pack requires a pack file in order to re-create the inde=
x:
>> i don't want that
>> * git-pack-objects appears to have no way of telling it "just gimme
>> index file please"
>> * fast-import.c appears not to be what's needed either.
>>
>> so - any other methods for just getting the index file (exclusively?=
)
>> any other commands i've missed? =C2=A0if not, are there any other wa=
ys of
>> getting a pack's index of objects without err... getting the index
>> file? =C2=A0(i believe the answer to be no, but i'm just making sure=
) and
>> on that basis i believe it is safe to ask: any objections to a patch
>> which adds "--index-only" to builtin/pack-objects.c?
>
> No patch is needed.
>
> First, what you want is an index of objects you are willing to share,
> and not the index of whatever pack file you might have on your disk,
> especially if you have multiple packs which is typical.

 blast.  so *sigh* ignoring the benefits that can be obtained by the
delta-compression thing, somewhat; ignoring the fact that perhaps less
traffic miight be transferred by happening to borrow objects from
another branch (which is the situation that, i believe, happens with
"git pull" over http:// or git://); ignoring the fact that i actually
implemented using the .idx file yesterday ... :)

 ... there is a bit of a disadvantage to using pack index files that
it goes all the way down (if i am reading things correctly) and cannot
be told "give me just the objects related to a particular commit"....


> Try this instead:
>
> =C2=A0 =C2=A0git rev-list --objects HEAD | cut -c -40 | sort
>
> That will give you a sorted list of all objects reachable from the
> current branch. =C2=A0With the Linux repo, you may replace "HEAD" wit=
h
> "v2.6.34..v2.6.35" if you wish, and that would give you the list of t=
he
> new objects that were introduced between v2.6.34 and v2.6.35.

 ... unlike this, which is in fact much more along the lines of what i
was looking for (minus the loveliness of the delta compression oh
well)

>=C2=A0This will
> provide you with 84642 objects instead of the 1.7 million objects tha=
t
> the Linux repo contains (easier when testing stuff).

 hurrah! :)  [but, then if you actually want to go back and get alll
commits, that's ... well, we'll not worry about that too much, given
the benefits of being able to get smaller chunks.]

> That sorted list of objects is more or less what the pack index file
> contains, plus an offset in the pack for each entry. =C2=A0It is used=
 to
> quickly find the offset for a given object in the corresponding pack
> file, and the fanout is only a way to cut 3 iterations in the binary
> search.
>
> But anyway, what you want is really to select the precise set of obje=
cts
> you wish to share, and not blindly using the pack index file. =C2=A0I=
f you
> have a public branch and a private branch in your repository, then
> objects from both branches may end up in the same pack

 slightly confused: are you of the belief that i intend to ignore
refs/branches/* starting points?

> and you probably
> don't want to publish those objects from the private branch.

 ahh, i wondered where i'd seen the bit about "confusing" two
branches, i thought it was in another message.  so many flying back &
forth :)  from what i can gather, this is exactly what happens with
git fetch from http:// or git:// so what's the big deal about that?
why stop gitp2p from benefitting from the extra compression that could
result from "borrowing" bits of another branch's objects, neh?

 or .. have i misunderstood?

> The only
> reliable way to generate a list of object is to use the output from '=
git
> rev-list'. =C2=A0Those objects may come from one or multiple packs, o=
r be
> loose in the object subdirectories, or even borrowed from another
> repository through the alternates mechanism. =C2=A0But rev-list will =
dig
> those object SHA1s for you and only those you asked for.

 excellent.  that's proobably what i need right now.

> You should look at the Git documentation for plumbing commands. =C2=A0=
The
> plumbing is actually a toolset that allows you to manipulate and extr=
act
> information from a Git repository. =C2=A0This is really handy for pro=
totyping
> new functionalities. Initially, the Git user interface was all
> implemented in shell scripts on top of that plumbing.

 i'm using gitdb (ok don't need that any more, if i don't walk the
pack-index file *sigh*) and python-git - am quite happy with the speed
at which i can knock stuff together, using it.  the only tricky wobbly
moment i had was not being able to pass in a file-handle to stdin (git
pack-objects) and i got round that with "input =3D os.tmpfile();
input.write(objref+"\n"); input.seek(0)".

> Back to that rev-list output... OK, you want the equivalent of a fano=
ut
> table. =C2=A0You may do something like this then:
>
> =C2=A0 =C2=A0git rev-list --objects v2.6.34..v2.6.35 | cut -c -2 | so=
rt | uniq -c

  ack.  got it.

 thanks nicolas.

l.
