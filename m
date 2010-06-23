From: Martin Geisler <mg@lazybytes.net>
Subject: Re: potential improvement to 'git log' with a range
Date: Wed, 23 Jun 2010 19:05:09 +0200
Message-ID: <87bpb1issa.fsf@hbox.dyndns.org>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
	<i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
	<n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
	<alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
	<m3tyrhfzg8.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0433279359=="
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git list <git@vger.kernel.org>,
	mercurial list <mercurial-devel@selenic.com>, Aghiles <aghilesk@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: mercurial-devel-bounces@selenic.com Wed Jun 23 19:05:28 2010
Return-path: <mercurial-devel-bounces@selenic.com>
Envelope-to: gcvmd-mercurial-devel@gmane.org
Received: from waste.org ([173.11.57.241])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <mercurial-devel-bounces@selenic.com>)
	id 1ORTOA-0008U1-2M
	for gcvmd-mercurial-devel@gmane.org; Wed, 23 Jun 2010 19:05:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by waste.org (Postfix) with ESMTP id C4770743A5;
	Wed, 23 Jun 2010 12:05:24 -0500 (CDT)
X-Virus-Scanned: Debian amavisd-new at waste.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "MIME-Version"
Received: from waste.org ([127.0.0.1])
	by localhost (waste.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id F+hLZRktM1cK; Wed, 23 Jun 2010 12:05:21 -0500 (CDT)
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (Postfix) with ESMTP id B0EE3743BA;
	Wed, 23 Jun 2010 12:05:21 -0500 (CDT)
X-Original-To: mercurial-devel@waste.org
Delivered-To: mercurial-devel@waste.org
Received: from localhost (localhost [127.0.0.1])
	by waste.org (Postfix) with ESMTP id 5233E743BA
	for <mercurial-devel@waste.org>; Wed, 23 Jun 2010 12:05:20 -0500 (CDT)
X-Virus-Scanned: Debian amavisd-new at waste.org
Received: from waste.org ([127.0.0.1])
	by localhost (waste.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ugfEOKjZ60+h for <mercurial-devel@waste.org>;
	Wed, 23 Jun 2010 12:05:17 -0500 (CDT)
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by waste.org (Postfix) with ESMTP id 9F593743A5
	for <mercurial-devel@selenic.com>; Wed, 23 Jun 2010 12:05:17 -0500 (CDT)
Received: by fxm4 with SMTP id 4so1254881fxm.29
	for <mercurial-devel@selenic.com>; Wed, 23 Jun 2010 10:05:16 -0700 (PDT)
Received: by 10.87.63.1 with SMTP id q1mr13539952fgk.38.1277312713032;
	Wed, 23 Jun 2010 10:05:13 -0700 (PDT)
Received: from hbox.dyndns.org (77-58-145-114.dclient.hispeed.ch
	[77.58.145.114])
	by mx.google.com with ESMTPS id l12sm11888231fgb.12.2010.06.23.10.05.10
	(version=TLSv1/SSLv3 cipher=RC4-MD5);
	Wed, 23 Jun 2010 10:05:10 -0700 (PDT)
In-Reply-To: <m3tyrhfzg8.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sun, 11 Apr 2010 14:32:49 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-BeenThere: mercurial-devel@selenic.com
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <mercurial-devel.selenic.com>
List-Unsubscribe: <http://selenic.com/mailman/options/mercurial-devel>,
	<mailto:mercurial-devel-request@selenic.com?subject=unsubscribe>
List-Archive: <http://selenic.com/pipermail/mercurial-devel>
List-Post: <mailto:mercurial-devel@selenic.com>
List-Help: <mailto:mercurial-devel-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial-devel>,
	<mailto:mercurial-devel-request@selenic.com?subject=subscribe>
Mime-version: 1.0
Sender: mercurial-devel-bounces@selenic.com
Errors-To: mercurial-devel-bounces@selenic.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149518>

--===============0433279359==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable

Jakub Narebski <jnareb@gmail.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Fri, 9 Apr 2010, Aghiles wrote:
>> >
>> > Oh, I should have read the documentation. I was certain that ".."
>> > stands for a range but it is a ... complement.
>>
>> Well, technically ".." means two different things
>>
>>  - for "set operations" (ie "git log" and friends) it's the "relative
>>    complement" of two sets (or "'reachable from A' \ 'reachable from B'"=
).
>>
>>  - for "edge operations" (ie "git diff" and friends) it's just two
>>    end-points (aka "range"). A diff doesn't work on sets, it only
>>    works on the two endpoints.
>
> [...]
>> Most SCM's really talk about "ranges". Once you think in those terms,
>> complex history doesn't work. Git very fundamentally is much about
>> set theory, and "ranges" is a bad word to use.
>
> For example from I have got from asking on #mercurial IRC channel on
> FreeNode (a bit of self promotion: I have done this research to write
> an answer to "Git and Mercurial - Compare and Contrast" question on
> StackOverflow[1]), Mercurial implements its ".." equivalent in the
> term of _numeric range_, even for "hg log" (sic!).

This is fixed with Mercurial 1.6: we now have a query language where
'X..Y' (or 'X::Y') is understood as the set of changesets that are both
descendents of X and ancestors of Y.

> [1]
> http://stackoverflow.com/questions/1598759/git-and-mercurial-compare-and-=
contrast/1599930#1599930


=2D-=20
Martin Geisler

Mercurial links: http://mercurial.ch/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwiPsUACgkQ/GWFsD4LxSMTmgCdH+w7DYECUErp3yCt0z+ZSExn
tucAn1SMUI2cqmgX+Zels36LtCZrNJEP
=M1YM
-----END PGP SIGNATURE-----
--=-=-=--

--===============0433279359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
