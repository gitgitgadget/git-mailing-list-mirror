From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: add support for new style remote layout
Date: Sun, 03 Jun 2007 15:00:58 -0700
Message-ID: <7vvee4n1et.fsf@assigned-by-dhcp.cox.net>
References: <3a477a76f6c5396feee452678fb8110c@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:01:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huy8K-0004H5-8V
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbXFCWBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbXFCWA7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 18:00:59 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64744 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbXFCWA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 18:00:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070603220100.WUHJ15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Jun 2007 18:01:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7A0y1X00H1kojtg0000000; Sun, 03 Jun 2007 18:00:58 -0400
In-Reply-To: <3a477a76f6c5396feee452678fb8110c@pinky> (Andy Whitcroft's
	message of "Wed, 30 May 2007 01:56:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49039>

Andy Whitcroft <apw@shadowen.org> writes:

> cvsimport creates any branches found in the remote CVS repository
> in the refs/heads namespace.  This makes sense for a repository
> conversion.  When using git as a sane interface to a remote CVS
> repository, that repository may well remain as the 'master'
> respository.  In this model it makes sense to import the CVS
> repository into the refs/remotes namespace.
>
> Add a new option '-r <remote>' to set the remote name for
> this import.  When this option is specified branches are named
> refs/remotes/<remote>/branch, with HEAD named as master matching
> git-clone separate remotes layout.  Without branches are placed
> ion refs/heads, with HEAD named origin as before.

Sounds good.  Docs?
