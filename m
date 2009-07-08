From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Too many 'stat' calls by git-status on Windows
Date: Wed, 08 Jul 2009 20:49:45 +0100
Message-ID: <4A54F859.2080407@ramsay1.demon.co.uk>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 21:51:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOdAv-0008Le-Ej
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 21:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975AbZGHTvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 15:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756360AbZGHTvM
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 15:51:12 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:44788 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756187AbZGHTvL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 15:51:11 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1MOdAc-0000qr-WN; Wed, 08 Jul 2009 19:51:10 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20090707000500.GA5594@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122915>

Dmitry Potapov wrote:
[snip]
> It appears that the second 'stat' for files on Windows caused by lack
> of d_type in dirent. When I recompiled the Linux version with
> NO_D_TYPE_IN_DIRENT = YesPlease, I got the same result for files.

I believe that the next version of cygwin, currently in beta, will have
the d_type field in dirent.  I know that's not much help now...
(I don't think it would be a good idea to try and reto-fit d_type,
ala compat/mingw.[ch], since cygwin does some funky stuff behind the
scenes).

Nice profiling BTW.

ATB,
Ramsay Jones
