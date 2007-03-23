From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Documentation: Allow @@GIT_VERSION@@ in asciidoc.conf
Date: Fri, 23 Mar 2007 14:53:58 -0700
Message-ID: <7vejnfpqx5.fsf@assigned-by-dhcp.cox.net>
References: <11746760451462-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Fri Mar 23 22:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUri1-0005YZ-8m
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 22:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992576AbXCWVyB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 17:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992578AbXCWVyA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 17:54:00 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54743 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992576AbXCWVx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 17:53:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323215400.TGQA321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Mar 2007 17:54:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id eMty1W00o1kojtg0000000; Fri, 23 Mar 2007 17:53:59 -0400
In-Reply-To: <11746760451462-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Fri, 23 Mar 2007 19:54:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42961>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> Rename asciidoc.conf to asciidoc.conf.in and create
> the former on build time after piping it through sed.
>
> This is useful to allow us to include the git version
> in the documentation.
>
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  Documentation/Makefile         |   11 ++++++++---
>  Documentation/asciidoc.conf    |   39 ---------------------------------------
>  Documentation/asciidoc.conf.in |   39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/asciidoc.conf
>  create mode 100644 Documentation/asciidoc.conf.in

When sending a patch like this, please use "format-patch -M".

While this is attractive to some degree, *I* am grumpy.  Doesn't
this patch make html and man branches update all files _every_
time any small change is made to some documentation?
