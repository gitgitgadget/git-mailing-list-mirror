From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use lockfile.c routines in git_commit_set_multivar()
Date: Thu, 26 Jul 2007 21:30:12 -0700
Message-ID: <7vfy3a5uzv.fsf@assigned-by-dhcp.cox.net>
References: <11854689283208-git-send-email-bradford.carl.smith@gmail.com>
	<Pine.LNX.4.64.0707261926590.14781@racer.site>
	<f158199e0707261148r29419a39h7d83fc7bd0ea7df1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Bradford Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 06:30:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEHSz-0005Dm-KL
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 06:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbXG0EaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 00:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbXG0EaQ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 00:30:16 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53987 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbXG0EaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 00:30:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727043014.VLYF1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Jul 2007 00:30:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UUWC1X00M1kojtg0000000; Fri, 27 Jul 2007 00:30:13 -0400
In-Reply-To: <f158199e0707261148r29419a39h7d83fc7bd0ea7df1@mail.gmail.com>
	(Bradford Smith's message of "Thu, 26 Jul 2007 14:48:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53882>

"Bradford Smith" <bradford.carl.smith@gmail.com> writes:

> FWIW, I have successfully run 'make test' and also verified that it
> behaves as I expect with my ~/.gitconfig symlink (in conjunction with
> the my other patch for resolving symlinks).

Existing "make test" testsuite is not an appropriate thing to
say this patch is safe, as we do not have much symlinking in the
test git repository there.  Care to add a new test or two?
