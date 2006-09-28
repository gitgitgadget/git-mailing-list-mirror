From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 07:50:27 -0700 (PDT)
Message-ID: <20060928145027.26643.qmail@web51011.mail.yahoo.com>
References: <20060928131710.GE7469@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthew L Foster <mfoster167@yahoo.com>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 16:50:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSxDd-0006Of-3Q
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 16:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbWI1Ou3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 10:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbWI1Ou3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 10:50:29 -0400
Received: from web51011.mail.yahoo.com ([68.142.224.81]:44125 "HELO
	web51011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161162AbWI1Ou2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 10:50:28 -0400
Received: (qmail 26645 invoked by uid 60001); 28 Sep 2006 14:50:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MV+JegTAkud1PyW6grbADyv4Sr5ApZ6XRL64tnsPtsR8czZT20ED1g5ZBVt45ZiBguYk1UgDQ2ez/HrRu20A3M1vgr73FxvgKQjG96Py7MnnmQFDxTVvVdFurrsntGAZH11pZIxef5LBJo1g8207UuIcgLGQoRnBNfid1y6YIoY=  ;
Received: from [207.172.80.85] by web51011.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 07:50:27 PDT
To: Theodore Tso <tytso@mit.edu>, Sean <seanlkml@sympatico.ca>
In-Reply-To: <20060928131710.GE7469@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28004>

--- Theodore Tso <tytso@mit.edu> wrote:

> In git, we believe that all repositories are equal, and that any sense
> that a particular repository is the "master" or the "mainline" is
> strictly speaking, a matter of convention.  What Matthew I think is
> asking for is direct support in git for that notion.

No. I merely think git should try harder to ensure that commit order is consistent with time
order, it really should (somehow) be impossible for git and gitweb.cgi to have commit dates ~2
days in the future. I think replication is a separate issue. In a distributed system the only
"time" that makes any sense or is the most relevant in many situations and most importantly is the
only thing that can be semi-trusted is local time. "Creation date" is basically just random text
someone entered, there is no guarantee and you are tempting inconsistent time order. And git
shouldn't be so fragile as to need each and every git server to have time set semi-correctly, but
I guess it's a bigger deal to non-developers as we actually use time and also believe even web
interfaces should have consistency and integrity. 

-Matt

-Matt

-Matt
 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
