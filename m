From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: [PATCH] provide a new "theirs" strategy, useful for rebase --onto
Date: Fri, 6 Jun 2008 12:27:47 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0806061226510.12829@ds9.cixit.se>
References: <E1K4a1Q-0002hq-QE@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 13:29:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4a7i-0004PW-RQ
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 13:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbYFFL1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 07:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbYFFL1y
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 07:27:54 -0400
Received: from ds9.cixit.se ([193.15.169.228]:44656 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbYFFL1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 07:27:54 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m56BRl5e002965
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Jun 2008 13:27:47 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m56BRlGU002960;
	Fri, 6 Jun 2008 13:27:47 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <E1K4a1Q-0002hq-QE@fencepost.gnu.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 06 Jun 2008 13:27:47 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84048>

Paolo Bonzini:

I found a typo in the documentation:

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
[...]
> +The merge strategy `-s theirs` resolves conflicts in favor of the commits
> +being rebased---in this case, you know that the only conflicts will occur
> +when replaying E', and you definitely E'' to have those changes.

It should say "...you definitely *want* E'' to have..."

-- 
\\// Peter - http://www.softwolves.pp.se/
