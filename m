From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach 'git remote' how to cleanup stale tracking branches.
Date: Thu, 01 Feb 2007 22:06:33 -0800
Message-ID: <7v4pq5ks9i.fsf@assigned-by-dhcp.cox.net>
References: <58b74d176fd10417a58d42d9437c631d03f4c4f6.1170392736.git.spearce@spearce.org>
	<20070202050608.GB20505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 07:06:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCrZG-0004bt-Nd
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423124AbXBBGGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423126AbXBBGGf
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:06:35 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:46973 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423124AbXBBGGf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:06:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202060635.BSSZ4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Feb 2007 01:06:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JW6Z1W0111kojtg0000000; Fri, 02 Feb 2007 01:06:34 -0500
In-Reply-To: <20070202050608.GB20505@spearce.org> (Shawn O. Pearce's message
	of "Fri, 2 Feb 2007 00:06:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38459>

If you are disconnected, would it fail gracefully without
removing stuff?  From a cursory look it should, but just making
sure.
