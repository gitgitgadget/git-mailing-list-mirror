From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Is cogito really this inefficient
Date: Thu, 14 Jul 2005 08:38:31 +0100
Message-ID: <20050714083831.B26322@flint.arm.linux.org.uk>
References: <20050713135052.C6791@flint.arm.linux.org.uk> <pan.2005.07.13.16.51.28.520681@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 09:39:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsyJa-0007XR-IH
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 09:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVGNHjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 03:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVGNHjL
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 03:39:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57106 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262944AbVGNHif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 03:38:35 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DsyIi-0005Z0-GL; Thu, 14 Jul 2005 08:38:32 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DsyIh-0006xT-BV; Thu, 14 Jul 2005 08:38:31 +0100
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <pan.2005.07.13.16.51.28.520681@smurf.noris.de>; from smurf@smurf.noris.de on Wed, Jul 13, 2005 at 06:51:30PM +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2005 at 06:51:30PM +0200, Matthias Urlichs wrote:
> Hi, Russell King wrote:
> 
> > This says it all.  1min 22secs to generate a patch from a locally
> > modified but uncommitted file.
> 
> I only get that when the index is out-of-date WRT the file modification
> dates, so cg-diff has to examine every file.
> 
> The good news is that the index is being updated as it finds that the
> files are in sync, so expect this to be significantly faster the next time
> around.

It isn't.  First time it was 1min11, second time _immediately_ after
it was 1min22.  See my reply to Linus.

Oddly, show-diff seemed to be a lot more efficient in previous git
revisions.

-- 
Russell King
