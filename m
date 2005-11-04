From: Junio C Hamano <junkio@cox.net>
Subject: Re: Empty temp files in the .git/objects subdirectories
Date: Thu, 03 Nov 2005 18:32:54 -0800
Message-ID: <7vvez95ei1.fsf@assigned-by-dhcp.cox.net>
References: <dkebkq$ova$1@sea.gmane.org> <20051104015452.GB3001@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 03:34:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXrNz-0005M2-LY
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 03:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbVKDCc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 21:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVKDCc4
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 21:32:56 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16594 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161113AbVKDCc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 21:32:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104023159.GQXQ24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 21:31:59 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051104015452.GB3001@reactrix.com> (Nick Hengeveld's message of
	"Thu, 3 Nov 2005 17:54:52 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11116>

Nick Hengeveld <nickh@reactrix.com> writes:

> These are created by git-http-fetch to hold data as it's being
> fetch from the remote repository.  They are left behind after a transfer
> error so that the next time git-http-fetch runs it can pick up where it
> left off.  If they're empty though, it would make more sense to delete
> them rather than leaving them behind for the next attempt.

That makes sense.  Thanks.
