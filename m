From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: looking for "market share" analysis of SCMs.
Date: Wed, 21 May 2008 00:25:05 +0200
Message-ID: <bd6139dc0805201525r22ba7398g6f341f89ae699b57@mail.gmail.com>
References: <48329282.1040407@tikalk.com>
	 <20080520093245.GA5037@mithlond.arda.local>
	 <bd6139dc0805200310j13a9b74dy9f28fe855c59e01b@mail.gmail.com>
	 <alpine.LNX.1.00.0805201748020.19665@iabervon.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>,
	"Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 21 00:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyaHQ-0007B4-Ul
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 00:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759768AbYETWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 18:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760757AbYETWZI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 18:25:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:20221 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758481AbYETWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 18:25:06 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1940428wfd.4
        for <git@vger.kernel.org>; Tue, 20 May 2008 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=012LFHMuMLMZgrXggd9kSYELYjN+/r5ftnHclipoJ60=;
        b=wmFDYdTwtdo7jLZzIsN0r+zyjzvyoRA5P1HB+tT0ZQSC+84zv+6Lv8ffNt3CxSo8smlJYe/Osn3/8kap1x7enDDwyyzrs5bgudSBmJMBgFSZLA56CqNz+YhomneGT28xgjLg4jQ3FZQ6e3WsWEpL59fWnUflWvrEDYsL6EnCJeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pixqar5IuCro8wFrKC+hepm2HJd1UvEbH7SC4WZO/5C1DEhbmXZe0r2DCdDwgoKFFP094pHa8fVmYXnR3KeVSxGNJv7bm7B9BG06cqf2rauZIiXMZUcSz5aZ6zyi5ft1rEzzgTZNLKrFS1iwqBBkyN02/EfewxxdC29iQaOQN0k=
Received: by 10.142.48.14 with SMTP id v14mr3565027wfv.133.1211322305889;
        Tue, 20 May 2008 15:25:05 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Tue, 20 May 2008 15:25:05 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0805201748020.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82513>

On Wed, May 21, 2008 at 12:07 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Doing it as a percentage is kind of odd; it demonstrates that using
> version control is decreasing in popularity as more and more people who
> don't use version control submit votes. All of the version control systems
> show an upward trend in number of users, but most of them are not growing
> as much as the market is shrinking. Unfortunately, there doesn't seem to
> be a way to get the people who use each of them as a percentage of people
> who use any of them, which is what you want for "market share".

Ah, you are right, I didn't analyse the graph enough, I thought
percent would show what you described above, obviously it doesn't
though as the values don't add up to 100%. Even so, I think this is a
better graph:
http://tinyurl.com/4hu2cn
Since it shows users that regularly use the package, instead of user
that have it installed. Considering that these days distro's have a
lot of stuff pre-installed if you go with the "coders packages" the
usage votes give a better picture than looking at who has it installed
(which includes people that don't use the package at all). That graph
shows that in the end of 2006 SVN became more popular than CVS,
whereas the one from Teemu (http://tinyurl.com/4vpqzg) does not show
that, probalby because a lot of people have it installed, but don't
use it.
It would be interesting if we could link the grow spurts from
http://tinyurl.com/4hu2cn to programming-related events, something
that might have caused people to suddenly use a VCS a lot more (for
example the one in CVS's line from 05-2007 till 07-2007).

-- 
Cheers,

Sverre Rabbelier
