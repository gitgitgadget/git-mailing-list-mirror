From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 18:09:48 -0800 (PST)
Message-ID: <401286.86996.qm@web31803.mail.mud.yahoo.com>
References: <20070102001044.GB32148@fieldses.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 03:09:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Z69-0004bD-1i
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 03:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbXABCJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 21:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbXABCJt
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 21:09:49 -0500
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:48179 "HELO
	web31803.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754767AbXABCJt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 21:09:49 -0500
Received: (qmail 87310 invoked by uid 60001); 2 Jan 2007 02:09:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=mcuxLo/GmSaRhAPGnHqZYvPO9eRQoY2F1/r2Ilox7QiXY/y5k/FKvFOwafq9VWfw8pzSl6PIN2PN+cqe97uR5DBndCHzdfkwjpX5LoVZyuby9yQkkw7W06WmOTTOpQodL0AKD/facejWc3AIPJ2MQXN0lhz+BYPSAfvMDMgOPok=;
X-YMail-OSG: AufnBGUVM1loScHkBS7HMDQUBluOmFTvYJTwwC1P2xDmZj1qHaDtrC6ZzBfTPTzmvUmg8jJvlzDkRV4LR1TGwA9645rdHHeznHRf8Gok5G.uHN_oEH9C350.ToDha2Z.syHwofSV..IvA1Olj6O7kb6ykgsAmeClwYkbb_ugSnaI0uloqfsVRXNFZKYh
Received: from [71.84.31.238] by web31803.mail.mud.yahoo.com via HTTP; Mon, 01 Jan 2007 18:09:48 PST
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070102001044.GB32148@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35762>

--- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Mon, Jan 01, 2007 at 04:01:15PM -0800, Luben Tuikov wrote:
> > --- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > > -The common `Pull: master:origin` mapping of a remote `master`
> > > -branch to a local `origin` branch, which is then merged to a
> > > -local development branch, again typically named `master`, is made
> > > -when you run `git clone` for you to follow this pattern.
> > 
> > So is this no longer the case?
> 
> Right; that mapping is no longer what git clone sets up for you.
> 
> > Can someone please bring me up to date?
> > 
> > What is going on?
> 
> The simplest way to understand the current behavior is probably to
> install the latest git, read the git-clone man page, clone a new
> repository, and take a look at it.

I don't like "learning by observation" when there is an
intention -- i.e. I'd rather see a well written justification
of the intentions and design, as opposed to "poke at the black
box and try to figure it out".

It's like learning math by trying to memorize the formulas
as opposed to knowing how to derive them and why they are
the way they are.

I'm expecting a well written man page on the new stuff
_compared_ to the old stuff, similarly to Junio's response
to this very same email.

    Luben


> 
> Remote branches are stored in separate namespaces under
> .git/refs/remotes/, so that they don't muck up your view of your local
> branches, and so git can enforce different policies for them (such as
> forbidding committing to them).
> 
> --b.
> 
