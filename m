From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 17:12:41 -0700 (PDT)
Message-ID: <20060928001241.62887.qmail@web51013.mail.yahoo.com>
References: <Pine.LNX.4.64.0609271606050.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 02:12:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjWA-00025y-2q
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031271AbWI1AMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031274AbWI1AMn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:12:43 -0400
Received: from web51013.mail.yahoo.com ([68.142.224.83]:51088 "HELO
	web51013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1031271AbWI1AMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 20:12:42 -0400
Received: (qmail 62889 invoked by uid 60001); 28 Sep 2006 00:12:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qgi7dsqtAI9qHy+xS+1eg3ehVKpuMTLJ9bmFrgklSS1UwJADYeIFBFKum1V4FB/Sa/YqPWxX2L4jz/yk8JK2p0p1o1UnJtUUwymTcjqRaQmmzMq0cSi5Ic0IEj0cSMfcZVWA+iLn6nrHTWSGs57/vL8TGPO3HVjlOuIXftK2ke4=  ;
Received: from [207.172.80.85] by web51013.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 17:12:41 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609271606050.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27950>


Ignoring the separate issue of replication for a momment, can someone respond to my time integrity
question about whether a future version of git could trust/prefer its local time rather than a
remote/sub/parent (non replicated) git server's timestamp? How do we fix gitweb.cgi, ref-log? How
useful is gitweb.cgi if timestamps are all over the place? It does not make sense that commit
order is currently out of sync with time order in the main linux kernel tree git repo on
kernel.org. Why must each and every repo be dependent on time being set properly on all other git
servers? How useful is change history or commit order without some concept of (local) time order?

-Matt 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
