From: Jeff King <peff@peff.net>
Subject: Re: import files w/ history
Date: Tue, 3 Mar 2009 08:00:46 -0500
Message-ID: <20090303130046.GA7867@coredump.intra.peff.net>
References: <slrngqqa4l.1t4t.csaba-ml@beastie.creo.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Csaba Henk <csaba-ml@creo.hu>
X-From: git-owner@vger.kernel.org Tue Mar 03 14:02:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeUGI-0004LU-Gu
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 14:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbZCCNAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 08:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbZCCNAu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 08:00:50 -0500
Received: from peff.net ([208.65.91.99]:45200 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbZCCNAu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 08:00:50 -0500
Received: (qmail 15928 invoked by uid 107); 3 Mar 2009 13:00:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 08:00:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 08:00:46 -0500
Content-Disposition: inline
In-Reply-To: <slrngqqa4l.1t4t.csaba-ml@beastie.creo.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112069>

On Tue, Mar 03, 2009 at 12:54:54PM +0000, Csaba Henk wrote:

> How could I import some files from an unrelated git repo with history?

Just "git pull" from the other repo, which will include all of its
history. If you want to pretend that the other history contains just a
subset of the true history, use "git filter-branch" to rewrite it first.

> And if I'd like to use different paths? Eg:
> 
> Say the other repo has these files:
> 
> lib/trees/rb_tree.{c,h}
> 
> and I want to import them into my repo as
> 
> include/rb_tree.h
> src/rb_tree.c

If you are rewriting the history, you can rename the files as you see
fit. There is even an example of this in "git help filter-branch".

-Peff
