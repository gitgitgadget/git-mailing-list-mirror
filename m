From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 12:09:49 +1000
Message-ID: <2cfc4032050510190950bba995@mail.gmail.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <1115739511.16187.432.camel@hades.cambridge.redhat.com>
	 <2cfc4032050510092238259b63@mail.gmail.com>
	 <1115744609.16187.455.camel@hades.cambridge.redhat.com>
	 <2cfc403205051010151304d88a@mail.gmail.com>
	 <2cfc4032050510101553d391b2@mail.gmail.com>
	 <Pine.LNX.4.61.0505102158140.17216@chimarrao.boston.redhat.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 04:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVgYK-000146-7t
	for gcvg-git@gmane.org; Wed, 11 May 2005 04:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVEKCJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 22:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEKCJw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 22:09:52 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:15726 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261874AbVEKCJt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 22:09:49 -0400
Received: by rproxy.gmail.com with SMTP id j1so27698rnf
        for <git@vger.kernel.org>; Tue, 10 May 2005 19:09:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ka7lAFEmO4l2HRdh7IeZvDnM1J0ZhPmyYfmp5v1AUT8iMcHyc0MrkGOduDn3j4YGjsK1FwMxQyzRuo/0U2/+6DnkBFapZV+dDoJIF3ZqqJdoyQm+6JFAN7qs6UzXtvfJu+uWjteE2RVUC4eGs8ECAWX+CJwMGdy64XGfY1DF+RA=
Received: by 10.38.97.47 with SMTP id u47mr146970rnb;
        Tue, 10 May 2005 19:09:49 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Tue, 10 May 2005 19:09:49 -0700 (PDT)
To: Rik van Riel <riel@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0505102158140.17216@chimarrao.boston.redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/11/05, Rik van Riel <riel@redhat.com> wrote:
> On Wed, 11 May 2005, Jon Seymour wrote:
> 
> > I did consider wrapping it - I really did. But after thinking about it
> > for a couple of weeks I eventually came to the conclusion it would be a
> > sub-optimal solution.
> 
> > So, if I want a stable foundation to build my stuff on, basing it on
> > the output of the C tools would be a huge mistake.
> 
> Can Java use a library that's implemented in C, like Python
> and Perl can?  If that is the case, the C implementation of
> git simply needs the ability to be called as a library and
> you can implement Java bindings for it.
> 

It can in principle, yes. This is the so-called Java-Native-Interface (JNI).

I think in the longer term it would make sense to write a JNI layer
but the GIT source code is probably a little too unstable for that
now. What needs to happen first, I think, is that a solid and stable C
API (e.g. a libgit) be proposed and developed.

One outcome of the work I am doing (a long time away, probably will
never happen) might eventually be to propose an C API for GIT based,
in part, on the prototyping work I do in Java. However, I suspect its
Java-tainted heritage would mean instant death to it for purely
dogmatic reasons so I think it I'll leave it to others to propose a
C-API and then write a JNI wrapper for that when/if it ever happens.

> That should also make it easier to create front-ends in
> other languages...
> 

Agreed.

jon.
