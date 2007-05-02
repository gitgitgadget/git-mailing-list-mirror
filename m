From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD/PATCH] Implement pack.compression and pack-objects --compression=N
Date: Wed, 02 May 2007 11:40:08 -0700
Message-ID: <7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
References: <463802ED.1080200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 20:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjJkQ-0008TH-1n
	for gcvg-git@gmane.org; Wed, 02 May 2007 20:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767137AbXEBSkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767181AbXEBSkM
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 14:40:12 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55055 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767137AbXEBSkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 14:40:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070502184009.QCGI1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 2 May 2007 14:40:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uJg91W0051kojtg0000000; Wed, 02 May 2007 14:40:09 -0400
In-Reply-To: <463802ED.1080200@gmail.com> (Dana How's message of "Tue, 01 May
	2007 20:18:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46042>

Dana How <danahow@gmail.com> writes:

> Consequently,  for such a usage pattern it is useful
> to specify different compression levels for loose
> objects and packs.  This patch implements a config
> variable pack.compression in addition to the existing
> core.compression,  meant to be used for repacking.
> It also adds --compression=N to pack-objects,
> meant for push/pull/fetch,  if different,  or if different
> on a per-repository basis.
>
> ** THIS PATCH IS UNTESTED AND MEANT FOR DISCUSSION. **

I think we tweaked this area in the past, but I do not think
the current setting was determined to be the best tradeoff for
all workloads.  To be able to discuss the patch, I think it
needs to come with benchmark numbers using publicly available
repositories as guinea pigs and set of typical git operations,
so people can reproduce and compare notes.
