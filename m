From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/7] Using svn pools seems to solve the memory leak problem
Date: Wed, 02 Nov 2005 14:38:57 -0800
Message-ID: <7v64raptdq.fsf@assigned-by-dhcp.cox.net>
References: <E1EXQWT-000504-Qw@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 23:40:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXRG4-000233-9b
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 23:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965322AbVKBWjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbVKBWjA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 17:39:00 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62852 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965322AbVKBWi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 17:38:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102223859.KRFX9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 17:38:59 -0500
To: Yaacov Akiba Slama <ya@slamail.org>
In-Reply-To: <E1EXQWT-000504-Qw@localhost.localdomain> (Yaacov Akiba Slama's
	message of "Wed, 02 Nov 2005 23:51:57 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11053>

I see you are resending the previous round after splitting, but
could you be a bit more careful about the commit log?  One liner
title that is self-sufficient (as opposed to just the initial
part of one sentence, cut off at whereever your editor happened
to decide to fold line), which goes to Subject:, and the body of
the message as a separate paragraph.

Especially something like this (5/7) does not make much sense:

    From: Yaacov Akiba Slama <ya@slamail.org>
    Subject: [PATCH 5/7] When copying files and/or directories from several branches in one single
    Date: Wed, 02 Nov 2005 23:51:57 +0200

    revision, all these branches are used as parents of the commit.
