From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add "raw" output option to blobs in "tree" view format
Date: Thu, 06 Jul 2006 23:58:28 -0700
Message-ID: <7vmzbl3nqj.fsf@assigned-by-dhcp.cox.net>
References: <20060707063930.7752.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 08:58:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FykIM-0002Eh-7p
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 08:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWGGG6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 02:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWGGG6a
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 02:58:30 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3524 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751219AbWGGG63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 02:58:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707065828.ORNN985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 02:58:28 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060707063930.7752.qmail@web31805.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 6 Jul 2006 23:39:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23414>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Add a "raw" output option to blobs in "tree" view format, so that the
> user doesn't have to click on "blob", wait for the (binary) file to be
> uploaded and shown in "blob" mode, and then click on "plain" to
> download the (binary) file.

I appreciate what you are trying to achieve, but at the same
time wonder if it would make more sense to simply teach a=blob
action to do this automatically, perhaps using /etc/mime.types
and/or File::MMagic.

If you know your MUA will mangle whitespace to make your patch
inapplicable, please do not add a patch to the message _and_
attach the patch to the message.  The mail-acceptance tools know
how to flatten MIME attachments, but if you have your log,
three-dash and then corrupt patch in the cover-letter part, and
then the true patch in the attachment part, the flattened result
will have the corrupt patch first to cause the patch application
to fail.  So please either (preferably) use a MUA that does not
corrupt your patches, or do a log in the message part with patch
only as attachment.
