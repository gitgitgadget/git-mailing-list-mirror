From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/6] Factorize shortening of notes refname for display.
Date: Sun, 19 Jun 2011 23:25:00 +0200
Message-ID: <201106192325.00667.johan@herland.net>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
 <1308431208-13353-3-git-send-email-ydirson@free.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:07:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQ9k-0008NH-2A
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab1FSWHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:07:43 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59476 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806Ab1FSWHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:07:41 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200I2O5GQ0810@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 00:07:38 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 43A031799095_DFE732AB	for <git@vger.kernel.org>; Sun,
 19 Jun 2011 22:07:38 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 199A7179632D_DFE7329F	for <git@vger.kernel.org>; Sun,
 19 Jun 2011 22:07:37 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200CIB5GO4R00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 00:07:37 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <1308431208-13353-3-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176031>

On Saturday 18 June 2011, Yann Dirson wrote:
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> ---
>  notes.c |   24 ++++++++++++++++--------
>  notes.h |    7 +++++++
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> [...]
> 
>  /*
> + * Return a short name for a notes ref, suitable for display to the user.
> + *
> + * No copy is done, the return value is a pointer into the original string.
> + */
> +const char *notes_ref_shortname(const char *ref);
> +
> +/*

Please include in the documentation what a NULL return means.

Otherwise the patch looks OK.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
