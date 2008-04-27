From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Sun, 27 Apr 2008 13:13:26 -0700
Message-ID: <7vy76zf449.fsf@gitster.siamese.dyndns.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org>
 <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org>
 <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org>
 <7vabjflvlh.fsf@gitster.siamese.dyndns.org>
 <20080427173446.GM29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:14:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqDGS-0002PP-4C
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 22:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757047AbYD0UNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 16:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760944AbYD0UNg
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 16:13:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581AbYD0UNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 16:13:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FB774A5D;
	Sun, 27 Apr 2008 16:13:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0D6084A5B; Sun, 27 Apr 2008 16:13:28 -0400 (EDT)
In-Reply-To: <20080427173446.GM29771@spearce.org> (Shawn O. Pearce's message
 of "Sun, 27 Apr 2008 13:34:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80480>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> But then they later wonder why they need `git pull origin branch`
> to merge in branch, when they usually just say `git pull`.  What is
> the need for that funny keyword `origin`?  Why do I have to say
> where to get the branch from sometimes and not others?
> ...
> Just take the above as the rantings of someone who knows git a
> little too well, and has tried to teach it to people who don't,
> and they all have asked about the funny (to them) need for origin
> in git-pull/git-push command line sometimes (no refspecs) and not
> others (with refspecs).

What's the constructive suggestion for improvement we can draw from this
after all?  Should we deprecate the defaulting of "origin" so that
everybody now should always say "git pull $where"?  In other words, make
people more aware that what _they_ do is the special case to have only one
remote to interact with?
