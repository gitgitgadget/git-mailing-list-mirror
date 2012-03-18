From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: use symbolic font names "sans" and "monospace"
 when available
Date: Mon, 19 Mar 2012 10:25:04 +1100
Message-ID: <20120318232503.GG26977@bloggs.ozlabs.ibm.com>
References: <20120308123011.GA4355@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Mark Hills <mark@pogo.org.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9PUf-00087s-64
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 00:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743Ab2CRX0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 19:26:12 -0400
Received: from ozlabs.org ([203.10.76.45]:33322 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640Ab2CRX0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 19:26:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 32C95B6FFE; Mon, 19 Mar 2012 10:26:09 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20120308123011.GA4355@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193401>

On Thu, Mar 08, 2012 at 06:30:11AM -0600, Jonathan Nieder wrote:
> The following only concerns systems using X and the client-side font
> rendering framework from freedesktop.org.  Windows and Mac OS X are
> not affected.
> 
> Starting with version 8.5, Tk uses freetype and fontconfig by default
> to render fonts on platforms that support it.  Gitk currently defaults
> to the font Helvetica for the interface and Courier for diffs, and
> both unfortunately look rather bad on screen in the default
> configuration on many Linux distros with anti-aliasing and poor
> hinting.
> 
> It is better to default to "sans" and "monospace", which are mapped by
> fontconfig to some appropriate font of the sysadmin and user's
> choosing (typically Bitstream Vera Sans and Mono).  The result looks
> more sensible and it makes gitk feel like a well-behaved software
> citizen since its fonts match other native apps.
> 
> This patch does not change the appearance of gitk for users that have
> already run it, since gitk uses the remembered UI and diff font names
> from ~/.gitk
> 
> Requested-by: Michael Biebl <biebl@debian.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, applied.

Paul.
