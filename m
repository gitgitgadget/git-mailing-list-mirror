From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce config core.binaryCheckFirstBytes for xdiff-interface
Date: Fri, 07 Sep 2007 14:19:33 -0700
Message-ID: <7vodge2mxm.fsf@gitster.siamese.dyndns.org>
References: <20070907191421.5526.qmail@f74fa18bc10c8f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:19:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITlEq-00047B-Kf
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 23:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758550AbXIGVTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 17:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758547AbXIGVTh
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 17:19:37 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45094 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758546AbXIGVTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 17:19:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070907211934.YLFD13288.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 7 Sep 2007 17:19:34 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id lZKZ1X00W1gtr5g0000000; Fri, 07 Sep 2007 17:19:33 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58076>

Gerrit Pape <pape@smarden.org> writes:

> xdiff-interface uses a hardcoded value of 8000 bytes to check from
> the top of data whether to handle it as binary content.  If a NULL
> character appears after the first 8000 bytes, git won't notice,

If the user has to set this to suit git better for a particular
project, I think the same effort is better spent on setting up
the attribute for that file so that git does not have to guess
the type, no?
