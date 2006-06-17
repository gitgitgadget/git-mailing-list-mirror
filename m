From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH for cvsps] Handle cvs repo with modules
Date: Sat, 17 Jun 2006 23:33:27 +0200
Message-ID: <20060617213327.GW1297@nowhere.earth>
References: <200606151249.17518.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sat Jun 17 23:33:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FriPg-0000ji-42
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 23:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWFQVdA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 17:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWFQVdA
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 17:33:00 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:48361 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750941AbWFQVc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 17:32:59 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3AD079AA82;
	Sat, 17 Jun 2006 23:32:56 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FriQ3-0002l0-KK; Sat, 17 Jun 2006 23:33:27 +0200
To: Alexander Litvinov <lan@academsoft.ru>
Content-Disposition: inline
In-Reply-To: <200606151249.17518.lan@academsoft.ru>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22033>

On Thu, Jun 15, 2006 at 12:49:17PM +0700, Alexander Litvinov wrote:
> Parse 'Working file' lines from cvs log output. This alow to work
> with cvs repos with modules. To enable this you need to add
> --no-rlog to cvsps command line args.  This patch was made to import
> such repo into git. But git-cvsimport can't load such data.

Just forgot to mention it, but this patch was applied to master.

Thanks,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
