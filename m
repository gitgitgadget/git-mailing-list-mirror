From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: Problem upgrading to 1.4.0
Date: Tue, 13 Jun 2006 16:40:31 +0930
Message-ID: <93c3eada0606130010q350f2412w714134ca621608b2@mail.gmail.com>
References: <93c3eada0606101707t5eb35a4du3ebd0fd17737943f@mail.gmail.com>
	 <7v1wtwh246.fsf@assigned-by-dhcp.cox.net>
	 <1150165982.4297.88.camel@dv>
	 <20060612224818.383b13ee.seanlkml@sympatico.ca>
	 <1150167759.4297.95.camel@dv>
	 <Pine.LNX.4.64.0606122024400.5498@g5.osdl.org>
	 <1150170985.4297.104.camel@dv>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 13 09:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq32p-0000WW-3d
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 09:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbWFMHKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 03:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932942AbWFMHKc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 03:10:32 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:55154 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932938AbWFMHKc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 03:10:32 -0400
Received: by wx-out-0102.google.com with SMTP id h28so952181wxd
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 00:10:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TbpqQiGCEwHzimXSzAVIckZLTtId7cS9ONSjF6cov7RIjEy3nAi4LPAH1HRyfCuodUQs1alJJTYG4wKh5p9B6o6Ej9orx0BdoEHNeT0b+CToxj5RFTQPm2ATs1Mr1CsOXZqTu8tuqGmYnGlfDyP/mmJeGN0idt5bVeDJz8Vt1iU=
Received: by 10.70.109.5 with SMTP id h5mr7291518wxc;
        Tue, 13 Jun 2006 00:10:31 -0700 (PDT)
Received: by 10.70.133.1 with HTTP; Tue, 13 Jun 2006 00:10:31 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <1150170985.4297.104.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21773>

On 6/13/06, Pavel Roskin <proski@gnu.org> wrote:
> On Mon, 2006-06-12 at 20:28 -0700, Linus Torvalds wrote:
> >
> > On Mon, 12 Jun 2006, Pavel Roskin wrote:
> > >
> > > > You can get a list of the remote branches whenever you want:
> > > >
> > > > $ git ls-remote -h <remote>
> > >
> > > I heard of that command.  But git-clone only uses it for local and rsync
> > > protocols.
> >
> > The native format doesn't _need_ to use "git ls-remote", because the
> > native format does it on its own.
>
> OK.  I actually suspected that git-ls-remote was limited to some
> protocols.  I'm glad to be wrong about it.

Just so we don't lose sight of the forest for the trees, the most
common thing I want to do is:  "get me up-to-date-with-origin,
don't overwrite any branches of mine, but get me anything on the
origin which I don't have".  Hence I think this should be one fairly
simple command -- git pull origin.

The first time I had this problem, I gave up trying to fix it and just
rm'd my git
repository and re'cloned it. The second time it happened, I knew a
little bit more and worked out how to fix it.

Cheers,
Geoff Russell



>
> --
> Regards,
> Pavel Roskin
>
>
