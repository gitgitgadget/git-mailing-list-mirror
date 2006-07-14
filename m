From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] urls.txt: Use substitution to escape square brackets
Date: Fri, 14 Jul 2006 15:07:19 -0700
Message-ID: <7vfyh3on6w.fsf@assigned-by-dhcp.cox.net>
References: <11528726881431-git-send-email-alp@atoker.com>
	<20060714215039.GA21994@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alp Toker <alp@atoker.com>, git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Jul 15 00:07:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Vol-0004CI-Dh
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 00:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161313AbWGNWHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWGNWHV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 18:07:21 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12196 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161313AbWGNWHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 18:07:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714220720.BIVX985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 18:07:20 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060714215039.GA21994@diku.dk> (Jonas Fonseca's message of
	"Fri, 14 Jul 2006 23:50:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23913>

Jonas Fonseca <fonseca@diku.dk> writes:

> This changes "[user@]" to use {startsb} and {endsb} to insert [ and ],
> similar to how {caret} is used in git-rev-parse.txt.
>
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

Looks nicer.  Alp?  Does this work with your version of
asciidoc?
