From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from
	the git configuration
Date: Thu, 5 Feb 2009 07:38:52 -0800
Message-ID: <20090205153852.GF26880@spearce.org>
References: <498AC2F3.1010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 16:40:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV6LB-0003BC-Pd
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 16:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbZBEPiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 10:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758229AbZBEPiy
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 10:38:54 -0500
Received: from george.spearce.org ([209.20.77.23]:40046 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758219AbZBEPix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 10:38:53 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8724F38210; Thu,  5 Feb 2009 15:38:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <498AC2F3.1010802@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108571>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> The author/commiter name and email are retrieved from the system configuration
> and the local and global git configurations.
> 
> When the name is not available, propose one default by using the system user name.
> 
> When the email is not available, propose one default by concatenating the
> user name and the host name.
> 
> The author name and email are used as default value in the author field
> while committing with the GUI.
> 
> Fix issue 47 (field Author don't fill)
> 
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>

Applied, thanks.

-- 
Shawn.
