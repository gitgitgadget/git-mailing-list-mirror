From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: Re: [PATCH] Don't allow newlines to occur in $Id:$ collapse
Date: Fri, 25 May 2007 20:10:58 +0530
Message-ID: <20070525144058.GB5226@always.joy.eth.net>
References: <200705251412.06196.andyparkins@gmail.com> <200705251413.42389.andyparkins@gmail.com> <20070525132800.GH6667@always.joy.eth.net> <200705251451.00999.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 16:41:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hraye-0008E4-K0
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbXEYOlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbXEYOlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:41:09 -0400
Received: from rune.pobox.com ([208.210.124.79]:54622 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbXEYOlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:41:08 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 6EEE0F0D2F;
	Fri, 25 May 2007 10:41:27 -0400 (EDT)
Received: from emit.nirmalvihar.info (house.nirmalvihar.info [61.17.90.7])
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AC414F08B5;
	Fri, 25 May 2007 10:41:24 -0400 (EDT)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation); Fri, 25 May 2007 20:10:58 +0530
Content-Disposition: inline
In-Reply-To: <200705251451.00999.andyparkins@gmail.com>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48382>

On Fri, May 25, 2007 at 02:50:53PM +0100, Andy Parkins wrote:
> One could even argue that it's not actually an error, if we define keywords to 
> be such that they are not allowed to contain newlines, then the fact that 
> someone has written "$Id:" in their file, with no closing "$" just means that 
> it's not a keyword; and like every other non-keyword bit of data in the file 
> it should be left untouched.

Ah, so the original patch, before I started kibitzing, was correct.

Sorry for the noise.
