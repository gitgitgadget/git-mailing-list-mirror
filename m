From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 19:49:37 -0700 (PDT)
Message-ID: <20060928024938.46785.qmail@web51009.mail.yahoo.com>
References: <BAYC1-PASMTP06CEC55B088A0817EB52CBAE1B0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 04:50:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSlyg-0002pG-Fm
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 04:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWI1Ctj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 22:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWI1Ctj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 22:49:39 -0400
Received: from web51009.mail.yahoo.com ([206.190.39.128]:28282 "HELO
	web51009.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965227AbWI1Ctj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 22:49:39 -0400
Received: (qmail 46787 invoked by uid 60001); 28 Sep 2006 02:49:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XH3Yz2UqW1gCEYbM6cXkdWh5hhH/1MKN/KqHp5x6GyALpg3abL6VhHjadSeH3bR5J9qwqucgoYM5gItL8g1el5wFUewl6QhFTK/VJo5Bg0Qy+veoZq3Ygne2dPQujGNKO1iaePPiSY9EqsMeiDl3p8ICW/J4RXOsQX2MO8viO3o=  ;
Received: from [207.172.80.85] by web51009.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 19:49:37 PDT
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP06CEC55B088A0817EB52CBAE1B0@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27969>

--- Sean <seanlkml@sympatico.ca> wrote:

> On Wed, 27 Sep 2006 18:48:11 -0700 (PDT)
> Matthew L Foster <mfoster167@yahoo.com> wrote:
> 
> > I actually understand that and agree. All I've been saying is it (git or gitweb.cgi) should
> prefer
> > the local timestamp rather than any "remote" timestamps for no other reason than to minimize
> the
> > possibility of timestamps being grossly inaccurate.
> 
> But any local time stamp would be a _lie_.  The time stamp in the commit records
> when it was actually created.  And as Junio has pointed out, hundreds of commits
> will typically arrive in a repo at the exact same time.  Your suggestion would
> have them all showing the exact same time.  That's not helpful, and it loses
> important factual information.

How does git ensure that the timestamp in a commit records when it was actually created? I am not
saying throw away creation time, just that local time is more preferable and relevant and
git/gitweb.cgi should not in any way depend on time being configured correctly on each and every
git server. I think users of kernel.org's repo (or web interface) care more about when change X
was commited to it than when an author created/emailed change X, but perhaps I am wrong or don't
understand git or both. 

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
