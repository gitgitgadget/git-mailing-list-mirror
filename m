From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Sun, 24 May 2009 15:02:03 -0700
Message-ID: <7vfxeurwh0.fsf@alter.siamese.dyndns.org>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
	<7voctirzu6.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 00:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Llu-0008Uh-Tw
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 00:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757733AbZEXWCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 18:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758004AbZEXWCF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 18:02:05 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33786 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758009AbZEXWCC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 18:02:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524220204.BKDJ20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 May 2009 18:02:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id va231b00D4aMwMQ04a23N5; Sun, 24 May 2009 18:02:03 -0400
X-Authority-Analysis: v=1.0 c=1 a=cKKtvLOY1ucA:10 a=pGLkceISAAAA:8
 a=NuJchNabJ1lEK_S4WfIA:9 a=8mYbtyHEmUI63YFdB9bYyR7FVukA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com> (Giuseppe Bilotta's message of "Sun\, 24 May 2009 23\:43\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119866>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> That was my initial thought too, but then I realized that having the
> 'heuristics' (although a very braindead one) in mailinfo makes more
> sense because otherwise StGIT patch autodetection would only work when
> applying a whole series, and not when applying a single (or a few)
> patches.

The above is very selfish---what if somebody else wanted to add a feature
to grok a non-mailbox input to the same codepath, and it is not a StGIT
patch?

That is what I called "bad taste".

The same comment may apply to the rest of your response.  "This hack is
good enough for _my_ use case; I do not care if my change makes life
harder for others to build on top of my patch" is not what I want to see.
