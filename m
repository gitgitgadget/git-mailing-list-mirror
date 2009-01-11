From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/4] word diff: comments, preparations for regex
 customization
Date: Sun, 11 Jan 2009 20:49:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901111707110.3586@pacific.mpi-cbg.de>
References: <cover.1231669012.git.trast@student.ethz.ch> <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 11 20:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6K5-0001W0-KD
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 20:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbZAKTst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 14:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbZAKTst
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 14:48:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:42046 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752081AbZAKTss (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 14:48:48 -0500
Received: (qmail invoked by alias); 11 Jan 2009 19:48:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 11 Jan 2009 20:48:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2zvRyYPn2xoe9l+2jDNWnRI8Xd5w+kU50b4zkFY
	drfdnRkjHP1fYG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105204>

Hi,

On Sun, 11 Jan 2009, Thomas Rast wrote:


> +/* unused right now */
> +enum diff_word_boundaries {
> +	DIFF_WORD_UNDEF,
> +	DIFF_WORD_BODY,
> +	DIFF_WORD_END,
> +	DIFF_WORD_SPACE,
> +	DIFF_WORD_SKIP
> +};
> +

Just to illustrate why I reacted so harshly to this patch series:  this 
change is utterly useless.

You do not use the word boundaries at all throughout the complete patch.  
This would have been the only way you could have possibly illustrated how 
the enum is to be used at all, given that you did not document what the 
enum should do eventually.

With such a patch that leaves me as clueless as to the way you want to fix 
the issues as before, I regret having spent the time to look at it at all.

What you _should_ have done:

- _not_ introduce the regex.  That is not what the first patch should be 
  about.

- _use_ the enum for the existing functionality.

- _explain_ what the different values of the enum are about.

- _say_ what the enum pointer points at (is it a single value?  an array?  
  if it is an array, is it per letter?  per word?)

If you are honest, you'll admit that this patch would leave you puzzled 
_yourself_, 6 months from now.

FWIW I think I have a better patch series, to be sent in a few minutes.

Ciao,
Dscho
