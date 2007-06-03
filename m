From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 03 Jun 2007 17:44:58 +0200
Message-ID: <vpq1wgtnith.fsf@bauges.imag.fr>
References: <20070603114843.GA14336@artemis>
	<878xb19ot5.fsf@graviton.dyn.troilus.org>
	<20070603133109.GD14336@artemis>
	<200706031548.30111.johan@herland.net>
	<20070603151921.GB30347@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Poole <mdpoole@troilus.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 17:45:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HusGh-0000fA-Rn
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 17:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbXFCPpQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 11:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbXFCPpP
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 11:45:15 -0400
Received: from imag.imag.fr ([129.88.30.1]:44966 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbXFCPpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 11:45:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l53FiwQU003523
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2007 17:44:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HusGI-0007tV-Gl; Sun, 03 Jun 2007 17:44:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HusGI-0006K5-D7; Sun, 03 Jun 2007 17:44:58 +0200
Mail-Followup-To: Johan Herland <johan@herland.net>, git@vger.kernel.org,  Michael Poole <mdpoole@troilus.org>
In-Reply-To: <20070603151921.GB30347@artemis> (Pierre Habouzit's message of "Sun\, 3 Jun 2007 17\:19\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 03 Jun 2007 17:44:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49009>

Pierre Habouzit <madcoder@debian.org> writes:

>   Yeah, now that I read that thread, well yeah, I think notes are a hell
> of a good concept for my ideas. I mean, a bug report would be basically
> a collection of notes:
>   * the bug has been found at this commit ;
>   * the bug has been not-found at this commit ;
>   * this commit is a fix for that bug ;

That's my feeling too. "Commiting" bug information in the tree is only
half of a good idea. You want to be able to say, after the fact, "This
commit had bug XYZ". OTOH, the idea (followed by bugs everywhere) that
merging a branch would automatically close bugs fixed by this branch
is a really cool thing.

The kind of information you're mentionning above can be a great
starting point for "bisect". I can even imagine a kind of distributed
bisect, where several users could give their "bad commits" for the
same bug.

-- 
Matthieu
