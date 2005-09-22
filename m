From: Robert Watson <robert.oo.watson@gmail.com>
Subject: Re: command to show diff of a commit
Date: Thu, 22 Sep 2005 15:25:01 +0100
Message-ID: <72499e3b0509220725a52fef8@mail.gmail.com>
References: <72499e3b05092202583f9a751d@mail.gmail.com>
	 <20050922100458.GF21019@pasky.or.cz>
Reply-To: Robert Watson <robert.oo.watson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Sep 22 16:29:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIS0a-0000m3-55
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 16:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbVIVOZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 10:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVIVOZE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 10:25:04 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:20998 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030359AbVIVOZC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 10:25:02 -0400
Received: by qproxy.gmail.com with SMTP id v40so57195qbe
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 07:25:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CpOoC1ClbPrSPQo/d31HIZ2du4ergj/O6tvIEIQvmqQttJINESxwSoTR2iIDUR07ArmUBwX+asRdWAtqJaC4ajlzmF6h3QLWaUmWYQnwW7QOmcQ2qhcwpVJNlSZW8Xq1J45QHnHUzqUReJ6YITbJRb4Iw9t2SoxfODylaKXf1yE=
Received: by 10.64.213.16 with SMTP id l16mr167243qbg;
        Thu, 22 Sep 2005 07:25:01 -0700 (PDT)
Received: by 10.64.203.14 with HTTP; Thu, 22 Sep 2005 07:25:01 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050922100458.GF21019@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9119>

On 9/22/05, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Thu, Sep 22, 2005 at 11:58:32AM CEST, I got a letter
> where Robert Watson <robert.oo.watson@gmail.com> told me that...
> > Hi,
>
> Hi,
>
> > I am wondering what is the best way to show the change introduced by a
> > commit. In the other words, is there a better way to do this:
> >
> > git-diff b163512d4eb36ee946908b682c7863658c5a8db4^
> > b163512d4eb36ee946908b682c7863658c5a8db4
>
> with Cogito, you would say
>
>         cg-diff -p -r b163512d4eb36ee946908b682c7863658c5a8db4
>
> to see the diff against its parent. (You should still choose the parent
> manually in case of merge commits.)
>

Thanks, it is nice to know that cogito can go it.  But can I achieve
the same with git-core only?

Thanks,
Robertoo
