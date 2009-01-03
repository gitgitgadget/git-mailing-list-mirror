From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Allow non-ASCII ref names when writing packs
Date: Sat, 3 Jan 2009 14:11:38 -0800
Message-ID: <20090103221138.GB12438@spearce.org>
References: <1231020275-7637-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 23:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJEjr-0002zn-BJ
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 23:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759968AbZACWLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 17:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759886AbZACWLk
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 17:11:40 -0500
Received: from george.spearce.org ([209.20.77.23]:36083 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822AbZACWLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 17:11:39 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3398638200; Sat,  3 Jan 2009 22:11:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1231020275-7637-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104482>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  .../org/spearce/jgit/transport/PacketLineOut.java  |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Disovered this bug when trying to clone a local repo with some "funny" 
> ref names. C Git handles them so jgit should too.

Oy.  Good catch.
 
-- 
Shawn.
