From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 14:16:43 -0700 (PDT)
Message-ID: <20060927211643.82491.qmail@web51015.mail.yahoo.com>
References: <Pine.LNX.4.64.0609271347060.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 23:17:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSgls-0003pt-HW
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 23:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030858AbWI0VQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 17:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030859AbWI0VQp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 17:16:45 -0400
Received: from web51015.mail.yahoo.com ([206.190.39.80]:49284 "HELO
	web51015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030858AbWI0VQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 17:16:44 -0400
Received: (qmail 82493 invoked by uid 60001); 27 Sep 2006 21:16:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Rh9UVBBkBSTHOAOzUUYTq5d87xQsZ/hpCEhSZ+SpVGCMCcJh69DquGeGp94vWpWBDPbAjB/lUK84XuH2uofv7sPH+IQGcftWwdzJmhHNmF2e56GgPEOq9GuGJCNr4dFMDM/uKnjP0ULuSbK69PqcR4O18hEOy0l91/ez4XUq5hE=  ;
Received: from [207.172.80.85] by web51015.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 14:16:43 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609271347060.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27934>

--- Linus Torvalds <torvalds@osdl.org> wrote:

> The fact is, in a distributed system, you can _never_ make sense of 
> "time". Just live with it. That's basic "distributed programming 101", and 
> it's the one thing every such course should start with on the very first 
> day.

I agree which is exactly why I think git should conceptually prefer a repo's _local_ time. 

Commit/merge times could be specific to each repo and not generally distributed?  
 
-Matt

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
