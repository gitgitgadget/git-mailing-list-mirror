From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/8] bash: Classify more commends out of completion.
Date: Sun, 04 Feb 2007 00:11:32 -0800
Message-ID: <7vmz3uxryj.fsf@assigned-by-dhcp.cox.net>
References: <20070204073830.GE17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 09:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDcTJ-0004Z1-Jj
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 09:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbXBDILf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 03:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXBDILe
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 03:11:34 -0500
Received: from fed1rmmtai16.cox.net ([68.230.241.43]:64884 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752160AbXBDILe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 03:11:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204081134.CPJB1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 03:11:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KLBZ1W0071kojtg0000000; Sun, 04 Feb 2007 03:11:34 -0500
In-Reply-To: <20070204073830.GE17603@spearce.org> (Shawn O. Pearce's message
	of "Sun, 4 Feb 2007 02:38:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38666>

At some point we might want to generate this part from the table
defined in Documentation/cmd-list.perl (the latter might need to
be extended for that, but I think matching "helper", "plumbing"
and perhaps "foreign" would cover most of them).
