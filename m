From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 22:11:22 +0100
Message-ID: <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 23:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrdXl-0001QA-Jx
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 23:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab0ICVLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 17:11:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41053 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab0ICVLX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 17:11:23 -0400
Received: by vws3 with SMTP id 3so1633741vws.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0V4HQsLG/tpBWmWEm9eDWkvriSobYe/GcyIqNvcgZgY=;
        b=FsuMTgrknaHcxnNhERvND6ToF1mgSATDPhD3oVUAakRw613riwnATpEguE8ciqpHrU
         JzovU78mTJFqPLdnNIK606tDvxxQ8cNQQjg7JyO2hjMznsYVbIVq/w3DnFVwAKOkib4t
         WoMf3oVCSXozfI8/Lu6p1tvFekBu+NA4G/wug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Sli8jCo6Zuchf5ufjkKgD5cfqCm3d0t18auBnNEutJ4tqtHnEK8VcK5jArY+pJKrca
         JlO/8fXJbKgSSABzUy85gv/Wb0cPpVl6qV8zT6JTYnGYsfRTER0P2uyC+YV/tSc8PzKg
         CDlTHzqwsBAFuvBR8bwgGZqPAtTg+rFpo1Q74=
Received: by 10.220.62.196 with SMTP id y4mr823602vch.97.1283548282468; Fri,
 03 Sep 2010 14:11:22 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Fri, 3 Sep 2010 14:11:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155273>

On Fri, Sep 3, 2010 at 8:41 PM, Nicolas Pitre <nico@fluxnic.net> wrote:

> I still think that if someone really want to apply the P2P principle =
=C3=A0
> la BitTorrent to Git, then it should be based on the distributed
> exchange of _objects_ as I outlined in a previous email, and not file
> chunks like BitTorrent does. =C2=A0The canonical Git _objects_ are fu=
lly
> defined, while their actual encoding may change.

ok - missed it.  let's go back... ah _ha_ - with this:

"Yep.  Instead of transferring packs, a BitTorrent-alike transfer shoul=
d
be based on the transfer of _objects_.  Therefore you can make the
correspondance between file chunks in BitTorrent with objects in a Git
aware system.  So, when contacting a peer, you could negociate what is
the set of objects that the peer has that you don't, and vice versa.
Objects in Git are stable and immutable, and they all have a unique SHA=
1
signature.  And to optimize the negociation, the pack index content can
be used, first by exchanging the content of the first level
fan-out table and ignoring those entries that are equal.  This for each
peer."

ok, so, great!  it does actually seem that, despite us using different
terminologies, we're thinking along the same sort of lines.  i'm
marginally hampered by being unfamiliar with git, for which i
apologise.

so, when i mentioned extracting the objects from the index file of
"git pack-object", i was debating whether to then use that to
re-create the pack object (in some nebulous way) - that's sort-of the
same thing.  i was also debating whether to mention the idea of using
git pack-object to extract one and only one object ( there is likely a
more efficient way of doing that ).   but, yes: i was thinking of
making the vfs-layer expose individual objects, i just hadn't
mentioned it yet (and missed your earlier reply, nicolas, for which i
apologise).

btw the idea of parsing the fan-out table would not have occurred to
me in a miiiilllion years :)

 i'll take a look at that.  but whilst i'm doing that, the main
question i really need to know is: how do you get one single explicit
object out of git?

tia,

l.
