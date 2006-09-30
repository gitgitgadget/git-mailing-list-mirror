From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Sat, 30 Sep 2006 12:42:04 -0700
Message-ID: <7vfye9dtv7.fsf@assigned-by-dhcp.cox.net>
References: <20060929221641.GC2871@admingilde.org>
	<7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
	<20060930181408.GD2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 21:42:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTkiz-0003ha-H0
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 21:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWI3TmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 15:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWI3TmJ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 15:42:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:10173 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751784AbWI3TmG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 15:42:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930194205.DBPO12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 15:42:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Uji71V00R1kojtg0000000
	Sat, 30 Sep 2006 15:42:08 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060930181408.GD2871@admingilde.org> (Martin Waitz's message of
	"Sat, 30 Sep 2006 20:14:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28147>

Martin Waitz <tali@admingilde.org> writes:

> Should we use the gitweb feature mechanism to enable/disable
> PATH_INFO URL generation?

That sounds sensible.  I personally do not think many people
would object if you made the default to true.  Also I do not
think it would make much sense to make this overridable by
repository configuration.
