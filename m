From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Handle invalid argc gently
Date: Wed, 13 Sep 2006 23:34:05 -0700
Message-ID: <7vpsdz5542.fsf@assigned-by-dhcp.cox.net>
References: <20060914010409.GB20593@nomad.office.altlinux.org>
	<7vu03b5k0t.fsf@assigned-by-dhcp.cox.net>
	<20060914013146.GD7044@basalt.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 08:34:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNknb-0000fh-L0
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 08:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWINGeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 02:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWINGeI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 02:34:08 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28108 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751334AbWINGeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 02:34:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914063406.MLFK6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 02:34:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id N6Zv1V0011kojtg0000000
	Thu, 14 Sep 2006 02:33:55 -0400
To: "Dmitry V. Levin" <ldv@altlinux.org>
In-Reply-To: <20060914013146.GD7044@basalt.office.altlinux.org> (Dmitry
	V. Levin's message of "Thu, 14 Sep 2006 05:31:46 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26987>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> On Wed, Sep 13, 2006 at 06:12:02PM -0700, Junio C Hamano wrote:
>> "Dmitry V. Levin" <ldv@altlinux.org> writes:
>> 
>> > describe, git: Handle argc==0 case the same way as argc==1.
>> 
>> When does one get (ac == 0)?
>
> When one executes something like
> execlp("git", NULL, NULL);

Fair enough.

What is the valid reason to do execlp("git", NULL, NULL)?
