From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (amend)] cvsserver: Add test cases for config file handling
Date: Sun, 13 May 2007 13:04:15 -0700
Message-ID: <7vtzugqym8.fsf@assigned-by-dhcp.cox.net>
References: <11790154701376-git-send-email-frank@lichtenheld.de>
	<117901685018-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun May 13 22:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnKIt-00066B-CK
	for gcvg-git@gmane.org; Sun, 13 May 2007 22:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbXEMUER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756594AbXEMUER
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 16:04:17 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33530 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629AbXEMUEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 16:04:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513200415.JUUA22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 16:04:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id yk4F1W0061kojtg0000000; Sun, 13 May 2007 16:04:15 -0400
In-Reply-To: <117901685018-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Sun, 13 May 2007 02:40:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47177>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> Add a few test cases for the config file parsing
> done by git-cvsserver.
>
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  t/t9420-git-cvsserver-config.sh |  109 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 109 insertions(+), 0 deletions(-)
>  create mode 100755 t/t9420-git-cvsserver-config.sh

Do we really need a separate test script that does quite similar setup?
