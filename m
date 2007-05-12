From: Junio C Hamano <junkio@cox.net>
Subject: Re: Subproject clones
Date: Fri, 11 May 2007 18:26:27 -0700
Message-ID: <7vr6pm7ry4.fsf@assigned-by-dhcp.cox.net>
References: <20070512011600.GA24354@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: apw@us.ibm.com (Amos Waterland)
X-From: git-owner@vger.kernel.org Sat May 12 03:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmgNV-0001Fc-C1
	for gcvg-git@gmane.org; Sat, 12 May 2007 03:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678AbXELB03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 21:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbXELB03
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 21:26:29 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58530 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbXELB02 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 21:26:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512012629.DKMQ2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 21:26:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id y1ST1W00U1kojtg0000000; Fri, 11 May 2007 21:26:28 -0400
In-Reply-To: <20070512011600.GA24354@us.ibm.com> (Amos Waterland's message of
	"Fri, 11 May 2007 21:16:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47010>

apw@us.ibm.com (Amos Waterland) writes:

> Is this intentional?  Shouldn't clone get the entire superproject?

Yes.  As 1.5.2 draft release notes and my response to somebody
else last night mentioned, the plumbing level subproject support
does _NOT_ recurse into subproject and this is deliberate.
