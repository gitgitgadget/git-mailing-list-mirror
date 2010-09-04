From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 15:06:29 +0100
Message-ID: <AANLkTim1XMY6Qe+h9LpqfoBzFE+B5AobcOpHx1rDfXwZ@mail.gmail.com>
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
	<04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
	<AANLkTikVf=X8cLP9s6W9VGOt0EHE4J5MYsBpgKYhrAri@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 16:06:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrtO9-0000wT-8E
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 16:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab0IDOGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 10:06:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58416 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab0IDOGb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 10:06:31 -0400
Received: by vws3 with SMTP id 3so2120424vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DhQOrALlzUoph+ouEDSVLESgL2/tkeyw3QAvw3RoF7o=;
        b=mijFaOLpIg3dExIVleExG/znLupDSz9gnIHZaiksIDRwi9Kpp/m28VGCJmgKss5fEf
         KTXYqT3ZEXqXwpmaWGZ72hZpNh0PGHDP4tbRGKc0nCmbmVckY6qMQ5hUCgifGkpfxluO
         wzczoBZd2nk2w0LJW+5ppjEP0Z+Xwsawl+T04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P3o3aJWWvC64bdfrM4JN7E5U3menhlJWLYUll8v5yM+q+BdPa8K3ntz85S5T5f5yum
         hMIpq/fGfE3fJxGcPCcLcxPjMWaf4g8p4OZunJPkKFLKlr7DTGYf8fzqnEu9VSn8Oe1v
         N5b0joKHuECItVSIcxWPgkgUXKw5oVCEgo5Ow=
Received: by 10.220.121.206 with SMTP id i14mr1334950vcr.141.1283609190000;
 Sat, 04 Sep 2010 07:06:30 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 07:06:29 -0700 (PDT)
In-Reply-To: <AANLkTikVf=X8cLP9s6W9VGOt0EHE4J5MYsBpgKYhrAri@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155327>

On Sat, Sep 4, 2010 at 6:23 AM, Kyle Moffett <kyle@moffetthome.net> wro=
te:
> So I think the real problem to solve would be: =C2=A0Given a collecti=
on of
> local computers each with many local repositories, what is the best
> way to optimize a clone of a "new" remote repository (over a slow
> link) by copying most of the data from other local repositories
> accessible via a fast link?

 the most immediate algorithm that occurs to me that would be ideal
would be - rsync!  whilst i had the privilege of being able to listen
10 years ago to tridge describe rsync in detail, so am aware that it
is parallelisable (which was the whole point of his thesis), a) i'm
not sure how to _distribute_ it b) i wouldn't have a clue where to
start!

so, i believe that a much simpler algorithm is to follow nicolas' advic=
e, and:

* split up a pack-index file by its fanout (1st byte of SHAs in the idx=
)
* create SHA1s of the list of object-refs within an individual fanout
* compare the per-fanout SHA1s remote and local
* if same, deduce "oh look, we have that per-fanout list already"
* grab the per-fanout object-ref list using standard p2p filesharing

in this way you'd end up breaking down e.g. 50mb of pack-index (for
e.g. linux-2.6.git) into rouughly 200k chunks, and you'd exchange
rouughly 50k of network traffic to find out that you'd got some of
those fanout object-ref-lists already.  which is nice.

(see Documentation/technical/pack-format.txt, "Pack Idx File" for
description of fanouts, but according to gitdb/pack.py it's just the
1st byte of the SHA1s it points to)

> The goal would be to design a P2P protocol capable of rapidly and
> efficiently building distributed searchable indexes of ordered commit=
s
> that identify which peer(s) contain that each commit.

 yyyyup.

> When you attempt to perform a "git fetch --peer" from a repository, i=
t
> would quickly connect to a few of the metadata index nodes in the P2P
> network and use them to negotiate "have"s with the upstream server.
> The client would then sequentially perform the local "fetch"
> operations necessary to obtain all the objects it used to minimize th=
e
> commit range with the server. =C2=A0Once all of those "fetch" operati=
ons
> completed, it could proceed to fetch objects from the server normally=
=2E

 why stop at just fetching objects only from the server?  why not have
the objects distributed as well?  after all, if one peer has just gone
to all the trouble of getting an object, surely it can share it, too?

 or am i misunderstanding what you're describing?

> Some amount of design and benchmarking would need to be done in order
> to figure out the most efficient indexing algorithm for finding a
> minimal set of "have"s of potentially thousands of refs, many with
> independent root commits. =C2=A0For example if the index was grouped
> according to "root commit" (of which there may be more than one), you
> *should* be able to quickly ask the server about a small list of root
> commits and then only continue asking about commits whose roots are
> all known to the server.

 intuitively i follow what you're saying.

> The actual P2P software would probably involve 2 different daemon
> processes. =C2=A0The first would communicate with each other and with=
 the
> repositories, maintaining the ref and commit indexes. =C2=A0These dae=
mons
> would advertise themselves with Avahi,

 NO.

 ok.  more to the point: you want to waste time forcing people to
install a pile of shite called d-bus, just so that people can use git,
go ahead.

can we gloss quickly over the mention of avahi as that *sweet-voice*
most delightful be-all and solve-all solution *normal-voice* and move
on?

> or alternatively in an
> enterprise environment they would be managed by your sysadmins and be
> automatically discovered using DNS-SD.

 and what about on the public hostile internet?  no - i feel that the
basis should be something that's proven already, that's had at least
ten years to show for itself.  deviating from that basis: fine - at
least there's not a massive amount of change required for
re-implementors to rewrite a compatible version (in c, or *shudder*
java)

> The second daemon would be a modified git-daemon that connects to the
> advertised "index" daemons and advertises its own refs and commit
> lists, as well as its IP address and port.

 yes, there are definitely two distinct purposes.  i'm not sure it's
necessary - or a good idea - to split the two out into separate
daemons, for the reason that you may, just like bittorrent can use a
single port to share multiple torrents comprising multiple files, wish
to use a single daemon to serve multiple git repositories.

 if you start from the basis of splitting things out then you have a
bit of a headache on your hands wrt publishing multiple git repos.

l.
