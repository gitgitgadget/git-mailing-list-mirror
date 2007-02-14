From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add install-lib target to install libgit.a library plus headers.
Date: Wed, 14 Feb 2007 10:24:09 -0800
Message-ID: <7v4ppopph2.fsf@assigned-by-dhcp.cox.net>
References: <20070214145725.2827.qmail@0b3a4e2ad592dc.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:24:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOne-0002ei-D1
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbXBNSYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbXBNSYL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:24:11 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52605 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932434AbXBNSYK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:24:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214182411.HNGU21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 13:24:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PWQ91W00N1kojtg0000000; Wed, 14 Feb 2007 13:24:09 -0500
In-Reply-To: <20070214145725.2827.qmail@0b3a4e2ad592dc.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Wed, 14 Feb 2007 14:57:25 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39721>

Sorry, but libgit.a is not a publically usable/useful library at
this moment, as its internal API is not cast in stone yet.

Installing it in /usr/lib and /usr/include would give the false
impression to the users that linking with user's programs is
supported and upgrading git won't break them.  Please do not
create libgit-dev package.
