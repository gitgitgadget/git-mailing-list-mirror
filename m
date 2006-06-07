From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Off-by-one error in get_path_prefix(), found by
	Valgrind
Date: Wed, 07 Jun 2006 14:33:24 -0400
Message-ID: <1149705204.11931.3.camel@dv>
References: <20060607170140.13372.64613.stgit@dv.roinet.com>
	 <20060607180543.GA26638@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 20:33:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo2qR-0004QR-3j
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 20:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWFGSd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 14:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWFGSd2
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 14:33:28 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:56456 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751183AbWFGSd1
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 14:33:27 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fo2qN-0008UL-1M
	for git@vger.kernel.org; Wed, 07 Jun 2006 14:33:27 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fo2qK-00071r-Mo; Wed, 07 Jun 2006 14:33:24 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060607180543.GA26638@lsrfire.ath.cx>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21449>

On Wed, 2006-06-07 at 20:05 +0200, Rene Scharfe wrote:
> Argh, yes.  Thanks, Pavel!

Actually, thanks to Julian Seward for Valgrind.

>   However, the other branch is incorrect, too:
> accessing path->buf[path->len] is wrong, even if it's within the buffer.
> In order to use a length variable to point to the end of some string we
> need to subtract 1. *sigh*  So, how about this one instead?

Fine with me.  Thank you for noticing!

-- 
Regards,
Pavel Roskin
