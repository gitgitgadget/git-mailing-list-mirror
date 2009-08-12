From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Limit git-gui to display a maximum number of files
Date: Wed, 12 Aug 2009 07:43:45 -0700
Message-ID: <20090812144345.GC1033@spearce.org>
References: <4A4A77A6.1020905@lawrence.edu> <20090810153859.GT1033@spearce.org> <4A81B738.7090507@zwell.net> <20090811202927.GZ1033@spearce.org> <4A81BD58.8070300@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, raa.lkml@gmail.com
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 16:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbF3S-0007kg-Sz
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 16:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbZHLOno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 10:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbZHLOno
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 10:43:44 -0400
Received: from george.spearce.org ([209.20.77.23]:53738 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbZHLOno (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 10:43:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7A311381FD; Wed, 12 Aug 2009 14:43:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A81BD58.8070300@zwell.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125703>

Dan Zwell <dzwell@zwell.net> wrote:
> When there is a large number of new or modified files,
> "display_all_files" takes a long time, and git-gui appears to
> hang. This change limits the number of files that are displayed.
> This limit can be set as gui.maxfilesdisplayed, and is
> 5000 by default.
>
> A warning is shown when the list of files is truncated.

Thanks, applied.

-- 
Shawn.
