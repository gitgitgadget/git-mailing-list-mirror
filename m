From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What are branches?
Date: Fri, 24 Apr 2009 15:08:05 +0200
Message-ID: <200904241508.08569.jnareb@gmail.com>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <m3ab6bp2we.fsf@localhost.localdomain> <20090420202329.GB17241@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 15:09:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxLAD-0004KB-6R
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 15:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbZDXNIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 09:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbZDXNIU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 09:08:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:14269 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbZDXNIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 09:08:19 -0400
Received: by wf-out-1314.google.com with SMTP id 26so987632wfd.4
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PGrpITpOABPTPkVOzDX6+xCgSi/l1M2HYbzFei/fC4k=;
        b=JB/CH7cxCElpNostkM6QyfdJgrPH2rqTn74nsbHdZnVQLI5Ow1SdsJByfLaoyTXorl
         q6AEwxuFhFOIIx3BUnI9LTZv3V5W4LS4LcE9p/dvoSMz0sSvxFmP+va/xkhhD3UOKXNR
         UZj+1xWqAsnvbFbKITN0pBiYJy5ls0k6zI630=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H8XKLIRKmyDIDnibwYL+ze1564wwkE51Vw+xo5SP+kiKJTBtuzKNny3VwtqKZIftXO
         iqVWpzaskm1nU5/GCR6FxCjuARdWwxN29mNVkldgcBWMCdXunc00fvvK8NBuOBe3wwXC
         HZ+iRqTupf/0PdCtQhRDArPUBHovZ4AxxkcTg=
Received: by 10.142.157.9 with SMTP id f9mr748680wfe.59.1240578497674;
        Fri, 24 Apr 2009 06:08:17 -0700 (PDT)
Received: from ?192.168.1.13? (abuz38.neoplus.adsl.tpnet.pl [83.8.197.38])
        by mx.google.com with ESMTPS id 22sm729285wfi.12.2009.04.24.06.08.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 06:08:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090420202329.GB17241@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117435>

On Mon, 20 April 2009, Bj=F6rn Steinbrink wrote:
> On 2009.04.20 11:59:38 -0700, Jakub Narebski wrote:
> > Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> >=20
> > > If you go out, and look at a tree lit-up by the evil daystar, bra=
nches
> > > start at the trunk and end at their tip. The trunk isn't part of =
the
> > > branch.  [...]
> >=20
> > Well, you have to remember that the 'branch' metaphor should not be
> > taken too literaly; take for example merges which do not have
> > equivalent in a tree build.
>=20
> True, but that just happened to fit the task-oriented branch view so
> well, and I wanted the reference to the evil daystar (obviously ;-)).

Also in (botanical) trees you can usually distinguish between trunk
and side branches, and I think in most cases also which branch forked
from which one.  Making one of branches (trunk) special might make
sense for centralized version control systems like CVS (1.2 vs 1.2.2.4
version numbers) or Subversion (<project>/trunk for trunk (main branch)
vs <project>/branches/<branchname>; although this is only convention
and is not enforced by the tool), but in my opinion contradicts
distributed nature of distributed SCM such like Git (and Mercurial).

> > But if we are talking about literal branches: take a closer loog at
> > the tip of tree (plant) branch.  You can find growong tip there
> > (apical meristem) where new cells grow.  In Git you have 'branches'
> > (branch heads) where you create new commits...
>=20
> Yeah, see the end of my mail, where I said that git has a mechanism t=
o
> control where branches grow. Seems to fit :-)

The difference is that you can (usually) see which branch was first.
It is not the case for Git (and it wouldn't make sense, as for DSCM
there is no sense of 'first' wrt. time).

> > But I agree that there isn't for example true notion of 'trunk' in
> > git, and this is what allows Git to be truly distributed...
>=20
> Hm, not just no trunk, but also no branches that have a starting poin=
t
> and an end point. In general, you can't say "My branch starts _here_"
> unless you use the root commit(s) as the starting point, or you apply
> "extra" knowledge (you know from which other branch this branch forke=
d).

Well, you can use reflog... if it is not expired.  Or the tracking info
in a config.

--=20
Jakub Narebski
Poland
