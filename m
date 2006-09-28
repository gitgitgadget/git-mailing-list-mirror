From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 12:43:16 -0700 (PDT)
Message-ID: <20060928194316.42986.qmail@web51004.mail.yahoo.com>
References: <Pine.LNX.4.63.0609281941570.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 21:43:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1n0-0007aJ-0y
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWI1TnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWI1TnS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:43:18 -0400
Received: from web51004.mail.yahoo.com ([206.190.38.135]:2133 "HELO
	web51004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161029AbWI1TnR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 15:43:17 -0400
Received: (qmail 42988 invoked by uid 60001); 28 Sep 2006 19:43:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vDbhEPNGVjYxW9LTexpn5OFOBQBW4RGsgzcOkbiFmZrVcenaET+0zJjsYoACAHc/ZTijRGPh5bulI9bJIzUG6V5DD+75jxECJTiLTIQyH2FNMKULBWD/MwVEyPwjlWeM422jNZYtjaqvDDdBdxr6ozMWKIQALs5EuYZhEcN+sjs=  ;
Received: from [207.172.80.85] by web51004.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 12:43:16 PDT
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609281941570.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28042>

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> On Thu, 28 Sep 2006, Matthew L Foster wrote:
> 
> > It should be possible to export git data, through say a web interface, 
> > in a such a way that local time order is consistent with commit order.
> 
> Why?

- So exported data is never/rarely in an inconsistent state with respect to commit order and local
time order (data integrity).

- To encourage people to care about/prefer local commit time rather than remote creation/emailed
time

- So people that user repo X, or binaries from repo X, know when bug fix Y/fancy new feature Z was
committed/merged locally

- In many situations "history" is incomplete without local commit time. If a company has a new
driver they would probably prefer to know when the main kernel repo has it, not when they
created/emailed it or when a remote repo committed it.

-Matt

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
