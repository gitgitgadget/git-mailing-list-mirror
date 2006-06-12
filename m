From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 15:49:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606121546320.5498@g5.osdl.org>
References: <11500407193506-git-send-email-octo@verplant.org>
 <20060612213826.GC4705@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0606130041260.25422@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Florian Forster <octo@verplant.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 13 00:50:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpvEh-0007AL-VH
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 00:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWFLWuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 18:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWFLWuO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 18:50:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751396AbWFLWuN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 18:50:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CMo3gt006646
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 15:50:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CMnv1Y006597;
	Mon, 12 Jun 2006 15:49:59 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606130041260.25422@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21749>



On Tue, 13 Jun 2006, Johannes Schindelin wrote:
> 
> On Mon, 12 Jun 2006, Fredrik Kuivinen wrote:
> 
> > git-blame is a bit faster than git-annotate and, as far as I know, it 
> > produces output which is correct.
> 
> Yeah: Bring It On(tm)! I already waited for ages for this war to begin!

Sadly, I don't think either of you can really do much about the fact that 
annotate/blame is simply the wrong model for git.

The war _I_d like to see is the GUI thing which does the "show when this 
section changed last" by following the history down only so far that the 
selected section shows up in the diff against the most current thing.

THAT is what I want. It also fits the git model much better, since you 
generally don't have to go back all the way.

Somebody? "Here's a nickel saying you can't do it!" (if somebody needs the 
motivation ;)

		Linus
