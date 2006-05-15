From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Sun, 14 May 2006 19:34:08 -0700
Message-ID: <20060515023407.GA6855@localdomain>
References: <1147660345772-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 15 04:34:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSuV-0002jB-FN
	for gcvg-git@gmane.org; Mon, 15 May 2006 04:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWEOCeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 22:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWEOCeK
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 22:34:10 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45728 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751387AbWEOCeJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 22:34:09 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 20EF97DC005;
	Sun, 14 May 2006 19:34:08 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 14 May 2006 19:34:08 -0700
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1147660345772-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20010>

Eric Wong <normalperson@yhbt.net> wrote:
> This should make local mailing possible for machines without
> a connection to an SMTP server.
> 
> It'll default to using /usr/sbin/sendmail or /usr/lib/sendmail
> if no SMTP server is specified (the default).  If it can't find
> either of those paths, it'll fall back to connecting to an SMTP
> server on localhost.
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>

Also, Thanks to Martin Langhoff for bringing this up.

-- 
Eric Wong
