From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 13:44:28 -0700 (PDT)
Message-ID: <20060927204428.39120.qmail@web51014.mail.yahoo.com>
References: <Pine.LNX.4.64.0609271109510.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 22:45:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSgGi-000532-8P
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 22:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030810AbWI0Uoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 16:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030809AbWI0Uoc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 16:44:32 -0400
Received: from web51014.mail.yahoo.com ([206.190.39.79]:17769 "HELO
	web51014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030807AbWI0Uoa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 16:44:30 -0400
Received: (qmail 39122 invoked by uid 60001); 27 Sep 2006 20:44:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZbUxrRJCxZLiTIY9maounkDa6XxuXID6dU53EAGsWfDbqIDtHtRkPmeLV42Mrqn25v7eCCYxz8IwMcgN2YQVDrbOmR5hcTW3W/4H31hVWLFUmcLiQIpgKqJglIzj6eBqJrfQ4hhXvRD2pIZYgfvg92V4/uArzEBQG54EleOQL4I=  ;
Received: from [207.172.80.85] by web51014.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 13:44:28 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609271109510.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27929>

--- Linus Torvalds <torvalds@osdl.org> wrote:

> > Ok, the word "history" in the context of git primarily means the order of changes not the
> when?
> > Would it be a conceptual or technical issue for git to directly track the local time of
> > merges/changesets?
> 
> True merges _get_ tracked - they are commits too (they just have multiple 
> parents).
> 
> But it's only the time the merge was done that gets tracked, not the time 
> the merge was then pushed out to somebody else.

What is the difference between a merge and a "merge then pushed out"? There are at least some
situations where a repo would prefer to know its local time of a merge or pulled in merge and
anyway a local repo probably should not in any way be dependent on nor _trust_ all remote repos
timestamps...?

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
