From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow default core.logallrefupdates to be overridden with template's config
Date: Tue, 23 Jan 2007 17:53:33 -0800
Message-ID: <7vy7ntjile.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701230754p3425ded4k1f37dd26500c1744@mail.gmail.com>
	<7v64axmcmr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 02:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9XKT-0004qN-W7
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965471AbXAXBxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbXAXBxf
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:53:35 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38567 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965471AbXAXBxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:53:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124015334.CRYO25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 23 Jan 2007 20:53:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Epts1W0061kojtg0000000; Tue, 23 Jan 2007 20:53:52 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <7v64axmcmr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 23 Jan 2007 17:34:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37594>

Junio C Hamano <junkio@cox.net> writes:

> However, when set to false, your check says "Do not set it
> per-repo".  This tells git to follow the default "use reflog in
> non-bare repositories" and it does not mean "I do not want
> steenking reflogs anywhere".

This part is not true -- as we copy the templated config which
has explicit "no steenking reflog" to the new repository.

So I am Ok with your patch.
