From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH for cvsps] Handle cvs repo with modules
Date: Thu, 15 Jun 2006 09:34:45 +0200
Message-ID: <20060615073445.GG7766@nowhere.earth>
References: <200606151249.17518.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Thu Jun 15 09:34:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqmN3-0003Rl-Gs
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 09:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWFOHe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 03:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWFOHe0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 03:34:26 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:5346 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751159AbWFOHe0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 03:34:26 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id F0DEA73131;
	Thu, 15 Jun 2006 09:34:24 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FqmNJ-0007WN-Jh; Thu, 15 Jun 2006 09:34:45 +0200
To: Alexander Litvinov <lan@academsoft.ru>
Content-Disposition: inline
In-Reply-To: <200606151249.17518.lan@academsoft.ru>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21883>

On Thu, Jun 15, 2006 at 12:49:17PM +0700, Alexander Litvinov wrote:
> Parse 'Working file' lines from cvs log output. This alow to work with cvs repos 
> with modules. To enable this you need to add --no-rlog to cvsps command line args.
> 
> This patch was made to import such repo into git. But git-cvsimport can't load such data.

Thanks, applied (with --whitespace=strip).

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
