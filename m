From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Fri, 2 Feb 2007 16:39:22 +0100
Message-ID: <8c5c35580702020739v383c1efeu7851f5eb2a2ea5f@mail.gmail.com>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
	 <20070201191323.GA18608@spearce.org>
	 <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net> <epv3r9$4f7$2@sea.gmane.org>
	 <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
	 <Pine.LNX.4.64.0702020945090.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 16:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD0Vb-0007Qb-Ny
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 16:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945915AbXBBPjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 10:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbXBBPjY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 10:39:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:25351 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945915AbXBBPjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 10:39:24 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1280353nfa
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 07:39:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fGaF8TjBKrR2uSXSeUZ1hyrxNG85POtODKA7lj+tHYVWHgmrd6dibw7HvT3V7/ZpqH/EBhSePuHW1IHWhUMf7qE6q7+QRL7WhxgFe0x7zij/+O+SD8G0uBZTZAfMQ+pg0O/b23/IH0VGNZLfqAi0hdtEmFpUmD07nXM9MVqpLQY=
Received: by 10.82.182.8 with SMTP id e8mr1219946buf.1170430762376;
        Fri, 02 Feb 2007 07:39:22 -0800 (PST)
Received: by 10.82.158.7 with HTTP; Fri, 2 Feb 2007 07:39:22 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702020945090.3021@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38507>

On 2/2/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 2 Feb 2007, Lars Hjemli wrote:
>
> > On 2/2/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Hi,
> > >
> > > On Fri, 2 Feb 2007, Jakub Narebski wrote:
> > >
> > > > Perhaps we should use @{...} to refer to reflog for HEAD, or use yet
> > > > another special notation?
> > >
> > > No.
> > >
> > > IMHO "bla@{yesterday}" should give you what "bla" pointed to, yesterday.
> > > In that sense, the proposed reflog on "HEAD" makes perfect sense.
> >
> > Since HEAD is a synonym for "current branch" everywhere else in git,
> > while .git/logs/HEAD will be a log of detached HEAD (plus branch
> > switches, I guess), I think the following makes perfect sense:
> >
> >  "HEAD@{yesterday}" = current branch, yesterday
> >  "@{yesterday}"     = detached head (no branch), yesterday
>
> No it doesn't.
>
> HEAD is a moving pointer.  Sometimes it means the current branch,
> sometimes it doesn't.
>
> So HEAD is _NOT_ a synonym for "current branch" everywhere already.

All true. I guess I'm just used to thinking about HEAD as a pointer to
the current branch, and that was the reasoning behind my proposal.

But with a detached HEAD this is no longer true, and you end up being right :)

Sorry for the noise

--
larsh
