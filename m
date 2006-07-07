From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add "raw" output option to blobs in "tree" view format
Date: Fri, 07 Jul 2006 11:45:22 -0700
Message-ID: <7vejwxxni5.fsf@assigned-by-dhcp.cox.net>
References: <20060707164152.86022.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 20:45:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyvKR-0001lW-Oh
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 20:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWGGSpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 14:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWGGSpY
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 14:45:24 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38276 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751230AbWGGSpY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 14:45:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707184523.EBTX12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 14:45:23 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060707164152.86022.qmail@web31805.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 7 Jul 2006 09:41:52 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23453>

Luben Tuikov <ltuikov@yahoo.com> writes:

> That is, the user would still have to click through "tree->blob->plain"
> to download a "text/*" file, as opposed to just "tree->raw".
>
> What this patch allows, is that the user be able to simply download the file,
> right from "tree" view, regardless of the type of file. (I.e. the type of
> file as decided by the _user_, not gitweb.cgi.)

OK, I see what you are aiming at.

I have been irritated by the current git_blob that always seems
to do "cat -n" even for non text/* files, but you are tackling
the opposite problem.
