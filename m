From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Tue, 3 Oct 2006 12:45:51 -0700 (PDT)
Message-ID: <20061003194551.70537.qmail@web31809.mail.mud.yahoo.com>
References: <20061003192018.GR2871@admingilde.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 21:46:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqDE-0007Is-Ja
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 21:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWJCTpx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 15:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWJCTpx
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 15:45:53 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:5728 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964877AbWJCTpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 15:45:52 -0400
Received: (qmail 70539 invoked by uid 60001); 3 Oct 2006 19:45:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rGI6sronxViJvjc5soO1hHnzmSGIBR5W1ZgTRPTMcEVvTlmSWpKv8sA3pkxkNJthB64IGV71HINzty8FBGd5H476lU3G1YwzDmT2gpaNpNhovZzCWMDUUuX2omDDydZG1vNwMkAn/RYTNMfrHFiy9leUmDOOjSw5tg7UsT1+z5c=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Tue, 03 Oct 2006 12:45:51 PDT
To: Martin Waitz <tali@admingilde.org>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061003192018.GR2871@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28292>

--- Martin Waitz <tali@admingilde.org> wrote:
> hoi :)
> 
> On Tue, Oct 03, 2006 at 12:25:45AM -0700, Junio C Hamano wrote:
> > [PATCH] gitweb: make leftmost column of blame less cluttered.
> > 
> > Instead of labelling each and every line with clickable commit
> > object name, this makes the blame output to show them only on
> > the first line of each group of lines from the same revision.
> > 
> > Also it makes mouse-over to show the minimum authorship and
> > authordate information for extra cuteness ;-).
> 
> what about making the line itself clickable and adding the
> mouse-over there, too?
> Then you don't need to worry about repeating the commit id,
> and perhaps it is not even needed any more?

I like Junio's first patch on the subject with the only
objection that the "chunk" can be 100s of 1000s of lines
if the file is too big and there had never been any changes
since the initial commit.

I like the fact that the "data part" of blame is text, and
that the commit-8 is on the left, and color-chunked.  Sometimes
people simply _remember_ a number of commit-8's and thus the
layout of blame is intentional, since they can look to the left
and recognize a commit-8...

    Luben
