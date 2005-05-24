From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 08:19:42 +1200
Message-ID: <46a038f905052413192bbc10ff@mail.gmail.com>
References: <20050511012626.GL26384@pasky.ji.cz>
	 <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org>
	 <428E49DD.406@zytor.com>
	 <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>
	 <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188>
	 <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
	 <428E745C.30304@zytor.com>
	 <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
	 <4292A08A.5050108@cobite.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:20:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DafrO-0008Dr-VH
	for gcvg-git@gmane.org; Tue, 24 May 2005 22:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVEXUUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 16:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVEXUUM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 16:20:12 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:47607 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262022AbVEXUTn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 16:19:43 -0400
Received: by rproxy.gmail.com with SMTP id i8so997302rne
        for <git@vger.kernel.org>; Tue, 24 May 2005 13:19:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TPR5ffqYox2q1Yn4EqPW4puzWOzqjNGZ3dlU1tSbkBnu9A0RH1RqmdruLCABW8b3C316lOYWwGH6ZdtiFcNCTojGIn+v7IiE9+ziXzR0wD5uFLFFVoSdDKC7pgyK6SXfpJM1gcEYsmWuD3mHsfrCQkLnMW6r3TO76auTyo3zjlM=
Received: by 10.38.208.14 with SMTP id f14mr622911rng;
        Tue, 24 May 2005 13:19:42 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Tue, 24 May 2005 13:19:42 -0700 (PDT)
To: David Mansfield <david@cobite.com>
In-Reply-To: <4292A08A.5050108@cobite.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/24/05, David Mansfield <david@cobite.com> wrote:
> > means..
> >
> 
> Ok.  I'll tell you.  It means that the committer uses bad practices in
> tagging ;-)  It generally means that force tag (cvs tag -F <file>) was
> used on a specific file.  Here's the scenario:

Projects that branch on release (and maintain a long-lived stable
branch following the release) often use a floating MERGED branch to
keep track of what bugfixes have been merged back into HEAD. This
practice, broken as it is, is the recommended approach AFAIK.

It would be a good thing to be able to tell cvsps to ignore certain
tags (by name or by regex).


martin
