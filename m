From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] stgit: unexpected "unknown user details" on refresh
Date: Fri, 5 Jan 2007 00:22:24 +0100
Message-ID: <20070104232224.GA12756@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 00:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2buo-00059k-TS
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 00:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbXADXW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 18:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbXADXW2
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 18:22:28 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:39516 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030263AbXADXW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 18:22:27 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id ADF1D27A76;
	Fri,  5 Jan 2007 00:22:25 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 82CE51F08C; Fri,  5 Jan 2007 00:22:24 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35959>

Hi Catalin,

Here is an error I just got when refreshing.  The refresh did occur, but
the error is annoying and may hide something:

dwitch@gandelf:/export/work/yann/git/stgit$ ./stg ref contrib/stg-whatchanged
Checking for changes in the working directory... done
Refreshing patch "whatchanged"...stg ref: unknown user details

dwitch@gandelf:/export/work/yann/git/stgit$ echo $?
2


When using "refresh -p", we can see the error occurs before rewinding to
current patch:

dwitch@gandelf:/export/work/yann/git/stgit$ ./stg ref -p show-old
Checking for changes in the working directory... done
Popping patch "whatchanged"... done
Refreshing patch "show-old"...stg ref: unknown user details

dwitch@gandelf:/export/work/yann/git/stgit$ stg top
show-old
