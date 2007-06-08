From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-branch: cleanup config file when deleting branches
Date: Fri, 08 Jun 2007 01:45:27 -0700
Message-ID: <7vzm3akf6g.fsf@assigned-by-dhcp.cox.net>
References: <20070606100947.18990.qmail@bef1f6489d171f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 10:45:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwa6B-0006SR-6r
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 10:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935965AbXFHIp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 04:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936824AbXFHIp3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 04:45:29 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38940 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935965AbXFHIp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 04:45:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608084528.AKM5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 04:45:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8wlT1X00D1kojtg0000000; Fri, 08 Jun 2007 04:45:28 -0400
In-Reply-To: <20070606100947.18990.qmail@bef1f6489d171f.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Wed, 6 Jun 2007 10:09:47 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49450>

Gerrit Pape <pape@smarden.org> writes:

> When deleting branches, remove the sections referring to these branches
> from the config file.
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>

Hmph.  Makes sense and might even be a maint material, but it
probably is safe not to do a behaviour change in maint.

Tests?
