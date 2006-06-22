From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 22 Jun 2006 12:00:25 +0200
Message-ID: <20060622100024.G7f491d4a@leonov.stosberg.net>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com> <20060621130535.G2b34d382@leonov.stosberg.net> <e7bhlf$5j2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 12:01:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtLzn-0007Jq-ER
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 12:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWFVKA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 06:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWFVKA7
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 06:00:59 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:20973 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1161025AbWFVKA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 06:00:58 -0400
Received: from leonov.stosberg.net (p213.54.83.34.tisdip.tiscali.de [213.54.83.34])
	by ncs.stosberg.net (Postfix) with ESMTP id 19118590C04E;
	Thu, 22 Jun 2006 12:00:32 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 51F7510E79B; Thu, 22 Jun 2006 12:00:25 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e7bhlf$5j2$1@sea.gmane.org>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22320>

Jakub Narebski wrote:

> So now you have extra git redirector being spawned, instead of extra shell
> being spawned. 

Most of the commands that Gitweb uses are built-ins, so there
shouldn't be any extra overhead by calling "git command" instead of
"git-command".  If I haven't missed one, git-annotate is the only one
which is not a built-in.

Regards,
Dennis
