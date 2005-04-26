From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 06:40:17 +0100
Message-ID: <20050426054017.GS13052@parcelfarce.linux.theplanet.co.uk>
References: <426DCA75.901@pobox.com> <Pine.LNX.4.21.0504260103050.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>, pasky@ucw.cz, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 07:35:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQIiy-0000db-V9
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 07:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVDZFkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 01:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVDZFkK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 01:40:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65223 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261205AbVDZFkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 01:40:06 -0400
Received: from viro by parcelfarce.linux.theplanet.co.uk with local (Exim 4.43)
	id 1DQInx-0000iS-Fs; Tue, 26 Apr 2005 06:40:17 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504260103050.30848-100000@iabervon.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > So, it still complains about commit-id
> 
> In this case, it would complain about .git/HEAD even if it found
> commit-id. The right solution is probably to suppress that part if there's
> no .git/HEAD.

The right thing is to stop assuming that everyone has . in their $PATH,
to start with...
