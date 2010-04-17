From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4 2/3] gitk: do not parse "  >" context as submodule
 change
Date: Sat, 17 Apr 2010 16:33:20 +1000
Message-ID: <20100417063320.GA6681@brick.ozlabs.ibm.com>
References: <cover.1271260308.git.trast@student.ethz.ch>
 <5531510bfb94997f729a894a0b5a3158177a9add.1271260308.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Apr 17 08:36:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O31dX-0003UF-EJ
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 08:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0DQGgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 02:36:06 -0400
Received: from ozlabs.org ([203.10.76.45]:47650 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab0DQGgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 02:36:04 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3B9B6B7D0E; Sat, 17 Apr 2010 16:36:02 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <5531510bfb94997f729a894a0b5a3158177a9add.1271260308.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145116>

On Wed, Apr 14, 2010 at 05:59:07PM +0200, Thomas Rast wrote:

> Since 5c838d2 (gitk: Use the --submodule option for displaying diffs
> when available, 2009-10-28) gitk erroneously matches "  >" and "  <"
> at the beginning of a line in the submodule code even if we're in the
> diff text section and the lines should be treated as context.
> 
> Fix by (ab)using the $diffinhdr variable also in the 'Submodule...'
> case, and move the "  >"/"  <" specific code inside the $diffinhdr
> test.  The existing code will set $diffinhdr to 0 when it hits a
> "+++", so that it is always 0 when we can hit a context line.

Looks good, but there's no Signed-off-by?

Paul.
