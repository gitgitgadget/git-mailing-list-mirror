From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: http://tech.slashdot.org/comments.pl?sid=1885890&cid=34358134
Date: Sat, 27 Nov 2010 19:06:13 +0000
Message-ID: <AANLkTima6meFsovFS-15X7CMTD53n=kkvueKrOeN4Yd4@mail.gmail.com>
References: <AANLkTinTsn4PP8VxJX=pUOYKtoybCxqB0+-p9kNRGMj8@mail.gmail.com>
	<AANLkTim0FeCE94R1zacOxGiEP8vZRSoDqNuNRUotnd9B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 20:06:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMQ6H-0007Go-16
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 20:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0K0TGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 14:06:15 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52060 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab0K0TGO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 14:06:14 -0500
Received: by qwb7 with SMTP id 7so3105220qwb.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 11:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nI1RO9DFArxMwQNB1UKXyhrhKGmuKiuO7/cMnUamgcI=;
        b=Jx3yPGYyEjL0hu0Bua+/uiI9ED/kRnmf+pdRcErr8DKvDLMR7C4Xpb+0NaidoLPQkv
         +aQZ6siF8fpO/9FomOw8rQkDaHv+Nfajpb7HEKKT6kIqIrskOQfcPggKncvITnmUgR2S
         FsLCo5wIsl1FNXh5pWAQI/Bf5TfrbGSCDWRL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pYU3qkOgYskD/r13hU661Dp1YZWt/LpKy0ZQ5aqmXG/9F/VLmc6dQk+5YmWJDIGbMd
         SFVZIAum8N90v3e4ZVcb3b6Yiro7oXM3XZM3+4t0k0w+PzHzv93shE9dBFPOrhU3LnQL
         OD3TX+8o0Up2HbDZCH+VU1xKJ+fi2J2GlbCfI=
Received: by 10.224.174.12 with SMTP id r12mr1592545qaz.109.1290884773816;
 Sat, 27 Nov 2010 11:06:13 -0800 (PST)
Received: by 10.220.112.210 with HTTP; Sat, 27 Nov 2010 11:06:13 -0800 (PST)
In-Reply-To: <AANLkTim0FeCE94R1zacOxGiEP8vZRSoDqNuNRUotnd9B@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162324>

On Sat, Nov 27, 2010 at 6:36 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Nov 27, 2010 at 18:33, Luke Kenneth Casson Leighton
> <luke.leighton@gmail.com> wrote:
>
>> I believe it is important that git-over-p2p be given a higher
>> priority than it is at present.
>
> We give "priority" to the stuff people submit patches for. There isn'=
t
> a git-over-p2p because nobody is working on it, would you like to wor=
k
> on it?

 i was / have been.  unfortunately it's unfunded work, and, thanks to
receiving less money than i require for living and for feeding my
family i now face a court hearing on 16th december (3 weeks time)
which has the aim and ultimate goal of making us homeless.  i
therefore respectfull request that you please don't try to make me
feel like i _should_ be working on this in order to "earn your
respect" ( that goes for you too, johnathon ).

> I'm also not convinced that this is actually needed. It's trivial to
> set up a p2p-like network by just emulating a darknet by manually
> adding remotes & fetching/pushing.

 ah.. but that's the single-use case for a single shared repository.
git "as-is" the fetch/push over http is limited to a single
repository.  i'm thinking more in terms of a global network, with
searches for checksummed objects "accidentally" potentially coming
from wildly different repositories.

 the work i did a few months ago showed that just "dropping" git on
top of e.g. the bittorrent protocol as-is, files/dirs mapped to git
objects, wouldn't cut the mustard, because the bloody bittorrent
protocol "chunks" system treats the entire fileset as an ordered but
contiguous "stream" of data (metadata in the actual .torrent file says
how long each of the files are and in what order they are, and this is
utilised at the receiving end to reconstruct the files after the
datablocks have been received.  it means that if you want just one
single file, even of 2 bytes in length, you might have to pull 2
blocks of e.g. 256k and grab the byte and the end of the 1st and the
byte at the beginning of the 2nd! yukk...)

but i believe that a system where each git object was given its own
=2Etorrent file _would_ work, and you utilise DHT or other mechanism
(perhaps even a torrent containing the metadata!) to get the
structural information.  the success of this model depends on everyone
being connected to everyone (a global network), in order to be able to
do a DHT search for the node(s) that are seeding that git object's
torrent file.

 the "global network" concept has the advantage of being far more
robust in the face of DNS take-overs, as you actually just need to
know _one_ DNS name out of potentially an unlimited number of DNS
names (or even an IP address or set of IP addresses) and you're joined
to other peers.

> That's not viable for the stuff that usually gets distributed on p2p
> networks, but it sure is viable when you have people working on the
> same codebase.

 codebase-in-a-git, wiki-in-a-git, website-in-a-git,
backups-of-filesystem-in-a-git (joey hess, one of the most amazing
debian developers around, has done all these things :)

> Which would be the use case for a git-over-p2p client,
> right?

yes it would... but i'm thinking well beyond that :)

at first glance the concept of git-over-darknet for example looks
great.  however it doesn't satisfy what i believe to be one of the key
strategic requirements to be "many-pushers to many-pullers real-time
resilient".  lose access to the darknet, or even if the git server
dies, what do you do??  if it's a darknet, you've got serious
problems: you can't find out who it was!

git-over-p2p on the other hand _would_ be [m-p-t-m-p-r-t-r], because
once the git-objects have been pulled by one client, they can be
pulled from that client by other clients too.  it's this feature of
p2p distribution that is so distinct from the way in which git is
normally described as "a distributed revision control system", and
makes it a bugger to explain what the fuss is all about over this
git-p2p stuff :)

 l.
