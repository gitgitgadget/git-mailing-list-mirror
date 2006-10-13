From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Fri, 13 Oct 2006 13:54:18 -0700 (PDT)
Message-ID: <20061013205418.5087.qmail@web31803.mail.mud.yahoo.com>
References: <7vmz81kwh3.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 22:54:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYU2x-0006ip-I9
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 22:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWJMUyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 16:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWJMUyU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 16:54:20 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:8111 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751899AbWJMUyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 16:54:19 -0400
Received: (qmail 5089 invoked by uid 60001); 13 Oct 2006 20:54:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=v3yzoYNs4XDSIdTb+RC4ne4iQQ2YrgHe71w0L6xPEVche5kRwyhXo7a8SabwC1DywQDHyDvmJwLyjk1Ps5k8bM9eAdXkTWdpbc7ZgxXUPg0ZGeAe7SPLunWdYdJ2muFEjA2lyey6lQ1zUqZkufZc98ssVMMjMJgnnlrZCgdXBeA=  ;
Received: from [64.215.88.90] by web31803.mail.mud.yahoo.com via HTTP; Fri, 13 Oct 2006 13:54:18 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz81kwh3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28860>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Junio, is it possible to also print the "previous" commit?
> > I mean, is it tenable to print the commit such that
> > a "git-diff C B -- A:file" will give a diff of the block of lines
> > we're looking at?
> 
> There is no single "previous" in general.  Which side of the
> merge would you take?

The parent commit.

For example,
Annotation/blame of A:File
C 1 line 1
  2 line 2
D 3 line 3
B 4 line 4

The parent commit of C, such that,
git-diff parent(C) C -- A:File
will give me the diff which introduced
the "first block", or more generally,
all lines annotated with C.

Then when I click on 1 or 2, I'd like to
see Annotation/blame of parent(C):File,
on the line number where the C "block" was
introduced.

   Luben
