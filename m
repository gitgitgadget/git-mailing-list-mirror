From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Official git repository history?
Date: Tue, 30 Jun 2009 00:46:57 -0700
Message-ID: <7vhbxy9n9q.fsf@alter.siamese.dyndns.org>
References: <h2aj43$ab0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 09:47:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLY3X-00034J-BU
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 09:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbZF3Hq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 03:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbZF3Hqz
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 03:46:55 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53067 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZF3Hqy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 03:46:54 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630074658.QRZW18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Tue, 30 Jun 2009 03:46:58 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id A7mx1c0044aMwMQ047mxYJ; Tue, 30 Jun 2009 03:46:57 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=mD6iURujKyYA:10 a=pGLkceISAAAA:8
 a=hw9ARwNd4X7Zf6R-nDYA:9 a=wh4KAro05cm5uyxFtsLTypvqBrkA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <h2aj43$ab0$1@ger.gmane.org> (Graeme Geldenhuys's message of "Mon\, 29 Jun 2009 16\:27\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122497>

Graeme Geldenhuys <graemeg@gmail.com> writes:

> So how did Linus get those first few commits / history into the official
> git repository? Was the first 8 C source code files already enough to
> work as a basic git repository?

He did it very well, and Yes.

You would need to check out an old revision, say v0.99, and look at the
original tutorial by Linus in Documentation/tutorial.txt.  It was since
rewritten into Documentation/gittutorial-2.txt but the original command
sequence Linus used from the initial version of git was replaced with
their more modern variants (e.g. Linus used "git-update-cache --add" but
the updated tutorial talks about "git add" that did not exist nor Linus
needed to have back then).
