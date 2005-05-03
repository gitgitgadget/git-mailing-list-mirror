From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: commit-id fails after cg-init
Date: Tue, 3 May 2005 14:14:58 -0700
Message-ID: <20050503211458.GY4747@ca-server1.us.oracle.com>
References: <1115150585.28520.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 23:13:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4hM-0008Ct-3w
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVECVTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVECVTO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:19:14 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:15188 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261703AbVECVTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 17:19:10 -0400
Received: from rgmgw3.us.oracle.com (rgmgw3.us.oracle.com [138.1.191.12])
	by agminet02.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j43LExcO011218;
	Tue, 3 May 2005 16:14:59 -0500
Received: from rgmgw3.us.oracle.com (localhost [127.0.0.1])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j43LEwaF027356;
	Tue, 3 May 2005 15:14:59 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j43LEwo2027346;
	Tue, 3 May 2005 15:14:58 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.50)
	id 1DT4jK-0000nI-JU; Tue, 03 May 2005 14:14:58 -0700
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1115150585.28520.11.camel@dv>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 04:03:05PM -0400, Pavel Roskin wrote:
> So, cg-init created an empty .git/refs/heads/master and made .git/HEAD a
> symlink to it.  Now, commit-id reads that file and gets confused.
> 
> If anybody has an idea what to put to .git/refs/heads/master please
> speak up so that cg-init could be fixed.

	Well, cg-init in this case creates no objects.  I'd say,
instead, it should create an empty tree object (representing a project
with no files) and commit that.  That would be your initial commit, and
would put something valid in heads/master.

Joel

-- 

"The cynics are right nine times out of ten."  
        - H. L. Mencken

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
