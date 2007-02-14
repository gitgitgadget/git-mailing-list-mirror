From: Junio C Hamano <junkio@cox.net>
Subject: Re: Including the release notes in the git-1.5.0 release?
Date: Wed, 14 Feb 2007 08:27:41 -0800
Message-ID: <7vk5ykso02.fsf@assigned-by-dhcp.cox.net>
References: <E1HGyPn-0003Te-9s@candygram.thunk.org>
	<7vzm7ix895.fsf@assigned-by-dhcp.cox.net>
	<20070213180541.GH8670@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMyy-0002qr-Pf
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbXBNQ1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbXBNQ1n
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:27:43 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51268 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368AbXBNQ1n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:27:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214162743.ETEP21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 11:27:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PUTi1W0021kojtg0000000; Wed, 14 Feb 2007 11:27:42 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39668>

Theodore Tso <tytso@mit.edu> writes:

> What I've seen some projects do (including some commercial products)
> is to keep them around with the old file names.  So if we have
>
> Documentation/RELEASE-NOTES_1.5.0.txt
> Documentation/RELEASE-NOTES_1.6.0.txt
> Documentation/RELEASE-NOTES_1.7.0.txt
>
> and a symlink from RELEASE-NOTES to Documentation/RELEASE-NOTES-<cur_ver>.txt
>
> that would make a lot of sense....

Done.

I used to like reading pod/perl*delta.pod but these days they
are tooooo long.  Hopefully we can keep our release notes short
and sweet. 

People might already have noticed that the latest docs at

	http://www.kernel.org/pub/software/scm/git/docs/

has link to older versions.
