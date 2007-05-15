From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Suggestions for cgit (was: Re: suggestions for gitweb)
Date: Tue, 15 May 2007 14:57:16 +0200
Message-ID: <8c5c35580705150557k694abfb6rb8f87763dfd26c81@mail.gmail.com>
References: <20070512205529.GS14859@MichaelsNB> <f25mic$1b1$2@sea.gmane.org>
	 <8c5c35580705130952r7c0e353dr9cf20aed61bdd463@mail.gmail.com>
	 <200705140931.32513.jnareb@gmail.com>
	 <8c5c35580705140150i85ef898h6ac0475ab12f8a03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 14:57:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnwai-0002xr-1e
	for gcvg-git@gmane.org; Tue, 15 May 2007 14:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbXEOM5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 08:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753984AbXEOM5S
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 08:57:18 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:3005 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbXEOM5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 08:57:17 -0400
Received: by nz-out-0506.google.com with SMTP id r28so127146nza
        for <git@vger.kernel.org>; Tue, 15 May 2007 05:57:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cyrMR9g6d9rHeJ26BReks64afqG65X1Ul6zI7AubqM7ksR0/WY4JNhgtSmq+WyMUKQFHCw1WQI0DovOYj73VNvPycbE62IbCga6a+qdovyiqJ8b/xWpQV79UCM4YXh0oYx33wIC42fm9M1HGW50i1D4q4qgfdY6Q6lV6LZvRBO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Te9OHK/Izujo3GQqvVae2i4aa1muNEM8Ia/MamUGKpnpumcj0Xk0R19bTjTd5mTpbOchGdTCCVnyfJ24fxY+Y0wpTaJdx7v9aw/JwxHGjf2HpOcA6jiR9yjfYkpnm3ChvHvbIiqlPe9exs04ie4PXJx3RVUFYiHK9JZZMnfsiK4=
Received: by 10.114.193.1 with SMTP id q1mr1545549waf.1179233836699;
        Tue, 15 May 2007 05:57:16 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 15 May 2007 05:57:16 -0700 (PDT)
In-Reply-To: <8c5c35580705140150i85ef898h6ac0475ab12f8a03@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47344>

On 5/14/07, Lars Hjemli <hjemli@gmail.com> wrote:
> On 5/14/07, Jakub Narebski <jnareb@gmail.com> wrote:
> > On Sun, 13 May 2007, Lars Hjemli <hjemli@gmail.com> wrote:
> >
> > > I've implemented number of files/lines changed in cgit's log view and
> > > pushed it to http://hjemli.net/git/
> > >
> > > It does consume some cpu (especially on the linux-2.6 repo), but it's
> > > not terribly bad (and the caching helps out). But I felt like changing
> > > the number of commits per page to 50, so I added a knob for this in
> > > the config file while at it.
> > >
> > > I'll try to get a proper diffstat on the commit page + file history
> > > via tree view next (filesize has always been part of cgits tree view
> > > btw).
> >
> > What I lack in cgit is using git diff and showing extended diff headers
> > (and the ugly tight box around diff doesn't help either), and gitweb's
> > 'commitdiff' view / git's git-show / git's git-format-patch.
>
> Yes, this has been lacking. Last night I pushed initial support for
> 'commitdiff', but it doesn't show git's extended diff headers, nor is
> there any plain/patch view (but the ugly tiny box is still there, I'm
> lousy at web design :)
>
> That said, extended headers/patch view should be trivial to support so
> I'll look into it.

Ok, the ugly box is gone and 'commit-diff' now looks more like 'git
show'. Thanks for the suggestion.

--
larsh
