From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "Integrated Web Client for git" GSoC proposal
Date: Fri, 16 Apr 2010 15:03:31 +0200
Message-ID: <201004161503.34991.jnareb@gmail.com>
References: <201004130403.42179.chriscool@tuxfamily.org> <20100414110242.GZ3533@machine.or.cz> <7vvdbuqh2c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>,
	John Hawley <warthog9@eaglescrag.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 15:03:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2lD6-0002Ea-Sk
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 15:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354Ab0DPNDq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 09:03:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:47695 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758344Ab0DPNDp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 09:03:45 -0400
Received: by fg-out-1718.google.com with SMTP id d23so280946fga.1
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nU9DeRcCFEpz6F8YYZQJ9hOdbxT/zwVJhtkUJZMfs6w=;
        b=tDFDGeNNuUuU8ie8Imt/ffzLpfBrzSjeZULRFPMcavkiTBYAxSqAVyHWq0RTZuHdIb
         hXWLoN9PLNd0zH9Jv8uSqlB7NrjNc2IJNaFPjwX22LAbCceqgnWDIF+as2FE5/TgoOHX
         KGsaqhyjiIzyEVp0+5td8YGuhfQu4CRA/ttTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oV9/kdnMIKmRfqO6jJ9Ex5W7O7KlLhcmu7JBBLO5gdhQN4EX57dshu6VON0ZzsflSb
         iuIRpB6kWJv/NpGV8uc1sA67oygB/jfK9pFP/aPQSB3W+9ezJXEXBjjF+px0Ghqz1I9Z
         4gLkkzvFSrQ572CzgI2lVJwURx+vZs8gCDLDk=
Received: by 10.86.126.33 with SMTP id y33mr1348678fgc.51.1271423024217;
        Fri, 16 Apr 2010 06:03:44 -0700 (PDT)
Received: from [192.168.1.13] (abvv243.neoplus.adsl.tpnet.pl [83.8.219.243])
        by mx.google.com with ESMTPS id 12sm702488fgg.24.2010.04.16.06.03.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 06:03:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvdbuqh2c.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145062>

Dnia =B6roda 14. kwietnia 2010 15:50, Junio C Hamano napisa=B3:
> Petr Baudis <pasky@ucw.cz> writes:
>=20
> > Well, it's not that noone maintains gitweb or noone reviews patches=
;
> > smaller changes do get merged relatively fine (I'd hope), but large=
r
> > changes get sidetracked in endless discussions and perpetual polish=
ing.
> >
> > I think the problem is that we are extremely perfectionistic about
> > whatever gets into gitweb ...
>=20
> Hmph, from time to time, I found review comments that were too picky,=
 but
> I don't think gitweb reviews are particularly "perfectionistic".
>=20
> What I find is more problematic is the lack of post-review follow up,
> especially when the submitter disappears without responding to the
> reviews.  To patches that are in the core-git area, I find myself doi=
ng
> the "finishing touches" in such a case if/when the topic deserves it.
> What gitweb needs may a dedicated shepherd or two.
>=20
> > ... but other than that I think gitweb just
> > needs more of the "best is the enemy of good" mentality.
>=20
> If that means I'd see more "These are a resend of the good enough ver=
sion
> of patches with our Acks; apply them" from you and/or Jakub, or "In t=
his
> repository, we have queued the good ones---pull them", which is even
> better, I am all for it ;-).

Well, I try to either save interesting gitweb patches (which doesn't he=
lp
much), or import them to my repository at
  http://repo.or.cz/w/git/jnareb-git.git

The interesting branches would be gitwe/* branches.  Some of them are
regularly rebased against 'master' branch of main git repository.

Those branches are:

gitweb/web::

  The branch that I am doing miscelanous gitweb development on.  Manage=
d
  using StGit, not all patches applied (visible).  Regularly rebased=20
  against 'origin' branch.

  Currently contains syntax highlighting support from Johannes Schindel=
in
  (based in turn on Daniel Svensson's and Sham Chukoury's work in
  gitweb-xmms2.git), plus my refactoring of that.

  Needs decision on names of subroutines, and on semantics of 'highligh=
t'
  feature (on/off, or highlighter name).

gitweb/cache-kernel-pu::

  Simple file-based output caching for gitweb, based on work by John=20
  'Warthog9' Hawley (J.H.), split into smaller patches for easier revie=
w.
  Much more configurable than original patch(es) by J.H., with pluggabl=
e
  caching engine (it works for example with Cache::FileCache).

  J.H. ideas were: no serialization and mtime based expiration of simpl=
e
  file-based cache, using locking to avoid 'cache miss stampede' proble=
m,
  serving stale data when cache entry is being regenerated, generating
  cache in background, trick for non-AJAXy progress info, having everyt=
hing
  related to cache in 'cache.pm' file.

  My ideas were: tests, separating simple file-based cache into separat=
e
  package and making it easy to replace this cache engine by any
  Cache::Cache or CHI cache driver, select(FILEHANLE) based capturing,
  separating capturing output into package to be able to replace it by
  other captyring mechanism, daemonizing for background cache generatio=
n
  (for mod_perl), being able to 'require' the 'cache.pm' file, gatherin=
g
  options in %cache_options and adding configurability, documentation.

  This is work in progress, and a bit of mess currently.  I have posted
  information about current state of this branch to git mailing list.

  Rebased on top of 'origin'.

gitweb/cache-kernel-v3::
gitweb/cache-kernel-v2::
gitweb/cache-kernel::

  Gitweb caching series, as send to git mailing list.  Not modified, he=
re
  for historical reasons.

gitweb/category::

  The "nitpicked to death" series by Sebastien Cevey.

  I have meant to fix the way list of projects is displayed first, to
  separate filtering list of projects and printing list of projects,
  but never did managed to get to it.

  Rebased on top of 'origin'.  Series is stalled.

gitweb/committags::

  Series by Marcel M. Cary.

  I have meant to comment on this series, but forgot about it.  The maj=
or
  problem is deciding how to configure this feature... and how to name =
it.
  It is decision about API (configuration), so it is important to get i=
t
  right the first time.

  Needs review.  Series is stalled.

gitweb/cache::

  Old caching (pre-GSoC2009 gitweb caching project even) of Perl data,
  for projects_list page only, by Petr Baudis.  Some version of it migh=
t
  be used on http://repo.or.cz

  Abandoned for now.  Needs checking which method of caching is better.

--=20
Jakub Narebski
Poland
