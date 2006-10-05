From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Wed, 4 Oct 2006 18:11:37 -0700 (PDT)
Message-ID: <20061005011137.20903.qmail@web31807.mail.mud.yahoo.com>
References: <7v1wpnk20p.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 03:13:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVHm2-00040u-KW
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 03:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWJEBLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 21:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWJEBLj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 21:11:39 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:22439 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751299AbWJEBLi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 21:11:38 -0400
Received: (qmail 20905 invoked by uid 60001); 5 Oct 2006 01:11:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BsRm5uDBC5aRFhQ6oANGYk1naXzWK6UK9ahCzfZI7mk/PTW7y1+y6i1zlDLqbbQjDEOQpq2IAd9FVfaetxD7XMommy2kG6Ni+4tpqMqFH/8zML8TSc4mi4AjFw2G7HLNzL8jn3YsTNNvh51pAuGmkPlUkToT8pGeucwKa/AFsFM=  ;
Received: from [64.215.88.90] by web31807.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 18:11:37 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wpnk20p.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28339>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Yes, I completely understand the problem you're describing
> > here and have seen even more extreme examples of it.
> 
> I agree with your conclusion.  More than one commit-8 placed in
> a large group end up visually suggesting that they are
> separating the group into multiple pieces that have some
> meaning, which is not, because the contrast of zebra shading
> between groups is very subtle and is much weaker than commit-8
> "clickable handles".
> 
> I am not suggesting to make the contrast of shading stronger;
> that would make things harder to read, and readability matters
> more on that page.
> 
> Will revert mine from "next" (along with the mistakenly dropped
> executable bit) and replace with your patch 1 and 2.

Sounds great -- thanks!

   Luben
