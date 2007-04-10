From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 18:43:59 +0200
Message-ID: <81b0412b0704100943k44a0e0b3vf39000bf1eb20e8f@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
	 <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
	 <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
	 <81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com>
	 <Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 02:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbJRv-0000lO-Rn
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 18:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031105AbXDJQoD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 12:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031106AbXDJQoD
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 12:44:03 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:6631 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031105AbXDJQoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 12:44:01 -0400
Received: by an-out-0708.google.com with SMTP id b33so2015578ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 09:44:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MEVwNVWmpAkcAH27rWfIV4ex0zWXrXQX9Y+/8zNkPPWHH0IxUpzzhBf9NkNmHAU6jGlJcGL15ZevUq+y7isfCb0EFso8qjO0sNVPxMD2Yg3wByW5ogGaJVwr3PHpxmfnceKu5WJZHoxOIZRf/ywruvRb2++Ivl/MX8XDH9dXrNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=de+1PrC6hG8Ht1mWbnBRcbNhiTiKKyvTFUGZaKNMNdNetfA8Xodsm3hSok2DSYFP6XgbDv5/CluvJV09YplJ33wQmeFuGaTOg2iCniQpcUCJ1lB3dUy0XQTHV+x4/63pdgPESEhnamPMlGc6tPnyWecG2iG+sHZuUsVXmg8ZiiE=
Received: by 10.100.178.7 with SMTP id a7mr5048091anf.1176223439929;
        Tue, 10 Apr 2007 09:43:59 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 09:43:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44154>

On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > It is already "merged somewhere": as soon as the patches left landed
> > on vger, it is not possible to loose (and even destroy) them.
> > The feature is just too much sought after.
>
> Well, unless it hits something like Junios 'pu' (or 'next') branch, or
> somebody (like you?) ends up maintaining a repo with this, it's just
> unnecessarily hard to have lots of people working together on it..
>
> I'm obviously interested in working on it, but at the same time, I don't
> expect to be a primary *user* of it, so I'm hoping others will come in and
> start looking at it.
>
> It looks promising that you're getting involved, but I suspect you may be
> a bit too optimistic when you say "just too much sought after". We've been
> *talking* about subprojects for a long long time, and we've had other
> patches fail. So...

The people who need the feature are still using other VCS.
Some do not even know about git, the others are more interested
in their own projects than in hacking on git (like KDE or Ubuntu
people). And then there are commercial projects with thirdparty
libraries, components or data. The other VCS' provide the feature,
even if they do it wrong and badly (I never could go back in time in my
day-work project, always asked myself what was the point of using
Perforce at all).
So, I suspect it is the people who are unable or unwilling
to contribute to git (to anything, really) who need the feature most.
