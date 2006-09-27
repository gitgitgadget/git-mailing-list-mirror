From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 15:28:54 -0700 (PDT)
Message-ID: <20060927222854.82278.qmail@web51014.mail.yahoo.com>
References: <Pine.LNX.4.64.0609271446160.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 00:29:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GShtj-0001QS-3n
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 00:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031148AbWI0W24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 18:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031149AbWI0W24
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 18:28:56 -0400
Received: from web51014.mail.yahoo.com ([206.190.39.79]:19074 "HELO
	web51014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1031148AbWI0W24 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 18:28:56 -0400
Received: (qmail 82280 invoked by uid 60001); 27 Sep 2006 22:28:54 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ywa4VPrAQttibBNXZlfNW8jgSy4hDdxM7oYxkjSgaY+YzmxR1kxJ2hvvPOByPG5dMuN7bCRr4ndjwC8FxgW9h+oGNFfJZOGr1iYZyL4BwiJuhhbCsomhtzdFH2GPHriawP7GZ9l39MdneH0QvGituUmV3YG2DXwf9RL+HBbsy8A=  ;
Received: from [207.172.80.85] by web51014.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 15:28:54 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609271446160.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27939>

--- Linus Torvalds <torvalds@osdl.org> wrote:

> The actual action happened at 8:30. And git tracks only truth. It doesn't 
> rewrite the truth afterward.

So the separate action of replication is not tracked? Replication/sub merges are denied the
possibility of "truth"?

To be clear I think there are actually two separate though semi-related issues:

- 1. release/replication time of a mirrored private --> public repo

- 2. A repo's commit order being inconsistent with local time order

My questions are primarily focused on #2. Last weekend even your private repo's commit order was
out of sync with your local time order because a remote git server's time was grossly
misconfigured, right? Integrity wise that shouldn't happen. I am merely asking if tracking
commits/merges using local repo time could solve both issues? If the local merge time information
is already available in the ref-log then gitweb.cgi might only need to be made aware of it.

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
