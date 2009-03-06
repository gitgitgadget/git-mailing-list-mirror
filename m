From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-p4: remove unnecessary semicolons at end of lines
Date: Fri, 06 Mar 2009 10:55:35 -0600
Message-ID: <CYOA8Q1cpfGtE1Pp6_ETXfSJevKv9ADmYIuq6_whU0qskk289fiiUw@cipher.nrlssc.navy.mil>
References: <20090306155322.GC12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:57:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfdMC-0000V4-E9
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbZCFQzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbZCFQzj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:55:39 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53157 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbZCFQzj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:55:39 -0500
Received: by mail.nrlssc.navy.mil id n26GtalA006094; Fri, 6 Mar 2009 10:55:36 -0600
In-Reply-To: <20090306155322.GC12880@zoy.org>
X-OriginalArrivalTime: 06 Mar 2009 16:55:36.0073 (UTC) FILETIME=[5ED21790:01C99E7C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112466>

Sam Hocevar wrote:
>    This is a purely cosmetic patch that makes the git-p4 code look more
> pythonish by getting rid of end-of-line semicolons.


I get the impression that you do not intend for the comments above to be
part of the commit message.  If that is true, then they should be placed
further down after the '---' and before the diff-stat, or in some other
way partitioned from the commit message (maybe using --->8--- notation).
Otherwise they will _become_ part of the commit message if Junio applies
this patch as-is.

-brandon


> git-p4: remove unnecessary semicolons at end of lines.
> 
> Signed-off-by: Sam Hocevar <sam@zoy.org>
> ---


Comments not intended to be part of the commit message go here, where they
will be ignored by git-apply.


>  contrib/fast-import/git-p4 |   46 ++++++++++++++++++++++----------------------
>  1 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 3832f60..7ea5ac6 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -12,7 +12,7 @@ import optparse, sys, os, marshal, popen2, subprocess, shelve
<snip>
