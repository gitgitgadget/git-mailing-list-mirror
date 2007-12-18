From: Andy Dougherty <doughera@lafayette.edu>
Subject: Re: [PATCH] Minor portability patch to git-submodule
Date: Tue, 18 Dec 2007 08:35:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712180734520.28219@fractal.phys.lafayette.edu>
References: <Pine.LNX.4.64.0712171639420.24957@fractal.phys.lafayette.edu>
 <Pine.LNX.4.64.0712172253150.9446@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 14:36:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ccM-0000ML-3a
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 14:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbXLRNf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 08:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbXLRNf5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 08:35:57 -0500
Received: from mail.lafayette.edu ([139.147.8.42]:44132 "EHLO lafayette.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754065AbXLRNf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 08:35:56 -0500
Received: from fractal.phys.lafayette.edu (account doughera [139.147.232.21] verified)
  by lafayette.edu (CommuniGate Pro SMTP 5.0.13)
  with ESMTPSA id 14369763; Tue, 18 Dec 2007 08:35:55 -0500
X-X-Sender: doughera@fractal.phys.lafayette.edu
In-Reply-To: <Pine.LNX.4.64.0712172253150.9446@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68745>

On Mon, 17 Dec 2007, Johannes Schindelin wrote:

> On Mon, 17 Dec 2007, Andy Dougherty wrote:
> 
> > -	git ls-files --stage -- "$@" | grep -e '^160000 ' |
> > +	git ls-files --stage -- "$@" | egrep -e '^160000 ' |
> 
> Nack.  egrep is not available on all platforms.  But then I have to wonder 
> why not saying "grep '^160000 '" instead?

Your last suggestion is easily and obviously better -- I'll assume you 
don't need an explicit patch and can just hand-edit mine.  Still, I'd have 
thought egrep was fine.  As far as I recall, it goes back to v7 Unix.  Or 
are there non-unix systems at issue (perhaps cygwin variants or something) 
that have grep but not egrep?

Anyway, thanks.

-- 
    Andy Dougherty		doughera@lafayette.edu
