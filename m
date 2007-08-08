From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout_entry: only try to create directories when no file existed there
Date: Wed, 08 Aug 2007 14:17:43 -0700
Message-ID: <7v4pj93evc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708082200240.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsub-0001ik-Ii
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934361AbXHHVRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933942AbXHHVRp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:17:45 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33670 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764677AbXHHVRo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 17:17:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808211744.IIET2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 17:17:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZZHj1X00B1kojtg0000000; Wed, 08 Aug 2007 17:17:43 -0400
In-Reply-To: <Pine.LNX.4.64.0708082200240.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 8 Aug 2007 22:00:53 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55369>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It is obvious that we do not have to create directories when the file we
> want to check out already existed.

It is not so obvious to me.  In fact I vaguely recall we had
complaint about opposite case where we did not honor a symlink
to be checked out as a symlink because an earlier branch had it
as a directory.
