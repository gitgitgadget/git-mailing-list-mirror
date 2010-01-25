From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH 06/18] rebase -i: Document how temporary files are used
Date: Sun, 24 Jan 2010 22:38:47 -0500
Message-ID: <20100125033846.GX13942@dr-wily.mit.edu>
References: <ec177b9d2b2354c446793df42525b4f7377bc413.1263447037.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	Greg Price <price@mit.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 25 04:43:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZFro-00077S-5k
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 04:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab0AYDnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 22:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160Ab0AYDnw
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 22:43:52 -0500
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:55488 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752265Ab0AYDnv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 22:43:51 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jan 2010 22:43:51 EST
X-AuditID: 12074423-b7c94ae000000269-c1-4b5d12480e8b
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU [18.7.7.80])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id 2A.D8.00617.8421D5B4; Sun, 24 Jan 2010 22:38:48 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id o0P3bw5s021972;
	Sun, 24 Jan 2010 22:37:58 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o0P3d34U014008;
	Sun, 24 Jan 2010 22:39:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <ec177b9d2b2354c446793df42525b4f7377bc413.1263447037.git.mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Brightmail-Tracker: AAAAAhKHu6kSh8aY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137935>

Michael Haggerty wrote:
> Add documentation, inferred by reverse-engineering, about how
> git-rebase--interactive.sh uses many of its temporary files.

Brilliant!  I like the 'fixup' command and look forward to using it,
but this is probably my favorite commit in the series.  I did the same
reverse-engineering a few months ago and didn't think to write it down
and save you having to do it.  Now you have saved the next person from
doing so.

This and your refactoring commits will cause me some annoyance as I
bring the rebase -i -p series up to date, but that just means I should
hurry up and get it in shape for merge rather than continue to have to
resolve conflicts.

Greg
