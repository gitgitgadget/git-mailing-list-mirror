From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] run_diff_{files,index}(): update calling convention.
Date: Sat, 10 Feb 2007 00:20:59 -0800
Message-ID: <7vps8imnis.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	<7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
	<Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	<7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
	<7vejoyq330.fsf@assigned-by-dhcp.cox.net>
	<7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
	<e5bfff550702100002y3929c50mfb99b8da44c9c82b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 09:21:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFnTn-00035K-Bf
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 09:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbXBJIVD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 03:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbXBJIVD
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 03:21:03 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45744 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbXBJIVB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 03:21:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210082101.LYIX4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 03:21:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id MkLz1W00p1kojtg0000000; Sat, 10 Feb 2007 03:21:00 -0500
In-Reply-To: <e5bfff550702100002y3929c50mfb99b8da44c9c82b@mail.gmail.com>
	(Marco Costalba's message of "Sat, 10 Feb 2007 09:02:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39209>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Running 'git runstatus' alone shows _all_ the repo files, although are
> not modified and not touched.

That does not sound right with or without my patch.  Are you
talking about the 'git runstatus' with my patch is showing
paths that are cache clean?  If that is the case that means my
patch is introudcing regression.
