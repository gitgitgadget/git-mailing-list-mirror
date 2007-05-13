From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: RFD Use git for off-site backups
Date: Sun, 13 May 2007 13:18:41 +0200
Message-ID: <20070513111841.GA24392@cip.informatik.uni-erlangen.de>
References: <20070513093417.GA18546@cip.informatik.uni-erlangen.de> <Pine.LNX.4.64.0705131251370.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 13 13:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnC6A-0003bj-DG
	for gcvg-git@gmane.org; Sun, 13 May 2007 13:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbXEMLSm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 07:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757358AbXEMLSm
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 07:18:42 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:35499 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757214AbXEMLSm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 07:18:42 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 7F0CD3F376; Sun, 13 May 2007 13:18:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705131251370.6410@racer.site>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47141>

Hello,

> I think that this setup (have objects remotely) will kill performance
> pretty quickly. You have to compare to other blobs in order to find
> reasonable deltas...

so true. I thought about that myself just after I sent the eMail.

> There has been talk about pre-commit scripts which put this
> information into a file, and a post-checkout script to resurrect these
> metadata, but I haven't seen functional versions of these scripts yet.

I thought there is a way to add information without loosing compability
with current git versions. But maybe I am just mistaken.

        Thomas
