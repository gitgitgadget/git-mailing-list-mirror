From: Junio C Hamano <junkio@cox.net>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Mon, 09 Oct 2006 15:55:26 -0700
Message-ID: <7vmz859k0x.fsf@assigned-by-dhcp.cox.net>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>
	<4529B77A.707@gmail.com>
	<Pine.LNX.4.64.0610090904360.3952@g5.osdl.org>
	<46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 00:55:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX420-0005Pw-Gi
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 00:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWJIWz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 18:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWJIWz2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 18:55:28 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34730 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751911AbWJIWz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 18:55:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061009225527.RGRY2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 18:55:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YNvW1V0021kojtg0000000
	Mon, 09 Oct 2006 18:55:30 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 10 Oct 2006 10:08:15 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28584>


"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> is there a way to scan the object store for blobs of around a given
> size (as the packing code does) from Perl?

For objects in packs, verify-pack -v comes to mind (show-index
might show the same information).  Loose objects needs help from
git-cat-file -s or git-cat-file -t or both.
