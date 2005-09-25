From: Martin Coxall <quasi@cream.org>
Subject: Re: rsync deprecated but promoted?
Date: Sun, 25 Sep 2005 20:06:37 +0100
Message-ID: <4d4586301dca616f42880612fae01492@cream.org>
References: <20050925163201.GA29198@tumblerings.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 21:07:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJbpp-0001iw-Ok
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 21:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVIYTGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVIYTGl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 15:06:41 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:25862 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S932268AbVIYTGk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 15:06:40 -0400
Received: from [192.168.0.4] (unknown [84.12.195.36])
	by smtp.nildram.co.uk (Postfix) with ESMTP
	id 63B5824E361; Sun, 25 Sep 2005 20:06:36 +0100 (BST)
In-Reply-To: <20050925163201.GA29198@tumblerings.org>
To: Zack Brown <zbrown@tumblerings.org>
X-Mailer: Apple Mail (2.623)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9276>


On 25 Sep 2005, at 17:32, Zack Brown wrote:

> Hi folks,
>
> When I use cogito, it gives a warning saying the rsync method is 
> deprecated and
> will be removed in the future. But when I visit kernel.org/git, the 
> page says to
> use an rsync URL with cg-clone.
>
> Maybe kernel.org should be updated?
>

It does seem to be sending out a confusing message to us users too, 
since an initial clone of Linus's tree with rsync is on my machine 10x 
faster than an http clone, so it seems to be sending out something of a 
confused/confusing message re: rsync.

Am I right in thinking it's because rsync didn't originally have pack 
support, but now it does, Petr has simply forgotten to deprecate the 
deprecation message?

Kind Regards,

Martin
