From: Sam Hocevar <sam@zoy.org>
Subject: msysgit corrupting commit messages?
Date: Fri, 6 Mar 2009 18:11:17 +0100
Message-ID: <20090306171117.GD12880@zoy.org>
References: <20090306155322.GC12880@zoy.org> <CYOA8Q1cpfGtE1Pp6_ETXfSJevKv9ADmYIuq6_whU0qskk289fiiUw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 18:13:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfdbU-0007J2-4w
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 18:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbZCFRLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 12:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbZCFRLU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 12:11:20 -0500
Received: from poulet.zoy.org ([80.65.228.129]:41278 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbZCFRLU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 12:11:20 -0500
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id CE8F11206C7; Fri,  6 Mar 2009 18:11:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CYOA8Q1cpfGtE1Pp6_ETXfSJevKv9ADmYIuq6_whU0qskk289fiiUw@cipher.nrlssc.navy.mil>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112469>

On Fri, Mar 06, 2009, Brandon Casey wrote:

> I get the impression that you do not intend for the comments above to be
> part of the commit message.  If that is true, then they should be placed
> further down after the '---' and before the diff-stat, or in some other
> way partitioned from the commit message (maybe using --->8--- notation).
> Otherwise they will _become_ part of the commit message if Junio applies
> this patch as-is.

   Okay. I'm definitely having a problem with git on MSYS. Is anyone
else seeing it butcher commits it exports? They appear fine in git log
or git log -p, but not in git format-patch. I've never had the problem
on a Linux system.

-- 
Sam.
