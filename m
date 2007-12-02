From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which commit
 was created
Date: Sun, 2 Dec 2007 21:20:09 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712022107090.27959@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
 <Pine.LNX.4.64.0711111736440.4362@racer.site> <20071201222106.GA27102@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712012238510.27959@racer.site> <20071202054030.GA393@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712021212490.27959@racer.site> <20071202165409.GA30998@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712021716220.27959@racer.site> <7vtzn1x7w6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:20:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IywFD-0007r3-4q
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 22:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbXLBVUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 16:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbXLBVUd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 16:20:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:36906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754700AbXLBVUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 16:20:31 -0500
Received: (qmail invoked by alias); 02 Dec 2007 21:20:29 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp033) with SMTP; 02 Dec 2007 22:20:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jHxpx4DcjCyBAHO67r+c0giMbt0tKYUoxgT25nk
	+eZSHpluFRxZ5i
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtzn1x7w6.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66817>

Hi,

On Sun, 2 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I have made several attempts to reproduce the problem, looked a bit
> >> through the log-tree code, and checked the results of the t750* series
> >> of tests; but I have found nothing.
> >
> > I remember again.  When I did "commit -s -m bla" the  empty line between 
> > the oneline and the signoff would be missing.  But in the meantime, the 
> > signoff was dragged into the strbuf and all is well.
> 
> Sorry, now I am confused.  Building the version before that change and
> doing "./git-commit -a -s -m bla", I do not see the extra blank line in
> the "Created commit" response, and I see a blank line before and after
> the sign-off in the "git show" output for the resulting commit.
> 
> Was this unnecessary change from the beginning?  I am inclined to think
> so...

IIRC I did 2150554b0ed60356d8918b610834c04ad2eecdec(builtin-commit --s: 
add a newline if the last line was no S-O-B) after the commit that 
Peff wants to undo.

So yes, my mistake.

Ciao,
Dscho
