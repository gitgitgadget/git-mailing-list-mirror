From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: gitweb feature request: tarball for each commit
Date: Fri, 9 Sep 2005 10:23:12 +1200
Message-ID: <46a038f9050908152384d0967@mail.gmail.com>
References: <46a038f905090721305dcbf61@mail.gmail.com>
	 <20050908084545.GH15165MdfPADPa@greensroom.kotnet.org>
	 <20050908113207.GA30178@vrfy.org> <4320449D.2070306@gmail.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Sep 09 00:27:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDUox-0000UZ-5Z
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 00:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVIHWXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 18:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVIHWX1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 18:23:27 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:10158 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965048AbVIHWXR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 18:23:17 -0400
Received: by rproxy.gmail.com with SMTP id i8so10093rne
        for <git@vger.kernel.org>; Thu, 08 Sep 2005 15:23:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TII4O162Hz7ZxUHWdVYrArc3JlPGJZTVF/BJ19UGgd3gd6URSXvfWxfM0LpXJZWJAC7fZSsS6mjUVQUBx5/yOgKQZVOEuNsL18TKL8pJxNF7A4lyZQusbIaIJvC1Ywluvx60awI2x6607q5QbRgb/tfGxoEuf8eiScSIxe+nybc=
Received: by 10.38.89.5 with SMTP id m5mr110920rnb;
        Thu, 08 Sep 2005 15:23:12 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Thu, 8 Sep 2005 15:23:12 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <4320449D.2070306@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8226>

> > Yes, this is nice for smaller projects. But I don't think, that we want
> > to do such a thing on the kernel.org servers. 
>
> I think this is a very useful feature for for some, but not all,
> repositories. Default it to off and have a magic file (like git-daemon),
> or a config variable turn it on.

+1! It'd be murder for large and/or popular projects, but it's a
really conventient thing to have as an optional feature. Archzoom has
it, and defaults to off ;)

I've checked out Sven's tree as well -- his implementation is pretty
cool actually, much more sophisticated that I'd planned, and using
POST to avoid stupid bots requesting the tarballs.

In this situation ("look at my repo via gitweb, it has some cool
patches over otherhacker's branch") it is hard to discriminate what
patches differentiate Sven's repo from Kay's. I'm thinking of, when
looking at a branch, having a link that shows the equivalent of 
`cg-log -r thisbranch:origin` and another one for `cg-log -r
origin:thisbranch`.

cheers,



martin
