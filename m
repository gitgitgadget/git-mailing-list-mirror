From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add sendmail -f support to git-send-email.
Date: Tue, 10 Apr 2007 16:00:57 -0700
Message-ID: <7v6483u95i.fsf@assigned-by-dhcp.cox.net>
References: <11762425341841-git-send-email-robbat2@gentoo.org>
	<20070410223826.GH2813@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 08:15:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbPKk-0005No-Pg
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 01:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbXDJXBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 19:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbXDJXBA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 19:01:00 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:65213 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161010AbXDJXA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 19:00:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410230059.NFJB1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 19:00:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lb0x1W00o1kojtg0000000; Tue, 10 Apr 2007 19:00:58 -0400
In-Reply-To: <20070410223826.GH2813@planck.djpig.de> (Frank Lichtenheld's
	message of "Wed, 11 Apr 2007 00:38:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44194>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> On Tue, Apr 10, 2007 at 03:02:13PM -0700, Robin H. Johnson wrote:
>> Some mailing lists use the envelope sender instead of the actual from address,
>> and this can be broken in git-send-email. This patch sets the -f argument to
>> the sendmail binary, using the address of the patch author.
>
> At least some MTAs (exim is the one I know for sure) can restrict -f
> usage to some users and deny it for others. Don't know how much this
> would really be a problem, but using -f unconditionally might be a bad
> idea none-the-less.

I thought I saw the '-f' patch somewhere on the list in the last
several weeks and there was a discussion on this topic that
followed the patch.  Am I hallucinating, or was it not applied
because there were some issues?
