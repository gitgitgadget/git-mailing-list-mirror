From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Fri, 27 Apr 2012 08:21:18 +0000
Message-ID: <20120427082118.GA7257@dcvr.yhbt.net>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:21:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNgQk-00064M-DN
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 10:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759783Ab2D0IVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 04:21:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44809 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759546Ab2D0IVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 04:21:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087781F449;
	Fri, 27 Apr 2012 08:21:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196453>

Matthijs Kooijman <matthijs@stdin.nl> wrote:
> On Linux, this makes authentication using passwords from gnome-keyring
> and kwallet work (only the former was tested). On Mac OS X, this allows
> using the OS X Keychain.

Thanks, this looks good.  Can you add a Signed-off-by? (you can just
reply here and I'll add it to the commit message when pushing.

Otherwise, consider this Acked-by: Eric Wong <normalperson@yhbt.net>

> +	# earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
> +	# this function
> +	if ($SVN::Core::VERSION gt '1.6.12') {

Thank you for documenting this segfault, btw.
