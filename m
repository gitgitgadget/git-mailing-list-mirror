From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove unnecessary ouput from t3600-rm.
Date: Mon, 29 May 2006 00:27:03 -0700
Message-ID: <7v1wud9tq0.fsf@assigned-by-dhcp.cox.net>
References: <20060529071646.GC6061@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 09:27:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkc9c-0004vw-KK
	for gcvg-git@gmane.org; Mon, 29 May 2006 09:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWE2H1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 03:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWE2H1F
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 03:27:05 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:44685 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750738AbWE2H1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 03:27:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060529072704.VWUK15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 May 2006 03:27:04 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060529071646.GC6061@spearce.org> (Shawn Pearce's message of
	"Mon, 29 May 2006 03:16:46 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20931>

Shawn Pearce <spearce@spearce.org> writes:

> Moved the output of the setup commits and the test-file rm check to
> file descriptors 3 and 4 hiding their messages unless -v is given.
> This makes the test suite look a little cleaner when the rm test-file
> setup step fails (and was probably expected to fail).

I suspect those bare commands _should_ succeed so make them a
separate test step and verify their success return while you are
at it, and their output would not be shown normally, without
your futzing with file descriptors.  Wouldn't that be a lot
cleaner approach?
