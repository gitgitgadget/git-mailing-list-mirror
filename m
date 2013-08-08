From: gitml.jexpert@recursor.net
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout
Date: Thu, 08 Aug 2013 14:23:06 +0200
Message-ID: <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 14:23:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7PFL-0004DG-5S
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 14:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778Ab3HHMXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 08:23:10 -0400
Received: from gourmet7.spamgourmet.com ([216.75.62.102]:40556 "EHLO
	gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752219Ab3HHMXJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 08:23:09 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7PFE-0000TW-U2
	for git@vger.kernel.org; Thu, 08 Aug 2013 12:23:08 +0000
Received: from mail.exxcellent.de ([217.6.238.198])
	by gourmet7.spamgourmet.com with esmtp (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7PFE-0000SN-DU; Thu, 08 Aug 2013 12:23:08 +0000
In-Reply-To: <877gfw4byx.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231875>

> Regardless of any possible fault in git-svn, there's an obvious bug here
> with git-fsck.  Can you share the pack (if the project is public) or
> compile a git-fsck without optimization and with debugging, and run it
> under valgrind, to hopefully get us a backtrace of where the memory
> management goes off the rails?

Unfortunately I'm unable to share the pack.

As Java Developer I'm note very savy, but I'd try.
Do you have me any pointers on ".. without optimization and with
debugging" and "run it under valgrind"?

Currently I used
   deb http://ppa.launchpad.net/git-core/ppa/ubuntu quantal main
as source.
