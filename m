From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] Optimize the two-way merge of git-read-tree too
Date: Fri, 10 Aug 2007 22:57:05 -0700
Message-ID: <7v8x8ipqa6.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.999.0708101213560.30176@woody.linux-foundation.or g>
	<alpine.LFD.0.999.0708101216000.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708101224110.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708101240200.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 07:57:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJjyP-0001Zj-Lb
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 07:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbXHKF5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 01:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbXHKF5J
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 01:57:09 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58871 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbXHKF5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 01:57:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811055705.XFAV7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 01:57:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aVx51X00Q1kojtg0000000; Sat, 11 Aug 2007 01:57:05 -0400
In-Reply-To: <alpine.LFD.0.999.0708101240200.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 10 Aug 2007 12:53:51 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55588>

Looks obvious, mostly thanks to the clean rule that you outlined
in [PATCH 2/2] description.

Thanks.
