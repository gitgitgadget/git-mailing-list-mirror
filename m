From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with Git in Cygwin on x86-64 platform
Date: Sat, 22 Apr 2006 17:57:00 -0700
Message-ID: <7vwtdhglcz.fsf@assigned-by-dhcp.cox.net>
References: <20060422023029.GC2444@Zangband>
	<20060422211733.GB7676@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 23 02:57:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXSuR-0007VC-M9
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 02:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWDWA5D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 20:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWDWA5D
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 20:57:03 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38094 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751282AbWDWA5C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Apr 2006 20:57:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060423005702.KDEV18566.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 20:57:02 -0400
To: Tim O'Callaghan <timo@dspsrv.com>
In-Reply-To: <20060422211733.GB7676@steel.home> (Alex Riesen's message of
	"Sat, 22 Apr 2006 23:17:33 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19064>

Alex Riesen <raa.lkml@gmail.com> writes:

>> Any ideas on how to start tracking this one down?
>
> Start by going into git/t and running "./t0000-basic.sh -d -v"

I usually do "cd t && sh -x that-test -i -v".
