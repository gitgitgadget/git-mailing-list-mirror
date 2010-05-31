From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH GSoC 1/4] gitweb: Move static files into seperate
 subdirectory
Date: Mon, 31 May 2010 23:36:07 +0200
Message-ID: <20100531213607.GQ3563@machine.or.cz>
References: <1275027952-5057-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jnareb@gmail.com
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 23:36:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJCf3-0004Lo-4N
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 23:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab0EaVgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 17:36:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35842 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022Ab0EaVgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 17:36:09 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2577A862092; Mon, 31 May 2010 23:36:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275027952-5057-1-git-send-email-pavan.sss1991@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148055>

On Fri, May 28, 2010 at 11:55:49AM +0530, Pavan Kumar Sunkara wrote:
> Create a new subdirectory called 'static' in gitweb/, and move
> all static files required by gitweb.cgi when running, which means
> styles, images and Javascript code. This should make gitweb more
> readable and easier to maintain.
> 
> Update t/gitweb-lib.sh to reflect this change.The install-gitweb
> now also include moving of static files into 'static' subdirectory
> in target directory: update Makefile, gitweb's INSTALL, README and
> Makefile accordingly.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Petr Baudis <pasky@ucw.cz>
> Acked-by: Jakub Narebski <jnareb@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>
