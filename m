From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4] Do not break git-gui messages into multiple lines.
Date: Wed, 4 Apr 2007 12:43:00 -0400
Message-ID: <20070404164300.GB5167@spearce.org>
References: <20070327103155.GR14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ8Zj-0006m9-Pd
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 18:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbXDDQnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 12:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbXDDQnI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 12:43:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48799 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbXDDQnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 12:43:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZ8ZU-0003Ur-9o; Wed, 04 Apr 2007 12:42:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB05F20FBAE; Wed,  4 Apr 2007 12:43:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070327103155.GR14837@codelabs.ru>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43756>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Many git-gui messages were broken into a multiple lines to make
> good paragraph width. Unfortunately in reality it breaks the paragraph
> width completely, because the dialog window width does not coincide
> with the paragraph width created by the current font.

Thanks.  I've applied this series, except for the option menu fix.
I'll test later on Windows to make sure there is no breakage there,
but I think it looks sane and will move to my master branch soon.
Right now they are in my pu branch in the git-gui.git repository:

  git://repo.or.cz/git-gui.git

Sorry it took so long, been busy...  ;-)

-- 
Shawn.
