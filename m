From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] Use the topological order when exporting
	explicitly listed branches.
Date: Thu, 20 Nov 2008 11:20:05 +0100
Message-ID: <20081120102005.GB10491@machine.or.cz>
References: <1227173902-21180-1-git-send-email-madduck@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Niko Tyni <ntyni@debian.org>
To: "martin f. krafft" <madduck@debian.org>
X-From: git-owner@vger.kernel.org Thu Nov 20 11:21:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L36f6-0000tX-9J
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 11:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbYKTKUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 05:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYKTKUI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 05:20:08 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59190 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbYKTKUI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 05:20:08 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 62CBE393984F; Thu, 20 Nov 2008 11:20:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227173902-21180-1-git-send-email-madduck@debian.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101399>

On Thu, Nov 20, 2008 at 10:38:22AM +0100, martin f. krafft wrote:
> From: Niko Tyni <ntyni@debian.org>
> 
> When exporting explicitly listed branches (tg export -b), the branch
> dependencies were not taken into account.
> 
> Signed-off-by: martin f. krafft <madduck@debian.org>
> Tested-by: martin f. krafft <madduck@debian.org>
> ---
> Arguably, lines 178:189 need to be refactored due to the code duplication, but
> the patch does what it should for now.

The point of -b is to export only the specified branches, assuming you
already exported the dependencies before. If you just want to export a
branch with all its dependencies, why not just switch to it and call
plain tg export?

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
