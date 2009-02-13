From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] How to review patches: Documentation/ReviewingPatches?
Date: Fri, 13 Feb 2009 01:08:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902130055370.26370@racer>
References: <200902130045.59395.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 01:10:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXld7-00013b-5E
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 01:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbZBMAIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 19:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755152AbZBMAIg
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 19:08:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:36485 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755117AbZBMAIf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 19:08:35 -0500
Received: (qmail invoked by alias); 13 Feb 2009 00:08:31 -0000
Received: from pD9EB2494.dip0.t-ipconnect.de (EHLO noname) [217.235.36.148]
  by mail.gmx.net (mp039) with SMTP; 13 Feb 2009 01:08:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Fd5xzKu1FN6lgtXlODkBKxUE6YF6inpvIaZZSd9
	8lV84PI65q1sIz
X-X-Sender: gene099@racer
In-Reply-To: <200902130045.59395.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109692>

Hi,

On Fri, 13 Feb 2009, Jakub Narebski wrote:

> What I'd like to have is Documentation/ReviewingPatches to help with (at 
> least technical side of) reviewing patches, which is very important but 
> a hard work, c.f. http://www.kroah.com/log/linux/ols_2006_keynote.html

As I found out quite painfully recently, reviewing is a matter of trust, 
much more so than a matter of form or style.

I mean, it does not really hurt when somebody says ACK not understanding 
that an ACK is expected to come from people who wrote that particular 
code, or are at least very familiar with it.  We know what the guy means, 
and that's it.

However, it does hurt when somebody says "I tested this extensively, and 
it works, I also reviewed the code, and it is correct" and you find out 
much later that the review consisted of a run through "indent" and seeing 
that there were no differences.  Unsurprisingly, the patch had to be 
reverted entirely.

It's much better to have somebody prove her capability as an excellent 
reviewer, for example by offering comments that result in a better patch, 
earning respect by others in the process.

Speaking for myself, it is also quite possible that you find out that your 
reviewing fu is leaving to be desired.  Concretely, it is widely known 
that patches I reviewed still contain several issues after I find no more.

But at least I can serve as an early filter as long as I have the time.

There is another reason why I do not want any ReviewingPatches: reviewing 
is already such a tedious process; let's not make it harder by forcing a 
potential reviewer to sift through a document (the same could be said 
about SubmittingPatches; IMHO it just repeats what common sense would do 
anyway when imitating existing code).

I'd rather suggest to patch submitters to make such a good case that all 
the world is interested in their patch, throwing a lot of eyeballs (AKA 
review) at it.

BTW this is a pretty valuable skill, also (maybe especially) outside of 
this mailing list, to get people interested in your work.

Ciao,
Dscho
