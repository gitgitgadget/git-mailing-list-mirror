From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] resend: really plug memory leaks in git-svnimport
Date: Tue, 25 Sep 2007 10:55:35 -0700
Message-ID: <7vr6km6354.fsf@gitster.siamese.dyndns.org>
References: <20070924105740.GB8900@ted>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Sperling <stsp@elego.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 19:56:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaEdZ-0007Ws-Qq
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 19:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbXIYRzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 13:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbXIYRzm
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 13:55:42 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:59087 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759611AbXIYRzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 13:55:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070925175537.NYFJ19928.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 25 Sep 2007 13:55:37 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id shvb1X00U1gtr5g0000000; Tue, 25 Sep 2007 13:55:36 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59149>

Stefan Sperling <stsp@elego.de> writes:

> Junio asked me to resend this patch to the mailing list.
>
> This version of the patch is adjusted to apply cleanly
> to current HEAD.
>
> @Junio: I'm not resending the multiple branch/tag dirs patch
> just yet, because I want to polish it first -- I've got another
> idea how to improve it.

Ok.

People on the list who still use git-svnimport, could you help
with testing this patch?  Will queue for 'pu' in the meantime.
