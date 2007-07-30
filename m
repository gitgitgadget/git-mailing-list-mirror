From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 21:10:25 -0700 (PDT)
Message-ID: <994493.95349.qm@web51001.mail.re2.yahoo.com>
References: <alpine.LFD.0.999.0707292007440.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, david@lang.hm
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 06:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFMaU-0001hW-4I
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 06:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbXG3EK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 00:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbXG3EK1
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 00:10:27 -0400
Received: from web51001.mail.re2.yahoo.com ([206.190.38.132]:44585 "HELO
	web51001.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751299AbXG3EK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 00:10:27 -0400
Received: (qmail 95942 invoked by uid 60001); 30 Jul 2007 04:10:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=WXLYPwknW0Cq3Yrok1GkPIOwYCiOo8QP1QgcPJakSktI424Ff7nAvBPAkvAQ3AjNwJZWkqHmJAKrn67cbi6wzJn5hCdLpYnbqCM1TqycgJEsDo0hv9fnW2Hi40r5dQnVKhr299oa6j21nCSq02bLeypx0Z7qO16V9CD1EFQHBlY=;
X-YMail-OSG: Se7sDY0VM1lgRAFLvf9CIod7A8hSFM6mPKeKq.COHpFNy47v4OdxqtqxslQaDptGbvB0Y9a819bP22pKUwuQsNJPs6617t0w7sU1f3jXkrBcL9F8qUJJKum.bzdMiA--
Received: from [208.58.8.179] by web51001.mail.re2.yahoo.com via HTTP; Sun, 29 Jul 2007 21:10:25 PDT
In-Reply-To: <alpine.LFD.0.999.0707292007440.4161@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54181>

--- Linus Torvalds <torvalds@linux-foundation.org> wrote:

> You misunderstand. It would do so both for the newly merged commits *and* 
> for the old commits. Because _you_ think the "new" commits got merged, but 
> it's logically exactly equivalent to saying that the *old* commits got 
> merged.
> 
> So now *every* single commit would get the timestamp of the merge.
> 
> See? It would be pointless.

Ok maybe I am still confused. If a repository is in state A and a merge happens changing it to
state B we can give the changes that got us to B the timestamp of the merge? Since the changes
that got us from A to B were all merged locally at the same time they should be given the same
timestamp, right? Please explain more about how changes/commits in state A would also be given the
timestamp of the merge?

When I say local time I also really mean local commit order as both should be interchangeable
unless you widly misset/change your local clock. Git/gitweb could have an option to sort/display
based on local commit order and maybe have check for if local time order is out of sync with local
commit order.

-Matt


       
____________________________________________________________________________________
Sick sense of humor? Visit Yahoo! TV's 
Comedy with an Edge to see what's on, when. 
http://tv.yahoo.com/collections/222
