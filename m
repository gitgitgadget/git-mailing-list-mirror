From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 14:44:16 -0700 (PDT)
Message-ID: <20060927214417.36420.qmail@web51002.mail.yahoo.com>
References: <Pine.LNX.4.64.0609271354480.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 23:44:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GShCY-0000dj-50
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 23:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030902AbWI0VoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 17:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030904AbWI0VoT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 17:44:19 -0400
Received: from web51002.mail.yahoo.com ([206.190.38.133]:24427 "HELO
	web51002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030902AbWI0VoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 17:44:18 -0400
Received: (qmail 36422 invoked by uid 60001); 27 Sep 2006 21:44:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dvQGMzX2hd2yMRD0kiZNpasBJIS20QBQ1CjD3DsEC17ymjWoRImwPZUWVDvpvo00F5rUU/sjtyJ396G/yP1N34D9RLvykjCLntNzIjAouD3Shg3b5PgPaErX5AGRPAz5sTNuBLSEhmbNda7cGjt9eeVfYlKmEZQrWHTOyuUnwUQ=  ;
Received: from [207.172.80.85] by web51002.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 14:44:16 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609271354480.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27936>

--- Linus Torvalds <torvalds@osdl.org> wrote:

>  - so I replicate my home machine tree to the one on master.kernel.org, 
>    and now others can see it.
> 
> When did the merge happen? It happened at 8:30 on my machine, and that's 
> what is recorded. End of story. No ifs, buts, maybes about it. That's the 
> only time you can _ever_ see for that merge.

Ok, so it's more complex because of the workflow issue of delayed/pseudo mirroring/replication
between private and public repos? This cloning/replication is not done through git? Are you saying
it's impossible for master.kernel.org's git to track the local time of each
commit/merge/replication? Perhaps replication time is precisely what should/could be tracked
(locally)? 

>From an integrity or at least gitweb.cgi's viewpoint it seems very important to me that commit
order also be per repo consistent with time order.

-Matt

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
