From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4 3/3] gitk: add the equivalent of diff --color-words
Date: Sat, 17 Apr 2010 16:35:57 +1000
Message-ID: <20100417063557.GB6681@brick.ozlabs.ibm.com>
References: <cover.1271260308.git.trast@student.ethz.ch>
 <bc720738f918f0523842b3839b7e611c453b5241.1271260308.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Apr 17 08:36:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O31dX-0003UF-Uc
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 08:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab0DQGgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 02:36:08 -0400
Received: from ozlabs.org ([203.10.76.45]:47651 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290Ab0DQGgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 02:36:04 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3F495B7CF7; Sat, 17 Apr 2010 16:36:02 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <bc720738f918f0523842b3839b7e611c453b5241.1271260308.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145117>

On Wed, Apr 14, 2010 at 05:59:08PM +0200, Thomas Rast wrote:

> Use the newly added 'diff --word-diff=porcelain' to teach gitk a
> color-words mode, with two different modes analogous to the
> --word-diff=plain and --word-diff=color settings.  These are selected
> by a dropdown box.
> 
> As an extra twist, automatically enable this word-diff support when
> the user mentions a word-diff related option on the command line.
> These options were previously ignored because they would break diff
> parsing.
> 
> Both of these features are only enabled if we have a version of git
> that supports --word-diff=porcelain, tentatively set to 1.7.2.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Looks fine.  The only nit I can see is that a "--word-diffoobar"
option would get treated as "--word-diff=plain" rather than giving an
error or being passed as-is to git log.

When does this need to go in, i.e. when is the git patch likely to go
in?

Paul.
