From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 19:25:18 -0700
Message-ID: <7vtzsoami9.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
	<7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
	<20070630194335.GK7730@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Jul 01 04:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4p7q-0004KT-9V
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 04:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbXGACZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 22:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbXGACZU
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 22:25:20 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:54647 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbXGACZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 22:25:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701022518.FCMV1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 22:25:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id J2RH1X00D1kojtg0000000; Sat, 30 Jun 2007 22:25:18 -0400
In-Reply-To: <20070630194335.GK7730@nan92-1-81-57-214-146.fbx.proxad.net>
	(Yann Dirson's message of "Sat, 30 Jun 2007 21:43:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51267>

Yann Dirson <ydirson@altern.org> writes:

> On Sat, Jun 30, 2007 at 12:17:10PM -0700, Junio C Hamano wrote:
>> So I am somewhat negative on this, unless there is a way for
>> scripts to say "Even though I say 'git foo', I do mean 'git foo'
>> not whatever the user has aliased".
>
> "git --no-alias foo" (like "cvs -f foo" which ignores ~/.cvsrc) ?

The current scripts that largely use "git-foo" do not have to be
changed.  Your --no-alias and Linus's "git - foo" would be a
"solution", but both require changes to the scripts -- and that
"solution" is necessary only because we would rewrite calls to
"git-foo" in existing scripts to "git foo" today?

No, thanks.  We should do better than that.
