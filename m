From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: git-diff-tree for the first commit
Date: Thu, 19 May 2005 22:38:39 +0200
Message-ID: <20050519203839.GJ8105@cip.informatik.uni-erlangen.de>
References: <20050519195110.GG8105@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505191323060.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 19 22:38:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYrmB-000096-6M
	for gcvg-git@gmane.org; Thu, 19 May 2005 22:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVESUim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 16:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVESUim
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 16:38:42 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:47526 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261245AbVESUik (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 16:38:40 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4JKcdS8000249
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 19 May 2005 20:38:39 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4JKcdds000248
	for git@vger.kernel.org; Thu, 19 May 2005 22:38:39 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505191323060.2322@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I see. Thanks for the elaboration. I got the idea now. ;-)

> That said, a new flag that says "diff the root against the NUL tree" 
> wouldn't be wrong either, for when that is what you want.

I want it for the following scenario:

My git frontend sets the time stamps of the checked-out files to the
time of the last modification. That way I can do a 'ls -lart' in a sub
directory and have the most recently touched files on bottom.  I also
want to use this for keyword expansion.

I currently do it by calling more or less 'git-rev-tool HEAD' and
'git-diff-tree -r REVISION' and cache the output. However for the inital
import are no 'timestamps' available. Now I can do two things. Implement
a git-diff-tree flag or assume that any files which don't have a delta
are imported by the initial tree.


Ideas?

	Thomas
