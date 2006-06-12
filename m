From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 16:21:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606121619510.5498@g5.osdl.org>
References: <11500407193506-git-send-email-octo@verplant.org>
 <20060612213826.GC4705@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0606130041260.25422@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0606121546320.5498@g5.osdl.org>
 <Pine.LNX.4.63.0606130053400.25682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Florian Forster <octo@verplant.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 13 01:22:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpvjW-00042o-Gu
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 01:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWFLXWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 19:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWFLXWA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 19:22:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932450AbWFLXV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 19:21:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CNLngt008107
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 16:21:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CNLiFT007484;
	Mon, 12 Jun 2006 16:21:46 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606130053400.25682@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21751>



On Tue, 13 Jun 2006, Johannes Schindelin wrote:
> > 
> > The war _I_d like to see is the GUI thing which does the "show when this 
> > section changed last" by following the history down only so far that the 
> > selected section shows up in the diff against the most current thing.
> 
> But this is just the next step! Nothing prevents you -- once everybody 
> agrees that blame/annotate does the right thing -- to restrict the lines 
> of interest. And AFAICT both blame and annotate are good at stopping when 
> all lines are accounted for.

You misunderstand. It's not "all", it's "any" (in fact, it would be even 
better if it would be on a byte-range basis, not on a line-based diff 
basis).

And it needs the GUI to make it useful, because nobody in their right mind 
will say "git showchange fs/inode.c 77-89" (and then do it iteratively if 
the first one wasn't actually the interesting case).

		Linus
