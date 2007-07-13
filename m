From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible to make a totally empty repository for remote access?
Date: Fri, 13 Jul 2007 15:18:35 -0700
Message-ID: <7vtzs8lzgk.fsf@assigned-by-dhcp.cox.net>
References: <54C69B03-C589-480E-80D3-75166DBF2D29@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 00:18:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9TTE-00059D-5o
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 00:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980AbXGMWSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 18:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757563AbXGMWSh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 18:18:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43230 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756776AbXGMWSg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 18:18:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713221836.SDXV1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Jul 2007 18:18:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PAJb1X00T1kojtg0000000; Fri, 13 Jul 2007 18:18:36 -0400
In-Reply-To: <54C69B03-C589-480E-80D3-75166DBF2D29@wincent.com> (Wincent
	Colaiuta's message of "Fri, 13 Jul 2007 23:41:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52418>

Wincent Colaiuta <win@wincent.com> writes:

> I understand that Git is a *content* manager and a totally empty
> repository has no content, and therefore no tree object which the
> HEAD can point to. But the trouble with adding content the way I
> describe above, is that my public repository is no longer bare; it
> now has a working copy, which I didn't really want.

You prepared an empty bare repository for publishing, and that
is very good.

The next step is that you prepare your contents elsewhere.  That
would be your private working place, i.e. the place you would
normally work in).  You push from your private working place
into that publishing repository.  Your working place is where
the very initial commit should come from, since you are the one
who is starting the project.

Note that the private working place does not have to be a clone
of the empty one.  That actually is backwards.  Your work
started from your private working place to the publishing one.

You could even clone your private repository to publishing one
to make it clear who is the master and who is the copy if you
wanted to, but because you already have the bare repository for
publishing, just pushing into it is all that is needed.
