From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Do not rename read-only files during a push
Date: Fri, 3 Oct 2008 12:20:43 +0200
Message-ID: <20081003102043.GR10544@machine.or.cz>
References: <1222104029-28366-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 12:22:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlhnZ-0005f9-Gl
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 12:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbYJCKUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 06:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYJCKUq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 06:20:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56734 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbYJCKUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 06:20:45 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id EDCD9393A2E4; Fri,  3 Oct 2008 12:20:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222104029-28366-1-git-send-email-pasky@suse.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97409>

On Mon, Sep 22, 2008 at 07:20:29PM +0200, Petr Baudis wrote:
> Win32 does not allow renaming read-only files (at least on a Samba
> share), making push into a local directory to fail. Thus, defer
> the chmod() call in index-pack.c:final() only after
> move_temp_to_file() was called.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>

Ping?

				Petr "Pasky" Baudis
