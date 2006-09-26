From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 25 Sep 2006 23:34:04 -0700
Message-ID: <7vhcyvrvab.fsf@assigned-by-dhcp.cox.net>
References: <20060926053816.54951.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 08:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS6WJ-0004Oz-8a
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 08:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWIZGeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 02:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWIZGeI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 02:34:08 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60629 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751676AbWIZGeF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 02:34:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926063405.GEGF6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 02:34:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Sua21V00H1kojtg0000000
	Tue, 26 Sep 2006 02:34:03 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060926053816.54951.qmail@web31815.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 25 Sep 2006 22:38:16 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27779>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Binary and non-binary blobs:
>
> The "list" table element of tree view is identical
> to the "blob" link part of the link table element.
> I.e. clicking on "blob" is identical to clicking on
> the entry itself.

Then perhaps we can lose tree link for the same reasoning?
