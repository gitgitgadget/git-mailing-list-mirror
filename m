From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Work around broken ln on solaris as used in t8006
Date: Sun, 20 Mar 2011 21:10:24 -0400
Message-ID: <1300669724-sup-450@pinkfloyd.chass.utoronto.ca>
References: <1300665586-24512-1-git-send-email-bwalton@artsci.utoronto.ca> <7vd3lluvze.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 02:10:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Tdf-00069n-Tw
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 02:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab1CUBKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 21:10:25 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:50975 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab1CUBKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 21:10:24 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:37602 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Q1TdY-0000sN-5M; Sun, 20 Mar 2011 21:10:24 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Q1TdY-0006qA-4K; Sun, 20 Mar 2011 21:10:24 -0400
In-reply-to: <7vd3lluvze.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169544>

Excerpts from Junio C Hamano's message of Sun Mar 20 21:02:13 -0400 2011:

Hi Junio,

> > This patch uses changes the first check in the test to rm the symlink
> > and then create the new symlink using only -s.
> 
> s/uses //; I think.

Yes, I caught that right after send.  A follow up corrected it, but
I'll resubmit taking your feedback below into account.

> It is curious why "rm symlink.bin" is not inside the
> test-have-prereq part, iow, immediately before the problematic "ln
> -s", where it logically belongs to, though.  What does the updated
> code do on systems without symbolic link support?

I think you're right about this.  They should be logically grouped.
I'll send an update shortly.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
