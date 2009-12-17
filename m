From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: core.autocrlf & Cygwin - files incorrectly flagged as modified
Date: Thu, 17 Dec 2009 08:00:35 +0100
Message-ID: <200912170800.35752.robin.rosenberg@dewire.com>
References: <loom.20091215T225528-115@post.gmane.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Antliff <david.antliff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 08:00:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLALx-0004g7-AH
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 08:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977AbZLQHAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 02:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756327AbZLQHAl
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 02:00:41 -0500
Received: from mail.dewire.com ([83.140.172.130]:10041 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbZLQHAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 02:00:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 38B30145A5AE;
	Thu, 17 Dec 2009 08:00:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c8FqG00BRSNb; Thu, 17 Dec 2009 08:00:37 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A61D613F4115;
	Thu, 17 Dec 2009 08:00:37 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-generic; KDE/4.3.2; i686; ; )
In-Reply-To: <loom.20091215T225528-115@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135359>

tisdag 15 december 2009 23:24:15 skrev  David Antliff:
> I approached the Cygwin mailing list about this problem, and the package
> maintainer suggested I ask here as well, in case someone can shed some
>  light on this.
> 
> I am using git-1.6.4.2 (as part of Cygwin-1.7 beta) and I've observed some
> behaviour that seems wrong to me.
> 
> When we deployed git on Cygwin, we decided to set core.autocrlf=true, as
>  many of our users are working with DOS/Windows files (CRLF endings). Some
>  users are using Linux and working on the same code. I'm not actually sure
>  why we chose to use this setting - there's a lot of conflicting advice
>  around. I think the final decision was made so that kdiff3 would operate
>  correctly. However we did go to lengths to ensure that everyone is using
>  the same configuration setting.
> 
> The problem is that sometimes, after a git-clone, the output of git-status
>  and git-diff shows entire files as being different. However these files
>  have not been modified by the user - only git has had a chance to change
>  them (due to autocrlf=true). But surely if git has converted the file
>  automatically, it should know that it has to compensate for this when
>  comparing with the local repository?

AFAIK, this happens if you have CRLF line endings in the blobs in the repo.

-- robin
