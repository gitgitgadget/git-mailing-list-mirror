From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 01:33:34 -0700
Message-ID: <7vws8te2ht.fsf@alter.siamese.dyndns.org>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 10:33:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1z32-0001bg-Lu
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbZEGIdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 04:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbZEGIdf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:33:35 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55315 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbZEGIde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 04:33:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090507083334.QDHE18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 May 2009 04:33:34 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id oYZa1b00E4aMwMQ03YZaxB; Thu, 07 May 2009 04:33:34 -0400
X-Authority-Analysis: v=1.0 c=1 a=Ui9-g4_88esA:10 a=p71bCc7y6QQA:10
 a=gbm7fzhtnAq9hdqYFn8A:9 a=wPxEyXQomos5qff8P4KHRl3XynwA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de> (Matthias Andree's message of "Thu\,  7 May 2009 10\:24\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118442>

Matthias Andree <matthias.andree@gmx.de> writes:

> Problem: when git is installed into /usr/local/bin, running 'sudo make
> install' won't find git in $PATH (because sudo strips PATH, for instance
> on openSUSE 11.1, and doesn't include /usr/local/whatever).

That sounds like a bug/misfeature in sudo (which I do not use) to me.
