From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: git svn --add-author-from implies --use-log-author
Date: Tue, 24 Jun 2008 09:37:07 +0200
Message-ID: <20080624073707.GA6495@frsk.net>
References: <20080620113147.GC27940@frsk.net> <485BB134.9080203@mircea.bardac.net> <32541b130806231312l679aba31ra3daac2bb634cf1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mircea Bardac <dev@mircea.bardac.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 09:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB37G-00005q-Nz
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 09:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYFXHho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 03:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755618AbYFXHhY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 03:37:24 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:42720 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbYFXHhN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 03:37:13 -0400
Received: from asterix.samfundet.no ([2001:700:300:1800::f] ident=postfix)
	by cassarossa.samfundet.no with esmtp (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1KB35Q-0005mm-3G; Tue, 24 Jun 2008 09:37:08 +0200
Received: by asterix.samfundet.no (Postfix, from userid 1000)
	id E9047A6032A; Tue, 24 Jun 2008 09:37:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130806231312l679aba31ra3daac2bb634cf1b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86002>

On Mon, Jun 23, 2008 at 04:12:37PM -0400, Avery Pennarun wrote:

> They are separate options; --add-author-from affects dcommit (but not
> fetch or clone), while --use-log-author affects fetch and clone (but
> not dcommit).  They do different things, and I can imagine wanting one
> and not the other, so having one imply the other isn't very safe.

No, I agree implying it isn't safe. The need for implying --use-log-author
when doing --add-author-from might just be me being to lazy to remember both
flags. :-)

> You can set config options for these, however:
> 
> git config svn.addAuthorFrom true
> git config svn.useLogAuthor true
> 
> (I actually use "git config --global" to set these on my system so
> they apply to all my git-svn repositories.)

Hm, I did not know about these config options. Are they documented somewhere?

- F

-- 
Regards,
Fredrik Skolmli
