From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 0/2] gitk --color-words
Date: Mon, 5 Apr 2010 16:40:18 +1000
Message-ID: <20100405064018.GA4471@brick.ozlabs.ibm.com>
References: <cover.1269996525.git.trast@student.ethz.ch>
 <cover.1270317502.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 05 08:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyfzA-0006cP-Pp
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 08:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab0DEGkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 02:40:32 -0400
Received: from ozlabs.org ([203.10.76.45]:41517 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab0DEGkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 02:40:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 47421B7CF0; Mon,  5 Apr 2010 16:40:30 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <cover.1270317502.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143973>

On Sat, Apr 03, 2010 at 08:06:18PM +0200, Thomas Rast wrote:

> I wasn't really sure about the last point -- this makes things a bit
> complicated since Paul will have to apply 2/2, and Junio will have to
> take care to only pull from Paul once 1/2 is in.

You mean that the patch will mean that gitk will break if the
underlying git isn't new enough?  I have been careful to avoid that
sort of dependency as far as possible.  Have a look at how this is
handled for the --textconv and --submodule options in [getblobdiffs]
and do something similar for --color-words, please.

Paul.
