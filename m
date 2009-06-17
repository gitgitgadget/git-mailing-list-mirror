From: Sam Vilain <sam@vilain.net>
Subject: Re: Perl parts not installed in correct location
Date: Thu, 18 Jun 2009 09:29:39 +1200
Message-ID: <1245274179.8169.5.camel@maia.lan>
References: <20090617210747.9E4AE1E75F61@ode.ics.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: A Braunsdorf <ab@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Jun 17 23:28:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH2gD-00069y-MJ
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 23:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbZFQV2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 17:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbZFQV2N
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 17:28:13 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:41426 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835AbZFQV2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 17:28:13 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id D7B1021C3EB; Thu, 18 Jun 2009 09:28:07 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.182] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 884D521C388;
	Thu, 18 Jun 2009 09:28:03 +1200 (NZST)
In-Reply-To: <20090617210747.9E4AE1E75F61@ode.ics.purdue.edu>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121776>

On Wed, 2009-06-17 at 17:07 -0400, A Braunsdorf wrote:
> Doing a make install put the Perl parts of git in a directory that
> is >not< in @INC for my copy of Perl.  That's wrong.  If you're not
> going to ask Perl for the right place to put it, at least make it
> a configure option. :-(

Looking at the Makefile it looks like this might be when the PREFIX for
installation doesn't match that of Perl's - can you confirm this?

Did the *.perl files in the source get installed with the right #!perl
line at the top?

Sam
