From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport: Add -A <author-conv-file> option
Date: Thu, 12 Jan 2006 20:09:37 -0800
Message-ID: <7vzmm0g45a.fsf@assigned-by-dhcp.cox.net>
References: <20060112233859.3438F5BED0@nox.op5.se>
	<7vvewohoy0.fsf@assigned-by-dhcp.cox.net> <43C70D03.4040609@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 05:09:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExGFz-000356-3I
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 05:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161317AbWAMEJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 23:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAMEJk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 23:09:40 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64152 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964799AbWAMEJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 23:09:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113040849.QXYR3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 23:08:49 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C70D03.4040609@op5.se> (Andreas Ericsson's message of "Fri, 13
	Jan 2006 03:14:27 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14610>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> ISTR there was a thread that suggested using CVSROOT/users file
>> for this purpose.
>> 	http://thread.gmane.org/gmane.comp.version-control.git/8167
>
> ISTR?

I seem to recall...

> That patch doesn't work when importing from sourceforge...
>
> Anyways, I can keep this separate if you don't want to accept it.

Oh, I haven't formed an opinion on accept/reject yet.  I was
just trying to see if you are aware of that (especially Pasky's
message in that thread) and thought about issues like "if in
some repositories CVSROOT/users is in usable form then perhaps
making sure -A file has the same format and suggest its use in
the documentation would be nicer".
