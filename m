From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GIT-GUI PATCH] Correctly launch gitk for branch whose name
	matches a local file
Date: Sat, 23 Jan 2010 14:41:31 -0800
Message-ID: <20100123224131.GD12679@spearce.org>
References: <20100121121848.BE37D2FC47@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:41:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYofi-0000MT-4e
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536Ab0AWWlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401Ab0AWWle
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:41:34 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:40375 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab0AWWle (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:41:34 -0500
Received: by iwn16 with SMTP id 16so1115813iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 14:41:34 -0800 (PST)
Received: by 10.231.157.83 with SMTP id a19mr1097245ibx.41.1264286493906;
        Sat, 23 Jan 2010 14:41:33 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm3256859iwn.9.2010.01.23.14.41.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 14:41:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100121121848.BE37D2FC47@perkele>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137871>

Peter Krefting <peter@softwolves.pp.se> wrote:
> When trying to run gitk on a branch name whose name matches a local file,
> it will toss an error saying that the name is ambiguous. Adding a pair
> of dashes will make gitk parse the options to the left of it as branch
> names. Since wish eats the first pair of dashes we throw at it, we need
> to add a second one to ensure they get through.
> 
> Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
> ---
>  git-gui.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks, applied.
 
-- 
Shawn.
