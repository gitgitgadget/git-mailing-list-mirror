From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v4 2/2] push: Don't push a repository with unpushed
	submodules
Date: Thu, 18 Aug 2011 21:21:58 +0200
Message-ID: <20110818192157.GA10598@book.hvoigt.net>
References: <1313312613-2647-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 21:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8AN-0002xY-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 21:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab1HRTWC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 15:22:02 -0400
Received: from darksea.de ([83.133.111.250]:39930 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753423Ab1HRTWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 15:22:00 -0400
Received: (qmail 19419 invoked from network); 18 Aug 2011 21:21:58 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 18 Aug 2011 21:21:58 +0200
Content-Disposition: inline
In-Reply-To: <1313312613-2647-1-git-send-email-iveqy@iveqy.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179615>

Hi Junio,

On Sun, Aug 14, 2011 at 11:03:33AM +0200, Fredrik Gustafsson wrote:
> When working with submodules it is easy to forget to push a
> submodule to the server but pushing a super-project that
> contains a commit for that submodule. The result is that the
> superproject points at a submodule commit that is not available
> on the server.

Since I do not see thisi in pu maybe you missed this? There was a series
containing the same patch send before which Jens asked to ignore but
this was the one which was meant to be included.

Cheers Heiko
