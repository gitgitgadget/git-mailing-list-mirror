From: Auke Kok <auke-jan.h.kok@intel.com>
Subject: stg pop/push -a nitpick: not handling deleted files
Date: Fri, 15 Sep 2006 10:19:40 -0700
Message-ID: <450AE0AC.7060806@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 19:22:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOHOQ-0007gO-NP
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 19:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWIORWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 13:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWIORWE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 13:22:04 -0400
Received: from mga03.intel.com ([143.182.124.21]:59008 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S932125AbWIORWB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 13:22:01 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by mga03.intel.com with ESMTP; 15 Sep 2006 10:22:00 -0700
Received: from scsmsx332.sc.intel.com (HELO scsmsx332.amr.corp.intel.com) ([10.3.90.6])
  by azsmga001.ch.intel.com with ESMTP; 15 Sep 2006 10:21:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,171,1157353200"; 
   d="scan'208"; a="117145411:sNHT9199370565"
Received: from ahkok-mobl.jf.intel.com ([134.134.3.190]) by scsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 15 Sep 2006 10:21:24 -0700
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ahkok-mobl.jf.intel.com (Postfix) with ESMTP id 97E023FF48
	for <git@vger.kernel.org>; Fri, 15 Sep 2006 10:19:40 -0700 (PDT)
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
To: git@vger.kernel.org
X-OriginalArrivalTime: 15 Sep 2006 17:21:24.0680 (UTC) FILETIME=[5ED88480:01C6D8EB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27092>


Hi,

minor nitpick when working with a patch that deletes a file: stg does not 
handle the 'abandoned' file when popping all patches off - essentially it would 
have to put the file back over an abandoned file.

I'm not sure what the resolution of this would be, but this problem could very 
well be anticipated (after all I just pushed/imported a patch removing the file 
to the stack).

Cheers,

Auke



$ stg pop -a
Popping "all_git_versions.patch" - "all_copyright_update.patch" 
patches...fatal: Untracked working tree file 'drivers/net/e1000/LICENSE' would 
be overwritten by merge.
stg pop: git-read-tree failed (local changes maybe?)
