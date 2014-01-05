From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git fetch doesn't ignore funny refs
Date: Sun, 5 Jan 2014 02:22:51 +0100
Message-ID: <20140105012251.GA12969@book-mint>
References: <52B04515.8020609@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lorenzo Keller <lkeller@marvell.com>
X-From: git-owner@vger.kernel.org Sun Jan 05 02:23:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzcQh-0005yc-H1
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 02:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbaAEBW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 20:22:58 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:38816 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaAEBW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 20:22:57 -0500
Received: from [77.20.146.74] (helo=book-mint)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VzcQa-0000vt-5g; Sun, 05 Jan 2014 02:22:56 +0100
Content-Disposition: inline
In-Reply-To: <52B04515.8020609@marvell.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239954>

On Tue, Dec 17, 2013 at 01:35:33PM +0100, Lorenzo Keller wrote:
> A check as this one:
> 
> if (check_refname_format(ref->name, 0))
>    continue;
> 
> fixes the problem for me.
> 
> I report here bug and fix in the hope it can be reviewed and integrated
> in future git releases.

Since it seems you already have a fix: How about sending a proper patch
(possibly you want to extend this with a warning message) so people can
discuss and integrate your fix here? See Documentation/SubmittingPatches
for further information.

Cheers Heiko
