From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.defaultOptions"
Date: Tue, 17 Mar 2009 09:05:18 -0700 (PDT)
Message-ID: <alpine.GSO.2.00.0903170825340.16242@kiwi.cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:07:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljbp2-0000IE-Dk
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbZCQQFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbZCQQFa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:05:30 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:44341 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbZCQQF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:05:29 -0400
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n2HG5JtK023161;
	Tue, 17 Mar 2009 09:05:19 -0700 (PDT)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n2HG5Ioc023157;
	Tue, 17 Mar 2009 09:05:19 -0700 (PDT)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <20090203071516.GC21367@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113487>

Peff,

I'm replying to http://permalink.gmane.org/gmane.comp.version-control.git/108158

On Tue, 3 Feb 2009, Jeff King wrote:

> All in all, this was a lot more complicated than I was expecting. Why isn't 
> the behavior of "diff.primer" simply "pretend as if the options in diff.primer 
> were prepended to the command line"? That is easy to explain, and easy to 
> implement (the only trick is that you have to do an extra pass to find 
> --[no-]primer). Is there some drawback to such a simple scheme that I am 
> missing?

In order to answer your questions as convincingly as possible, I wrote up a 
one-page PDF document, downloadable here:
                http://preview.tinyurl.com/c769dd

You will see I clarified my arguments, and I found very compelling reasons for 
my design.  Also, BTW, v3 supports all diff options under the sun, instead of a 
limited subset.  That addresses your primary complaint WRT functionality.  
Please take a look at the PDF and I hope you agree.

                                 -- Keith
