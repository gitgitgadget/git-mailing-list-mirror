From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 16:31:08 +0200
Message-ID: <8aa486160710190731v67626fd8wa94ba069a17f73ce@mail.gmail.com>
References: <20071019062219.GA28499@coredump.intra.peff.net>
	 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
	 <20071019073938.GN14735@spearce.org>
	 <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
	 <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net>
	 <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Theodore Tso" <tytso@thunk.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"David Symonds" <dsymonds@gmail.com>, "Jeff King" <peff@peff.net>,
	git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iissw-0007Iu-Ts
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182AbXJSObN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932994AbXJSObN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:31:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:47516 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbXJSObL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:31:11 -0400
Received: by nf-out-0910.google.com with SMTP id g13so454181nfb
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GxqmrbYaWK3KgmwCwrms5R8d4ilfF6Bj9pnUlPj3xW0=;
        b=dUu77IXM7I0arx0hE6XpQyEqTl1B3r7/Nrz730mVGq4p+hOW/F9QvMHdjZhDemXI3wxaQCZBLoVkcqDDfqr+H8lKebq3VzJB7ryJH5dxNZrTOSTlQXngslVybR2dZlc4U/m3iAexHOorjE0EL+EqlNH+SgoU+Wp+OoAhpFMskrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aIvGQr1hdLuwKoR3DznFuxzJzHauRNssV46qxmfk5ZEQUK9dELU3Qlzbgw3Dc6j2zFd+k/UTvNGm1wD6B/XwyOxG9zQ7x/PX2wTzMFgoUY0wKbo7Hm8+IIQuvHQ7qt3Evg0iaOkTnn7UMSFqMx0PSuH7EENyxoKakA+VeNjBrwo=
Received: by 10.78.160.4 with SMTP id i4mr1305731hue.1192804268907;
        Fri, 19 Oct 2007 07:31:08 -0700 (PDT)
Received: by 10.78.137.1 with HTTP; Fri, 19 Oct 2007 07:31:08 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61717>

On 10/19/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 19 Oct 2007, Johannes Sixt wrote:
>
> > Theodore Tso schrieb:
> > > ==> git://repo.or.cz/git/spearce.git
> > >  * branch gitk -> spearce/gitk              (new)
> > >  * branch maint -> spearce/maint    1aa3d01..e7187e4
> > >  * branch master -> spearce/master  de61e42..7840ce6
> > >  * branch next -> spearce/next              895be02..2fe5433
> > >  + branch pu -> spearce/pu          89fa332...1e4c517
> > >  * branch todo -> spearce/todo              (new)
> >
> > > As far as the padding, it would be a pain to figure out how to make
> > > the right hand column be padded so that it starts 3 spaces after the
> > > longest "  * branch foo -> bar" line, but that would look the best.
> >
> > But this way it wouldn't be difficult at all:
> >
> > ==> git://repo.or.cz/git/spearce.git
> >  * (new)              gitk -> spearce/gitk
> >  * 1aa3d01..e7187e4   maint -> spearce/maint
> >  * de61e42..7840ce6   master -> spearce/master
> >  * 895be02..2fe5433   next -> spearce/next
> >  + 89fa332...1e4c517  pu -> spearce/pu
> >  * (new)              todo -> spearce/todo
>
> Actually I think this is the best format so far: one line per branch, no
> terminal width issue (long branch names are simply wrapped), the
> old..new info is there also with the single character marker to quickly
> notice the type of update.

I like it too. I would like to add some more descripton, because I
think for newbies the .. and ... can be overlooked. Something like:

$ git fetch spearce
...
URL: git://repo.or.cz/git/spearce.git
 * (new)              spearce/gitk: new branch 'gitk'
 * 1aa3d01..e7187e4   spearce/maint: fast forward to branch 'maint'
 * de61e42..7840ce6   spearce/master: fast forward to branch 'master'
 * 895be02..2fe5433   spearce/next: fast forward to branch 'next'
 + 89fa332...1e4c517  spearce/pu: forcing update to non-fast forward branch 'pu'
 * (new)              spearce/todo: new branch spearce/todo

I would also put 'URL:' instead '==>'.

Santi
