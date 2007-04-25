From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: using stgit/guilt for public branches
Date: Wed, 25 Apr 2007 15:20:49 +0300
Message-ID: <20070425122048.GD1624@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Wed Apr 25 14:20:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HggUO-0005l2-Az
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 14:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbXDYMUr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 08:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965397AbXDYMUr
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 08:20:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:55950 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965336AbXDYMUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 08:20:46 -0400
Received: by ug-out-1314.google.com with SMTP id 44so404497uga
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 05:20:45 -0700 (PDT)
Received: by 10.67.74.7 with SMTP id b7mr1351609ugl.1177503645400;
        Wed, 25 Apr 2007 05:20:45 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id 53sm3180371ugn.2007.04.25.05.20.44;
        Wed, 25 Apr 2007 05:20:44 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45519>

Hi!
On git.openfabrics.org we use git to manage all code for our OFED distribution.
For our kernel code we basically started with 2.6.20, and add some patches,
which we currently keep separate from upstream kernel source - this makes
it possible to update from upstream and extract the patches to post
them for upstream inclusion easily.

On the surface, it looks like using stg or guilt would be a good idea for us,
however multiple people need to collaborate on the patch series.

I am concerned that publishing a git branch managed by stg/guilt
would present problems: it seems that every time patches are re-ordered,
a patch is re-written or removed, or we update from upstream,
everyone who pulls the tree branch will have a hard-to-resolve conflict.

Is that really a problem? If so, would it be possible to work around this somehow?

Thanks,

-- 
MST
