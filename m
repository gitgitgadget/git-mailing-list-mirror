From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Sun, 11 Feb 2007 21:48:39 -0800
Message-ID: <7vvei89b9k.fsf@assigned-by-dhcp.cox.net>
References: <20070211230204.GE31488@spearce.org>
	<20070212054018.GC28231@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Feb 12 06:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGU3t-0005iX-HM
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 06:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009AbXBLFsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 00:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933006AbXBLFsm
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 00:48:42 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:45053 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933009AbXBLFsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 00:48:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212054841.JTDI1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 00:48:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NVog1W0021kojtg0000000; Mon, 12 Feb 2007 00:48:40 -0500
In-Reply-To: <20070212054018.GC28231@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 12 Feb 2007 07:40:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39369>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Actually, -p<n> option to git-am is also useful for piping
> patches to git-am directly from mail: sometimes people would generate
> a patch by hand and this results in patches incorrect -p level.

You also would need negative -p option to deal with it as well.
Think of getting "diff a/git-add.txt b/git-add.txt" and wanting
to apply it to Documentation/git-add.txt.

 
