From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 12:47:36 -0700
Message-ID: <7vr6rml4fb.fsf@assigned-by-dhcp.cox.net>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Mar 18 20:47:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT1M0-0007lO-Vy
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 20:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933057AbXCRTri (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 15:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933063AbXCRTri
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 15:47:38 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61650 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933057AbXCRTrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 15:47:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318194738.NLSL18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 15:47:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cKnc1W0101kojtg0000000; Sun, 18 Mar 2007 15:47:37 -0400
In-Reply-To: <vpq648ye9w6.fsf@olympe.imag.fr> (Matthieu Moy's message of "Sun,
	18 Mar 2007 18:31:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42513>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I don't understand the design choice here: git had two options to
> avoid this scenario:

Actually, there are no such "design choices".  That's entirely
up to the repository owners to arrange post-update hook, to
allow you to do anything you want.  

The default is not to encourage people (who do not know what
they are doing anyway) to push into non-bare repository.
