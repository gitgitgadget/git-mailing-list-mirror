From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 13:57:00 +0200
Message-ID: <81b0412b0706190457l730d9b6ehc87471808e553c37@mail.gmail.com>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org>
	 <Pine.LNX.4.64.0706191037590.4059@racer.site>
	 <81b0412b0706190313g74765babk38309dd838f3f585@mail.gmail.com>
	 <Pine.LNX.4.64.0706191210020.4059@racer.site>
	 <81b0412b0706190447y37c3aedbya42b7a3d5703322c@mail.gmail.com>
	 <Pine.LNX.4.64.0706191249480.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 13:57:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0cKi-0004dg-IR
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 13:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbXFSL5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 07:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755411AbXFSL5E
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 07:57:04 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:21442 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbXFSL5C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 07:57:02 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1551471ika
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 04:57:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r4ZtUvpIboR84isqf77DS1zM1b47LFO/k+a07o/X6Uu58/U0D0FEtDCZL7HlXyxXn7jW6ZS9xojcJ6F0UVNDn3SpsQfG2E4hIJXwcbWwgC38HuEPNNnCDgweLa9hlWd3GA24aSzLzGCGYMnPcx/LvmfNVNIUQF1X3GkhQlpYqdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KP1npHo0L6/23BeSVyvyjAo8i9SjCWmvo1yRZJaR7urNWqE1ZNxR9rTIfXGnEyt/iYDLFMfmpTpiSHvhz7zMTV0HeCZ+gVayAZchlYNVwoPtovFqyt28ku5v/2Q/z7sKsQ5+7OIEaG2c6o2/et0ojDChLnpMwG6vl5sDEWm33CA=
Received: by 10.78.180.16 with SMTP id c16mr2814591huf.1182254220259;
        Tue, 19 Jun 2007 04:57:00 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Tue, 19 Jun 2007 04:57:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706191249480.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50474>

On 6/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On 6/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > >
> > > > > Maybe this is the right time to cut off branches/* and remotes/*?
> > > >
> > > > Seconded. Don't use the remotes/ since some months now.
> > > > But... isn't a git package with code of something like 1.4.4 is still
> > > > in some major distributions?
> > >
> > > Yes, AFAICT it is Ubuntu "the most up-to-date distro there is". At least
> > > many questions on the list and in IRC suggest that.
> > >
> > > So, how about checking (at least for a year) in builtin-fetch, if
> > > "branches/" or "remotes/" exist, and fail, with a nice message how to move
> > > to config-based remotes?
> >
> > ...by suggesting to use a nice conversion script which we don't
> > have.
>
> git.git/contrib/remotes2config.sh
>
> IIRC it was explicitely asked to leave branches/* out of that script, but
> the original version had it, and it should be easy to include it again.

Right, missed it. Sounds like we have a plan
