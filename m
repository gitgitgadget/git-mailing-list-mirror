From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to build manpages on OS X
Date: Thu, 28 Dec 2006 16:24:03 -0800
Message-ID: <7vtzzftuqk.fsf@assigned-by-dhcp.cox.net>
References: <459453F8.1010200@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 01:24:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H05Xl-00052s-8V
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 01:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbWL2AYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 19:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbWL2AYG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 19:24:06 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39984 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbWL2AYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 19:24:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229002404.TVTL16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 19:24:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4QQH1W01C1kojtg0000000; Thu, 28 Dec 2006 19:24:18 -0500
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <459453F8.1010200@midwinter.com> (Steven Grimm's message of "Thu,
	28 Dec 2006 15:32:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35567>

Steven Grimm <koreth@midwinter.com> writes:

> The real solution is to use local copies of the files it's trying to
> fetch. These files are installed as part of one of the dependencies
> when you install xmlto, but the install process doesn't tell the
> system where to look for them! To use these local copies, you need to
> do two things.

Sounds like a DarwinPorts bug (or lack of feature, or maybe
feature still being added but not given to the public, I dunno).

My understanding is that these catalogs are maintained
automatically by the distribution when stylesheets are
installed.  For example, on Debian systems, xml-core seems to
offer the infrastructure and .postinst scripts for packages such
as docbook-xsl use update-xmlcatalog tool to make sure the
stylesheets they install are found locally on the system.

In any case, thanks for the write-up.

> Annoying that it doesn't just work, but hopefully this will save
> someone some Googling around.

I've added a pointer to your message at gmane archive on Gitwiki
page (GitDocumentation).
