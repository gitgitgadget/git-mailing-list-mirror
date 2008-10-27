From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 11:57:18 +0100
Message-ID: <200810271157.20313.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <200810270252.23392.jnareb@gmail.com> <40f323d00810270229w7dfecabcm86e5e611fb4250ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Arne Babenhauserheide" <arne_bab@web.de>, SLONIK.AZ@gmail.com,
	mercurial@selenic.com, git@vger.kernel.org
To: "Benoit Boissinot" <bboissin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 11:58:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuPo0-00082D-T6
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 11:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbYJ0K5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2008 06:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbYJ0K5a
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 06:57:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:61169 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbYJ0K53 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2008 06:57:29 -0400
Received: by ey-out-2122.google.com with SMTP id 6so781088eyi.37
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jBAFS762lr2K7Xx0791oWwdfe0Qe1dV1nz4ntEjsO3s=;
        b=kI8pIy50V78DxiojgSpsulyH+l4FX+6h2UvklPYvSy1/9UiZVmbE58yWVmOtVG7HD4
         WRguXTNVPlsLnybgLbGUB1CVy1U5/QAXe9vJ9cTCCDG40/HzoFT4WxKsnhnLKU0tORK1
         voMhqakHXOoVpA1N2xwtRT2PXtEwtw//d4Rg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YS2jfC9sxGlJz+3qKyhXHYc2j2Asko4Xp4cpCGQM5EWpHoMHJ12JaBT0y9MxJY/Nv5
         BbsMxyzYII4Fr06qqAtaYO/RTddCPA+pzO1PNXP44cV2U+q/xSKne7Kpu1NbkskZDrTK
         MgCVQ0dEBIU7mWqHEcYzVxTfOBy7R8Jg0UuxU=
Received: by 10.210.61.19 with SMTP id j19mr6489992eba.56.1225105047273;
        Mon, 27 Oct 2008 03:57:27 -0700 (PDT)
Received: from ?192.168.1.11? (abvq236.neoplus.adsl.tpnet.pl [83.8.214.236])
        by mx.google.com with ESMTPS id 7sm5735431eyg.0.2008.10.27.03.57.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Oct 2008 03:57:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <40f323d00810270229w7dfecabcm86e5e611fb4250ef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99225>

Dnia poniedzia=B3ek 27. pa=BCdziernika 2008 10:29, Benoit Boissinot nap=
isa=B3:
> On Mon, Oct 27, 2008 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
>>> Am Sonntag 26 Oktober 2008 19:55:09 schrieb Jakub Narebski:
>>>>
>>>> I agree, and I think it is at least partially because of Git havin=
g
>>>> cleaner design, even if you have to understand more terms at first=
=2E
>>>
>>> What do you mean by "cleaner design"?
>>
>> Clean _underlying_ design. Git has very nice underlying model of gra=
ph
>> (DAG) of commits (revisions), and branches and tags as pointers to t=
his
>> graph.
>=20
> Git and Mercurial are very close from that point of view.
>
> Mercurial explicitely disallow octopus merges (and we don't think the=
re's
> a good reason to allow them, although I agree with Linus, they look v=
ery nice
> in gitk ;) ).

=46rom what I see Mercurial disallows octopus merges (merges with more
than two parents) because of its rigid-record database repository
design, while Git is more like object database.  Fixed width records
of VMS vs delimited records of Unix... There is simply place on
zero, one or two parents (two parent fields, which can be null) in
Mercurial changerev format.

By the way flexibility of Git design allowed to add 'encoding' header
to commit message (if commits message is encoded not in utf-8) after
the fact, without affecting older repository data, and playing well
with old git installations which do not understand this header.

> And we don't have "branches as pointer" in core, but the bookmark
> extension does that.

I disagree. Mercurial implementation of tags is strange, and from
what I remember and from discussion on #revctrl implementation
of local named branches is also strange (CVS-like). They are IMHO
not well designed.

Also the 'hidden' branches after fetching from remote repository
(hg pull) but before merging (hg update) are IMHO worse design
than explicit remote-tracking branches in Git, especially in presence
of multiple [named] branches in repositories.

> Apart from that I think the underlying format are interchangeable,
> someone could use the git format with the hg ui, or use revlogs
> (the basic format of mercurial) like packs.

I don't think so. The 'content addressed filesystem' idea of Git
is quite pervasive along Git implementation and Git thoughtflows.

>=20
> The only special thing about revlogs is the linkrev stuff, it's a
> pointer to the first revision that introduced an object, so we can
> easily find what to send in our network protocol (we don't have to
> read the manifest, ie the "tree" of objects"). linkrev can be useful
> to speedup "hg log" too.

At first I thought: what a nice idea... but then I realized that in
distributed environment there is no way to define "first revision that
introduced an object". Take for example the following history=20
(independent introduction):

  .---.---.---.---x---.---.---.
           \
            --x---.---.

where both 'x' have the same version of an object. The top branch
appeared first in current repository, but the bottom branch had 'x'
with earlier timestamp (earlier authordate).


Git just relies on the fact that traversing revision is a part of it
that is heavily optimized and really fast. Git very much by design
doesn't store any backlinks in repository object database.

>> I have read description of Mercurial's repository format, and it is =
not
>> very clear in my opinion. File changesets, bound using manifest, bou=
nd
>> using changerev / changelog.
>>
>=20
> just do a s/// with the git terminology:
> filelog -> blob
> manifest -> tree
> changelog -> commit object

True. But as I see it they are bound in reverse order in Mercurial:
deltas are stored in filelog, filelogs are bound together in manifest,
manifest are bound using changelog, while in Git commit object
references tree (and parents), trees references blobs, and blob store
content of a file. But that might be just my impression.


=2E....................................................................=
=2E.

By the way, going back to the matter of choosing version control system
for DragonflyBSD; some time ago I have written post
 * "Mercurial's only true "plugin" extension: inotify...=20
    and can it be done in Git?"
   http://thread.gmane.org/gmane.comp.version-control.git/76661
   (current answer: it is possible using 'assume unchanged' bit)
about how nearly every Mercurial extension has equivalent functionality
in Git.=20

But what about the reverse, about the following features and
issues in Mercurial:

 * Merging in presence of criss-cross merges[1], and in presence of
   file renames, i.e what merge-recursive does in Git.

 * git-rerere, reusing recorded resolution of conflicted merges.
   Resolving the same merge happens often if you use topic branches
   and trial merging.

 * git-grep that allows you to "and" the match criteria together,
   and also pick a file (not a line) that matches all the criteria;
   and of course allow searching given revision and not only working
   directory.

 * pickaxe search (git log -S) which contrary to blame/annotate
   allow to find commit which _deleted_ given fragment.

 * easy management of multiple repositories you fetch from with=20
   remote-tracking branches and git-remote command.

 * blame that follows block-of-line movement (it was invented by Linus
   as a vision long time ago, but it took very long time to materialize=
).

 * a way to review merge resolution, something that is done in git
   by using combined diff format

 * git-stash, allowing to stash away changes to go back to them later;
   it allows to stash away even partially resolved merge conflict
   (merge resolution in progress).

 * git-filter-branch (based on cg-admin-rewrite-hist), which allow
   to rewrite history for example to remove file which should never
   be added to version control (for example because of copyright
   or license).

References:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[1] http://revctrl.org/CrissCrossMerge
    BTW I wonder why reverting spam is made so hard on revctrl.org wiki
 =20
--=20
Jakub Narebski
Poland
