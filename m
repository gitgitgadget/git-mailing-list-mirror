From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Sun, 20 Jul 2008 16:24:00 -0700
Message-ID: <7vy73w16nj.fsf@gitster.siamese.dyndns.org>
References: <1216592735-23789-1-git-send-email-code@istique.net>
 <20080720230846.GH32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve =?utf-8?Q?Fr=C3=A9cinaux?= <code@istique.net>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 01:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKiH8-00079r-6B
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 01:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYGTXYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 19:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbYGTXYJ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 19:24:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbYGTXYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 19:24:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7307337E38;
	Sun, 20 Jul 2008 19:24:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E899E37E37; Sun, 20 Jul 2008 19:24:02 -0400 (EDT)
In-Reply-To: <20080720230846.GH32184@machine.or.cz> (Petr Baudis's message of
 "Mon, 21 Jul 2008 01:08:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F28E9916-56B2-11DD-B32E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89266>

Petr Baudis <pasky@suse.cz> writes:

> I think that ls-tree simply shouldn't auto-fill its pathspec based on
> current prefix in case no pathspec was supplied. Patch to follow.

Have you dug the list archive from mid-to-late December 2005 that prompted
the current behaviour (and introduction of --full-name)?  I haven't.  A
change to always do the --full-name can only be justified by doing so and
rehashing the issues.

On the other hand, "fix" is welcome.


	
