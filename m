From: Junio C Hamano <junkio@cox.net>
Subject: Re: adding file by absolute name -- problem
Date: Mon, 23 Apr 2007 03:04:47 -0700
Message-ID: <7v8xcjh0e8.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 12:04:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfvPf-0004n6-0W
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 12:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbXDWKEs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 06:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965695AbXDWKEs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 06:04:48 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48102 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbXDWKEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 06:04:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423100447.YAZR1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 23 Apr 2007 06:04:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qa4n1W0051kojtg0000000; Mon, 23 Apr 2007 06:04:47 -0400
In-Reply-To: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com>
	(Yakov Lerner's message of "Mon, 23 Apr 2007 12:39:03 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45310>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> When I give absolute pathname /a/b/repo/d to git add, it
> mostly does not work. I get errors from git-add. Is it by design ?

It's pretty much by design in the sense that none of us felt any
need for accepting absolute pathnames, and I personally still
don't.  But I do not have a strong feeling against accepting a
patch series that adds support for accepting absolute pathnames,
as long as it is done cleanly and obviously.
