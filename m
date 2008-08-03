From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: remove PATH_INFO from $my_url and $my_uri
Date: Sun, 3 Aug 2008 21:10:45 +0200
Message-ID: <20080803191045.GZ32184@machine.or.cz>
References: <1217786545-30685-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 21:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPizj-0001xi-64
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 21:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbYHCTKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 15:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbYHCTKs
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 15:10:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40376 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbYHCTKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 15:10:47 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 40E43393A36E; Sun,  3 Aug 2008 21:10:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217786545-30685-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91261>

On Sun, Aug 03, 2008 at 08:02:25PM +0200, Giuseppe Bilotta wrote:
> This patch (combined with appropriate server configuration) allows usage
> of the gitweb CGI script as DirectoryIndex for the server root even when
> the pathinfo feature is enabled.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>

(In case anyone is wondering, on repo.or.cz I used to just override
$my_uri manually from the config file.)
