From: "Alfred M. Szmidt" <ams@gnu.org>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Sun, 14 Jun 2009 23:39:16 -0400
Message-ID: <E1MG32S-0004C6-8A@fencepost.gnu.org>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de>
Reply-To: ams@gnu.org
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 15 05:39:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG32u-0001RG-1L
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 05:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbZFODjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 23:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbZFODjT
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 23:39:19 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:46882 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbZFODjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 23:39:19 -0400
Received: from ams by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <ams@gnu.org>)
	id 1MG32S-0004C6-8A; Sun, 14 Jun 2009 23:39:16 -0400
In-reply-to: <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> (message
	from Johannes Schindelin on Sun, 14 Jun 2009 22:17:15 +0200 (CEST))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121578>

   > This small patch fixes things so that repack, fsck, and other
   > things work on >2GiB files.  There are still some other problems
   > (cloning over ssh being one), but this makes it atleast possible
   > to handle such files.

   This is almost perfect, but please add a Signed-off-by: line.

I cannot agree to the D-C-O in good faith, since it speaks of open
source licenses, a group of licenses that include non-free software
licenses, something which I cannot support.

   Oh, and maybe add a test like t/t5705-clone-2gb.sh?

Thank you, that is a very good idea.

(still not subscribed, please CC)
