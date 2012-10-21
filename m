From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Fix crash when not using themed widgets
Date: Mon, 22 Oct 2012 09:22:34 +1100
Message-ID: <20121021222234.GB7407@bloggs.ozlabs.ibm.com>
References: <1349644874-22988-1-git-send-email-mk@acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 00:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ3y0-0005xR-Dt
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 00:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663Ab2JUWZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 18:25:45 -0400
Received: from ozlabs.org ([203.10.76.45]:43062 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932626Ab2JUWZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 18:25:44 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 432A32C008C; Mon, 22 Oct 2012 09:25:43 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1349644874-22988-1-git-send-email-mk@acc.umu.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208163>

On Sun, Oct 07, 2012 at 11:21:14PM +0200, Marcus Karlsson wrote:
> When configured not to use themed widgets gitk may crash on launch with
> a message that says that the image "bm-left disabled bm-left-gray"
> doesn't exist. This happens when the left and right arrow buttons are
> created.
> 
> The crash can be avoided by configuring the buttons differently
> depending on whether or not themed widgets are used. If themed widgets
> are not used then only set the images to bm-left and bm-right
> respectively, and keep the old behavior when themed widgets are used.
> 
> The previous behaviour was added in f062e50f to work around a bug in Tk
> on OS X where the disabled state did not display properly. The buttons
> may still not display correctly, however the workaround added in
> f062e50f will still apply if gitk is used with themed widgets.
> 
> Make gitk not crash on launch when not using themed widgets.
> 
> Signed-off-by: Marcus Karlsson <mk@acc.umu.se>

Thanks, applied.

Paul.
