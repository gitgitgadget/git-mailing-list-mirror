From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-gc --prune interferes cogito?
Date: Wed, 17 Oct 2007 17:38:41 +0200
Message-ID: <20071017153841.GL18279@machine.or.cz>
References: <1IiA7L-1AWmmW0@fwd35.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 17:39:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiAz7-0008Uw-Sp
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 17:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934612AbXJQPiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 11:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934578AbXJQPiq
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 11:38:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60801 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934164AbXJQPio (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 11:38:44 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 299405A45E; Wed, 17 Oct 2007 17:38:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1IiA7L-1AWmmW0@fwd35.aul.t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61383>

  Hi,

On Wed, Oct 17, 2007 at 04:43:27PM +0200, MichaelTiloDressel@t-online.de wrote:
> I'm using git-1.5.3.2 and cogito-0.18.1.
> 
> After I did a git-gc --prune cg-status didn't show my branches anymore.
> git-branch -a still showed the branches.
> I think that git-gc removed all files from .git/refs/heads/ except for
> origin. Git seams to be fine with the branches in 
>  .git/logs/refs/heads/. 
> 
> So should git-gc not be used together with cogito?

  Cogito doesn't support packed heads - I guess setting gc.packrefs to
false should fix the issue. Cogito should support packed tags, I guess;
I don't know if there's a way to make git-gc pack only tags.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
