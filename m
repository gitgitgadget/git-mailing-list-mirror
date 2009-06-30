From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Always output a trailing space conflicted merge markers.
Date: Tue, 30 Jun 2009 15:20:09 -0700
Message-ID: <7v1vp15ppi.fsf@alter.siamese.dyndns.org>
References: <1246322461-24742-1-git-send-email-nelhage@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Elhage <nelhage@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jul 01 00:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLlgw-0001Ws-2T
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 00:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbZF3WUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 18:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbZF3WUH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 18:20:07 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59239 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbZF3WUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 18:20:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630222009.ABQ20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jun 2009 18:20:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ANL91c0054aMwMQ04NL9iG; Tue, 30 Jun 2009 18:20:09 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=JfQwyIwb32wA:10 a=Op-QDATyAAAA:8
 a=6VNn5m6oBOv1yGUJeeoA:9 a=RJjzyz1pR24c_mw7FU0A:7
 a=3nyKVQqmC_SHZ-VQ8At9HghtyvEA:4
X-CM-Score: 0.00
In-Reply-To: <1246322461-24742-1-git-send-email-nelhage@mit.edu> (Nelson Elhage's message of "Mon\, 29 Jun 2009 20\:41\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122548>

Nelson Elhage <nelhage@MIT.EDU> writes:

> Some tools, such as emacs' smerge-mode, except that diff3-style merge
> conflict markers always include a trailing space (and optional
> description) after the marker, and so fail to correctly detect
> git's (notably the '|||||||' base marker, for which git never outputs a
> trailing space).
>
> (See http://emacsbugs.donarmstrong.com/cgi-bin/bugreport.cgi?bug=3553
> for the emacs issue)
>
> Signed-off-by: Nelson Elhage <nelhage@mit.edu>
> ---
>  xdiff/xmerge.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)

Thanks, but I think you also need to update the test scripts.

Don't you want some new tests to protect this from getting broken
in the future by other people yourself, too?
