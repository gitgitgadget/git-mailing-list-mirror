From: Frank Lichtenheld <djpig@debian.org>
Subject: Re: Bug#476076: gitweb fails with pathinfo and project with ++ in the name
Date: Sun, 20 Apr 2008 17:53:18 +0200
Message-ID: <20080420155318.GV6024@mail-vs.djpig.de>
References: <20080420144654.GA11479@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>, 476076@bugs.debian.org
X-From: git-owner@vger.kernel.org Sun Apr 20 17:54:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnbrs-0001Ht-8q
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 17:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbYDTPxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 11:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbYDTPxa
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 11:53:30 -0400
Received: from pauli.djpig.de ([78.46.38.139]:36386 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbYDTPxa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 11:53:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 1F48190075;
	Sun, 20 Apr 2008 17:53:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OyNCVhC4fkde; Sun, 20 Apr 2008 17:53:19 +0200 (CEST)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 89D1D9006E;
	Sun, 20 Apr 2008 17:53:19 +0200 (CEST)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1Jnbqw-0000lJ-LU; Sun, 20 Apr 2008 17:53:19 +0200
Content-Disposition: inline
In-Reply-To: <20080420144654.GA11479@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79960>

On Sun, Apr 20, 2008 at 04:46:54PM +0200, martin f krafft wrote:
> The bug seems to be in CGI.pm, and I now wonder what to do about it.

CGI->path_info in etch's version is broken, you need either use a newer
CGI.pm or $ENV{PATH_INFO} directly.

Gruesse,
-- 
Frank Lichtenheld <djpig@debian.org>
www: http://www.djpig.de/
