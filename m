From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 11:54:12 +0100
Message-ID: <AANLkTimoz6Ux18mtmm4oVr21p6RmKURgcWWK8JkWvmu5@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
	<AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
	<20100902192910.GJ32601@spearce.org>
	<m3y6bjnadu.fsf@localhost.localdomain>
	<AANLkTikSHXivniUk-1KU30Ws23ebnbDhOmjKmpmVH-Y9@mail.gmail.com>
	<alpine.LFD.2.00.1009021931340.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 12:54:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrTuY-0006qp-Nf
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 12:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182Ab0ICKyO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 06:54:14 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38531 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab0ICKyN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 06:54:13 -0400
Received: by vws3 with SMTP id 3so1249702vws.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u8VP6nXNODlJ3w48JZj/R4QmApagOzh2Rn+TkVKB9ew=;
        b=bgf4xUya0iFEAQJjX4Ja7rOa+4J5x8K/oWrRuBiEQMsPsaDX7tqevC4JMOtpquhsHL
         nmBm0MsVSvNc3l+SBnZOfcqmUQze74dxGGYk7JhDbsyxF432c+keEiTNqPnYKhC+awB+
         DdMRQ8BKgc4CPpiHfdLH6AbENQaCpzeCzeI30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rUtsozpU4fzq1DGd50KwjYraJx9LBcuVRyoMWow8kZT3QS8GIZoqQCmzgJVyqPyqtx
         juK0k4EfcWeXF9F2D3ihLvghOZxjPLUeY8IT4qznzMQwLxpYIA6Txp9NehhAFTOaFkpm
         XXc+WGX3nZOwhTPj0Z9v+OAodLKoOXn7J9jwk=
Received: by 10.220.62.5 with SMTP id v5mr434475vch.170.1283511252125; Fri, 03
 Sep 2010 03:54:12 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Fri, 3 Sep 2010 03:54:12 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009021931340.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155242>

have a bit more time.

On Fri, Sep 3, 2010 at 1:29 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> pack, you'd have to _delete_ them from the receiving end so as to
>> avoid polluting the recipient's object store haaarrgh *spit*, *cough=
*.
>
> Well, actually there is no need to delete anything. =C2=A0Git can cop=
e with
> duplicated objects just fine. =C2=A0A subsequent gc will get rid of t=
he
> duplicates automatically.

 excellent.  good to hear.

>> =C2=A0what _might_ work however iiiiIiis... to split the pack-object=
 into
>> two parts. =C2=A0or, to add an "extra part", to be more precise:
>>
>> a) complete list of all objects. =C2=A0_just_ the list of objects.
>> b) existing pack-object format/structure.
>>
>> in this way, the sender having done all the hard work already of
>> determining what objects are to go into a pack-object, transfers tha=
t
>> *first*. =C2=A0_theeen_ you begin transferring the pack-object. =C2=A0=
theeeen,
>> if the pack-object transfer is ever interrupted, you simply send bac=
k
>> that list of objects, and ask "uhh, you know that list of objects we
>> were talking about? =C2=A0well, here it is *splat* - are you able to
>> recreate the pack-object from that, for me, and if so please gimme
>> again"
>
> Well, it isn't that simple.
>
> First, a resumable clone is useful only when there is a big transfer =
in
> play. =C2=A0Otherwise it isn't worth the trouble.
>
> So, if the clone is big, then this list of objects can be in the
> millions. =C2=A0For example my linux kernel repo with a couple branch=
es
> currently has:
>
> $ git rev-list --all --objects | wc -l
> 2808136
>
> So, 2808136 objects, with 20-byte SHA1 for each of them, and you have=
 a
> 54 MB object list to transfer already.

 ok:

 a) that's fine.  first time, you have to do that, you have to do that.

 b) i have some ideas in mind, to say things like "i already have the
following objects up to here, please give me a list of everything
since then".

 > And even then, what if the transfer crashes during that object list
> transfer? =C2=A0On flaky connections this might happen within 54 MB.

 that's fine: i envisage the object list being cached at the remote
end (by the first seed), and also being a "shared file", such that
there may even be complete copies of that "file" out there already,
such that resumption is a non-issue.

>> and, 10^N-1 times out of 10^N, for reasons that shawn kindly
>> explained, i bet you the answer would be "yes".
>
> For the list of objects, sure. =C2=A0But that isn't a big deal. =C2=A0=
It is easy
> enough to tell the remote about the commits we already have and ask f=
or
> the rest. =C2=A0With a commit SHA1, the remote can figure out all the=
 objects
> we have. But all is in that determination of the latest commit we hav=
e.
> If we get a partial pack, it is possible to somehow salvage as many
> objects from it, and determine what top commit(s) that correspond to.
> It is possible to set your local repo just as if you had requested a
> shallow clone and then the resume would simply be a deepening of that
> shallow clone.

 i'll need to re-read this when i have more time.  apologies.

> Another issue is what to do with objects that are themselves huge.

 that's fine, too: in fact, that's the perfect scenario where a
file-sharing protocol excels.

> Yet another issue: what to do with all those objects I've got in my
> partial pack, but that I can't connect to any commit yet. =C2=A0We do=
n't want
> them transferred again but it isn't easy to tell the remote about the=
m.
>
> You could tell the remote: "I have this pack for this commit from thi=
s
> commit but I got only this amount of bytes from it, please resume
> transfer here."

 ok i have a couple of ideas/thoughts

a) one of which was to send the commit index list back to the remote
end, but that would be baaaaad as it could be 54mb as you say, so it
would be necessary to say "here is the SHA1 of the index file you gave
me earlier, do you still have it, if so please can we resume

b) as long as _somebody_ has a complete copy, distributed throughout
the file-sharing network, of that complete pack, "resume transfer
here" isn't .... the concept is moot.  the bittorrent protocol covers
that concept of "resume" very very easily.

>=C2=A0But as mentioned before the pack stream is not
> deterministic,

 one a one-off basis, it is; and even then, i believe that it could be
made to "not matter".  so you ask a server for a pack object and get a
different SHA-1?  so what, you just make that part of the
file-sharing-network unique key: {ref}-{objref}-{SHA-1} instead of
just {ref}-{objref}.  if the connection's lost, wow big deal, you just
ask again and you end up with a different SHA-1.  you're back to a
situation which is actually no different from and no less efficient
than the present http transfer system.

 ... but i'd rather avoid this scenario, if possible.

> and we really don't want to make it single-threaded on a
> server. =C2=A0Furthermore this is a lot of work for the server as eve=
n if the
> pack stream is deterministic, then the server still has to recreate t=
he
> first part of the pack just to throw it away until the desired offset=
 is
> reached. =C2=A0And caching pack results also has all sorts of implica=
tions
> we've prefered to avoid on a server for security reasons (better keep
> serving operations read-only).

 i've already thrown out the idea of cacheing the pack objects
themselves, but am still exploring the concept of cacheing the .idx
file, even for short periods of time.

 so the server does a lot of work creating that .idx file, but it
contains the complete list of all objects, which you _could_ just
obtain again by just asking explicitly for each and every single one
of those objects, no more, no less, no deltas, no windows - the list,
the whole list and nothing but the list.

>> ... um... in fact... um... i believe i'm merely talking about the .i=
dx
>> index file, aren't i? =C2=A0because... um... the index file contains=
 the
>> list of object refs in the pack, yes?
>
> In one pack, yes. =C2=A0You might have multiple packs. =C2=A0And that=
 doesn't mean
> that all the objects from a pack are all relevant to the actual branc=
hes
> you are willing to export.

 yes that's fine.  multiple packs are considered to be independent
files of the "VFS layer" in the file-sharing network.  that's taken
care of.  what i need to know is: can you recreate a pack object given
the list of objects in its .idx file?

>> sooo.... taking a wild guess, here: if you were to parse the .idx fi=
le
>> and extract the list of object-refs, and then pass that to "git
>> pack-objects --window=3D0 --delta=3D0", would you end up with the ex=
act
>> same pack file, because you'd forced git pack-objects to only return
>> that specific list of object-refs?
>
> If you do this i.e. turn off delta compression, then the 615 MB
> repository above will turn itself into a multi-gigabyte pack!

 ok this was covered in my previous post, hope it's clearer.  perhaps
"git pack-objects --window=3D0 --delta=3D0 <
{list-of-objects-extracted-from-the-idx-file}" isn't the way to
achieve what i envisage - if not, does anyone have any ideas on how
extracting the exact list of objects as previously given by a .idx
file can be achieved?

l.
