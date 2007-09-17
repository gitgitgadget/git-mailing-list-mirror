From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 2/3] git-apply: complain about >=8 consecutive spaces
	in initial indent
Date: Sun, 16 Sep 2007 22:44:53 -0400
Message-ID: <20070917024453.GA24675@fieldses.org>
References: <11899829424040-git-send-email-bfields@citi.umich.edu> <11899829424173-git-send-email-bfields@citi.umich.edu> <1189982942187-git-send-email-bfields@citi.umich.edu> <7vy7f63zr4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 04:45:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX6bi-0004a5-DZ
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 04:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbXIQCpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 22:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbXIQCpA
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 22:45:00 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43104 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbXIQCo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 22:44:59 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IX6bV-0006Yo-UI; Sun, 16 Sep 2007 22:44:53 -0400
Content-Disposition: inline
In-Reply-To: <7vy7f63zr4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58374>

On Sun, Sep 16, 2007 at 05:24:31PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@citi.umich.edu> writes:
> 
> > Complain if we find 8 spaces or more in a row as part of the initial
> > whitespace on a line, and (with --whitespace=stripspace) replace such by
> > a tab.
> >
> > Well, linux's checkpatch.pl complains about this sort of thing.
> 
> Some people program in Python, so I am afraid that this needs to
> be a separate option.

OK.

> Maybe it is time to redo the --whitespace options as bitmasks so
> that we can say --whitespace-fix=tab,tail,lines to pick and
> choose which kinds of breakage to fix?

OK.  Or maybe keep the current commandline options and have a
whitespace-style config option someplace?

I'm afraid I won't get to either anytime soon, though, so that project's
up for grabs....

--b.
