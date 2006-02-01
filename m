From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svnimport.perl: fix for 'arg list too long...'
Date: Wed, 01 Feb 2006 12:27:33 -0800
Message-ID: <7v64nybz9m.fsf@assigned-by-dhcp.cox.net>
References: <20060201155331.GE18078@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Wed Feb 01 21:27:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4OZp-0004X6-Lf
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 21:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWBAU1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 15:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbWBAU1g
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 15:27:36 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25808 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161114AbWBAU1f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 15:27:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201202630.PJBP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 15:26:30 -0500
To: Sasha Khapyorsky <sashak@voltaire.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15440>

Sasha Khapyorsky <sashak@voltaire.com> writes:

> This fixes 'arg list too long..' problem with git-ls-files.

I wonder if feeding the list into a pipe to 'update-index --stdin' 
would be an option.

BTW, please do not do this:

        Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
                Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org

It is simply rude.

 * I and/or Smurf may be uninterested in hearing the whole
   discussion thread started by you.  We might well be, but that
   is not something you shoudl decide upfront in your message.

 * When a recipient of your message tries to "[R]eply" to *you*,
   that Mail-Followup-To: would cause the MUA to address that
   message to me and/or smurf by default, not to you.  I had to
   edit the resulting To: header by hand to address this
   response to you.  Why force extra work on others?

I know why you did it --- you subscribe to git list and
otherwise you would get two copies.

That is _not_ a good excuse.  That is how mailing lists work;
either you filter the duplicates on your end, or you learn to
live with it.  Please don't force extra work on others.

I think the only header mucking of this kind that is acceptable
is to remove yourself from CC: line when the mailing list you
subscribe to is already on the CC: line.
