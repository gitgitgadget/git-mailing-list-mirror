From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: gitk says "file name too long"
Date: Thu, 25 Feb 2010 14:44:41 +0100
Message-ID: <hm5usf$6ba$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 14:45:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nke1d-0003lP-9G
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 14:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553Ab0BYNpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 08:45:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:47285 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932508Ab0BYNo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 08:44:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nke1R-0003hG-SZ
	for git@vger.kernel.org; Thu, 25 Feb 2010 14:44:57 +0100
Received: from berry.zib.de ([130.73.68.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 14:44:57 +0100
Received: from sschuberth by berry.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 14:44:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: berry.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141048>

Hi,

I'm having the same problem in msysGit as already described here in the 
msysGit issue tracker:

http://code.google.com/p/msysgit/issues/detail?id=387

The problem seems to be that for some reason gitk is launching "git 
rev-list" (in $cmd) with a ton of IDs (in $ids), resulting in a command 
line that is too long. So the error message does not come from gitk / 
tk, but from git rev-list. I'm getting the same error (argument list too 
long) if I manually enter the command at the shell.

Is anyone else experiencing this and has a solution? Is the problem 
rather that the list of IDs is wrong (and thus too long), or do we need 
to find a work-around to pass auch long command lines to git rev-list?

Thanks.

-- 
Sebastian Schuberth
