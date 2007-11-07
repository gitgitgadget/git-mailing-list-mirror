From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Add Documentation/CodingStyle
Date: Wed, 07 Nov 2007 13:40:06 -0600
Message-ID: <1194464406.14978.9.camel@ld0161-tx32>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	 <20071106201809.GD6361@ins.uni-bonn.de>
	 <20071106202600.GH6361@ins.uni-bonn.de>
	 <7vtznzf5jb.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0711062317330.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 20:43:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpqoV-0008K1-0y
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 20:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbXKGTnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 14:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbXKGTnc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 14:43:32 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:36363 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbXKGTnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 14:43:31 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id lA7JeClN007967;
	Wed, 7 Nov 2007 12:40:15 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lA7Je6aI025522;
	Wed, 7 Nov 2007 13:40:11 -0600 (CST)
In-Reply-To: <Pine.LNX.4.64.0711062317330.4362@racer.site>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63846>

On Tue, 2007-11-06 at 17:17, Johannes Schindelin wrote:

> +
> + - Do not use curly brackets unnecessarily.  I.e.
> +
> +	if (bla) {
> +		x = 1;
> +	}

In my opinion, I think this is a bad guideline.

> +   is frowned upon.  A gray area is when the statement extends over a
> +   few lines, and/or you have a lengthy comment atop of it.

Or if it is some macro, or any number of vague problem areas.

Again, in my opinion, one should always take the safer
defensive programming tactic and always use braces.
Having them really never produces errors, while omitting
them is often error prone.

Yes, I know that is not a popular opinion by example,
but I'm still allowed to state it. :-)
Feel free to ignore me as well. :-)

jdl
