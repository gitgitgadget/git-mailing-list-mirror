From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 09:05:55 +1000
Message-ID: <2cfc4032050510160578b81fa7@mail.gmail.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <Pine.LNX.4.21.0505101743520.30848-100000@iabervon.org>
	 <2cfc40320505101605721420@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 11 00:59:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVdgc-0001mW-HB
	for gcvg-git@gmane.org; Wed, 11 May 2005 00:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVEJXGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 19:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVEJXGE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 19:06:04 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:21719 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261847AbVEJXFz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 19:05:55 -0400
Received: by rproxy.gmail.com with SMTP id j1so14339rnf
        for <git@vger.kernel.org>; Tue, 10 May 2005 16:05:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NGdBdB2Ceec8gMuOO+Ty7OU2gZ+jSkOrR5hyQlEsjGnNwj0igQb6lNAUGjaqyrV4jm32AaLeUwIdBe9eGDWsPSF5ll5RP5VxkCMWnUAymg4DJHsCSomf1el1sTCvoldP8jfCnwIiyvWbu3ImSIYTgR2WwKbHnSzQtOSatTXwcHM=
Received: by 10.38.97.47 with SMTP id u47mr52475rnb;
        Tue, 10 May 2005 16:05:55 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Tue, 10 May 2005 16:05:55 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc40320505101605721420@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>
> > I think it would be worthwhile if care was taken to draw a distinction
> > between the repository and the cache aspects of the git core, perhaps
> > even going to the extreme of moving all knowledge of the  cache into
> > cogito itself. By clearly drawing this distinction, we will more
> > easily enable the creation of different kind of tools sets atop the
> > foundation of the GIT repository format.
>
> I think this is nonsensical. The cache format is tied to the way in which
> the repository accessing code is written, so a git-core separate from the
> cache wouldn't have a useful set of code.
>

I guess I agree it is somewhat nonsensical if one considers the
current git toolset as a collection of programs - the exercise now
might simply reduce to classifying git tools as
index-using/non-index-using and nothing more. However, it might be
worth keeping in mind when/if the "libification" of git happens so
that there is a clean separation of layers in the API between the
repository API and index/cache/workspace API.

> It might be worthwhile to produce a separate document describing the
> repository format, such that it could be accessed by different code,
> however. Of course, the index file wouldn't be part of this documentation,
> for the same reason that the public git repositories don't include index
> files.
>

And thanks for your constructive criticism.

jon.
--
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
