From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 19:03:18 -0800
Message-ID: <20061228030317.GA2154@localdomain>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 04:03:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzlYC-0001Ob-GP
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 04:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWL1DDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 22:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWL1DDU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 22:03:20 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42755 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964893AbWL1DDU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 22:03:20 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 79E427DC08E;
	Wed, 27 Dec 2006 19:03:18 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 27 Dec 2006 19:03:18 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35516>

Junio C Hamano <junkio@cox.net> wrote:
> ancient versions such as v1.1.6 or v1.2.0, and there are a
> handful "one-way-street upgrades" and quite a few user visible
> changes that already have happened before v1.4.4.  Namely:

Addendum:

git-svn related changes:

  - git-svn now requires the Perl SVN:: libraries, the
    command-line backend was too slow and limited.

  - the 'commit' command has been renamed to 'set-tree', and
    'dcommit' is the recommended replacement for day-to-day
    work.

-- 
Eric Wong
