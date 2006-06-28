From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] rebase: check for errors from git-commit
Date: Wed, 28 Jun 2006 02:54:54 -0700
Message-ID: <20060628095454.GA23948@soma>
References: <20060628093322.GA29036@hand.yhbt.net> <7vveql38zr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 11:55:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWlA-00075o-MI
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423245AbWF1Jy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423247AbWF1Jy5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:54:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:48601 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1423245AbWF1Jy4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 05:54:56 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2BCB77DC022;
	Wed, 28 Jun 2006 02:54:55 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 28 Jun 2006 02:54:54 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vveql38zr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22793>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >
> >> Anticipating failure from "git-commit" is the right thing to do,
> >> but this is a "Now what?" situation.  What is the expected
> >> course of action to recover from this for the end user, and how
> >> can we phrase the error message to help that process?
> >
> > I would expect git-commit to show the correct error message (or the
> > pre-commit hook), die "$RESOLVEMSG" might be a better option, though.
> 
> It would say 'resolve conflicts, mark them with update-index as
> necessary, and say git-commit' or somesuch.  I am not sure you
> would want the user to make a commit like suggested -- instead
> you would want him to say 'git rebase --continue' wouldn't you?

Actually RESOLVEMSG in git-rebase just tells the user about the
--continue, --skip, --abort options.

-- 
Eric Wong
