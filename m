From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Thu, 22 Sep 2005 02:54:55 +0200
Message-ID: <20050922005455.GA93041@dspnet.fr.eu.org>
References: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org> <7vu0genlc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509211501130.2553@g5.osdl.org> <20050921.172849.103555057.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 02:56:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIFMp-00031c-FE
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 02:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVIVAzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 20:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVIVAzG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 20:55:06 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:2310 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S965198AbVIVAzF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 20:55:05 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id ED636A3722; Thu, 22 Sep 2005 02:54:55 +0200 (CEST)
To: "David S. Miller" <davem@davemloft.net>
Content-Disposition: inline
In-Reply-To: <20050921.172849.103555057.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9090>

On Wed, Sep 21, 2005 at 05:28:49PM -0700, David S. Miller wrote:
> You know, I personally was unaware that this was supported until now.
> I have been always reverting local debugging changes in order to merge
> other people's work in, then reapply the debugging changes afterwards.

Why don't you commit the debugging changes, go back one step in the
tree (reverting them through git in practice), merge other's people
work then merge the debugging changes back in ?  You never know when
the debug changes will be useful again, so it's nice to have them in
your private tree, and this method makes it reasonably automatic.

  OG.
