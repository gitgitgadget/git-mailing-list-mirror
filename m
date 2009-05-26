From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Tue, 26 May 2009 14:41:28 -0700
Message-ID: <7v1vqbpmnr.fsf@alter.siamese.dyndns.org>
References: <1243316165-99065-1-git-send-email-davvid@gmail.com>
	<200905262231.50892.markus.heidelberg@web.de>
	<20090526205230.GA66544@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org,
	gitster@pobox.com, johannes.schindelin@gmx.de, nick@incise.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 23:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M94Pv-0006bd-NR
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 23:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758593AbZEZVlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 17:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757736AbZEZVla
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 17:41:30 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52978 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166AbZEZVla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 17:41:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090526214132.TLJC25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 May 2009 17:41:32 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id wMhV1b0024aMwMQ04MhXzX; Tue, 26 May 2009 17:41:31 -0400
X-Authority-Analysis: v=1.0 c=1 a=g2Kvswfn6DYA:10 a=VsK4u529S6UA:10
 a=pGLkceISAAAA:8 a=cexIBkohAAAA:8 a=t-IPkPogAAAA:8 a=OZRpIDgxjD5kSh6GQH0A:9
 a=9bkL69Caez7Xe6D8ny4Wgm-miLAA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090526205230.GA66544@gmail.com> (David Aguilar's message of "Tue\, 26 May 2009 13\:52\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120012>

David Aguilar <davvid@gmail.com> writes:

> Perhaps the best answer is to set them all to YesPlease except
> for mac and openbsd, which I know have native implementations.

Some vintage of Solaris seems to have it:

    http://docs.sun.com/app/docs/doc/819-2243/mkstemps-3c?a=view

The notes section of

    http://developer.apple.com/documentation/Darwin/Reference/ManPages/man3/mkstemps.3.html

says

    The mkstemps() function first appeared in OpenBSD 2.4, and later in
     FreeBSD 3.4.
