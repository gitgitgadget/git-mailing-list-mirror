From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 01/13] Fix lseek(2) calls with args 2 and 3 swapped
Date: Thu, 05 Apr 2007 16:00:17 -0700
Message-ID: <7vd52imnpa.fsf@assigned-by-dhcp.cox.net>
References: <56b7f5510704051523l30c422c6ie2ba561577fecb73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 01:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZawL-0006Xd-Sv
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 01:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767403AbXDEXAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 19:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767405AbXDEXAV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 19:00:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64268 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767403AbXDEXAT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 19:00:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405230017.NJNS25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 19:00:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jb0J1W0091kojtg0000000; Thu, 05 Apr 2007 19:00:18 -0400
In-Reply-To: <56b7f5510704051523l30c422c6ie2ba561577fecb73@mail.gmail.com>
	(Dana How's message of "Thu, 5 Apr 2007 15:23:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43880>

Good fixes. Thanks.

Although I suspect they are no-op in practice (SEEK_SET is
probably zero anyway).  Will apply to 'maint' to be included in
v1.5.1.1.
