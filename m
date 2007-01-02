From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 17:28:15 -0800 (PST)
Message-ID: <65526.67561.qm@web31806.mail.mud.yahoo.com>
References: <20070102001044.GB32148@fieldses.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 02:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1YRw-00025X-3q
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 02:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbXABB2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 20:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbXABB2R
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 20:28:17 -0500
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:22160 "HELO
	web31806.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932663AbXABB2Q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 20:28:16 -0500
Received: (qmail 67929 invoked by uid 60001); 2 Jan 2007 01:28:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=hriruPEW2r2uQ94KLvUIIoMh+BO0pVB43lNNw8y0lwGYmeLHLlOqJ2KOB82wKxZjYHu4zoXaaIOt/JU6J/8yBbwH2d9I6UaiTrnhq7nU3/D/230SdNFewP/V17mtaMnhSDKiFG997yvyjGw3kdk5vh+JiVkB6jY4RJwcZgU9F94=;
X-YMail-OSG: dbki0W4VM1nv.JY_GjwAx.cre9gimwavzYfcdg9dnakXkOBYwFaUD0ZUUr2zV6d2dAfj1vFG8GMacAYdEf9zxEW80eSNU18898hPFaPtG7DqXe3tP5e4VRjsNVsmV2jDk2xj0bQqNKcoF2UhjTxnOJ1Zfbti0A--
Received: from [71.84.31.238] by web31806.mail.mud.yahoo.com via HTTP; Mon, 01 Jan 2007 17:28:15 PST
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070102001044.GB32148@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35760>

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
> 
> Remote branches are stored in separate namespaces under
> .git/refs/remotes/, so that they don't muck up your view of your local
> branches, and so git can enforce different policies for them (such as
> forbidding committing to them).

Smells like another "newbie" protection.

Let me understand, someone here installed git, didn't read the then
man page of git-clone/pull/fetch, screwed up their repo, and decided
to change established behavior.

Regardless, I think addressable (named) branch specs are the way to go.
This will as well, unify/reconcile remotes/ and local stuff, since
it is already implemented for remotes/ .

     Luben
