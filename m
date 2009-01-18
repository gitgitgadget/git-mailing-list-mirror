From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH (topgit) 0/2] tg-patch: fix pagination
Date: Sun, 18 Jan 2009 18:04:20 +0300
Organization: St.Petersburg State University
Message-ID: <20090118150420.GB27522@roro3.zxlink>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz, martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 16:04:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZCP-0007pm-13
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758938AbZARPDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756604AbZARPDF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:03:05 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:2803 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbZARPDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:03:04 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id E0DB917B663; Sun, 18 Jan 2009 18:03:01 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3.zxlink>)
	id 1LOZCG-0007Y3-L0; Sun, 18 Jan 2009 18:04:20 +0300
Content-Disposition: inline
In-Reply-To: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106207>

On Tue, Jan 06, 2009 at 06:16:37PM +0300, Kirill Smelkov wrote:
> Kirill Smelkov (2):
>   Implement setup_pager just like in git
>   tg-patch: fix pagination
> 
>  tg-patch.sh |    3 +++
>  tg.sh       |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 0 deletions(-)

Petr, Martin,

What's the state of this patch series?

It fixes `tg patch`, and it seems we addressed all uglyness in
setup_pager, so is there any other reason not to merge this?

Thanks,
Kirill
