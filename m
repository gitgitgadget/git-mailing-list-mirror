From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 09:02:16 +0200
Message-ID: <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	 <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	 <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <4536EC93.9050305@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 09:32:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaSNy-0002P4-VE
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 09:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946071AbWJSHcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 03:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946069AbWJSHcE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 03:32:04 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:2909 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1946071AbWJSHcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 03:32:01 -0400
Received: by py-out-1112.google.com with SMTP id n25so689539pyg
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 00:31:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EitJU3t19/Vt2uOTcnUmrW1vcNA8BeUSud/e4SKeYY+3t5C8ppFEo9iQbMUJN1/Y+y9jcf3IFjNO5qJxkxVOFaRjPIzRmWpzlfk1XoQl7skS6XTtklhA/GSdjdUYcvQEZELd+gz59a1bWr+iTZ9AYl815s8Z6LZy//923jfKhKk=
Received: by 10.35.123.10 with SMTP id a10mr19418380pyn;
        Thu, 19 Oct 2006 00:02:56 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Thu, 19 Oct 2006 00:02:16 -0700 (PDT)
To: "Aaron Bentley" <aaron.bentley@utoronto.ca>
In-Reply-To: <4536EC93.9050305@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29329>

> > In git, the fact that everybody is on an equal footing is something that I
> > think is really good. For example, when I was away for effectively three
> > weeks during August, all the git-level merging for the kernel was done by
> > Greg KH.
> >
> > And realize that he didn't use "my tree". No baton was passed. I emailed
> > with him (and some others) before-hand, so that everybody knew that I
> > expected to be just pull from Greg when I came back, but it was _his_ tree
> > that he merged in, and he just worked the same way I did.
> >
> > And when I did come back, I did a "pull" from his tree.
>
> That sounds to me like a baton was passed.  You asked Greg to behave
> like you, and told everyone else to expect that, too.  Passing the baton
> was a social, not technical event, but it did happen.  And there would
> certainly be no difficulty doing exactly that (right down to running
> "pull") in Bazaar land.


I'd like to point out that the same thing has happened in bzr-land.
Back in the "pre-bot" days, only Martin did put things in "his branch"
where most people got bzr from (same as Linus' git branch), but he was
away for a few weeks and during this time, there was 3 (or 4 perhaps)
other branches, called integration branches, that was being used.
They were all maintained by different people.

Everyone learned really quickly to use them instead of Martin's
branch. When Martin came back, he just pulled/merged these branches
and everything was back to normal.

I'd say in this case, bzr was even more "without a trunk" then in the
example Linus gives above.

What seams to be one interesting thing in this discussion is that,
because people use bzr and git in slightly different ways, they think
that one or the other cannot be used in another way.

bzr's use of revision numbers, doesn't mean it hasn't got unique
revision identifiers, and I can't see any reason why it couldn't be
used in the same way as git.  Both are excellent tools, and since git
is more specialized (built to support the exact workflow used in
kernel development), it's more suited for that exact use.

bzr tries to take a broader view, for example, it does support a
centralized workflow if you want one.  Most people don't, but a few
might. Because of this, it probably fits the kernel development less
good than git.  That's fine I think! I happens to fit my workflow
better than git does :)

Regards,
Erik
