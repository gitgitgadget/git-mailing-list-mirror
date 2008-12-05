From: Dan Williams <dan.j.williams@intel.com>
Subject: [StGit] what happened to stg diff -r /{bottom|top}?
Date: Fri, 05 Dec 2008 09:54:33 -0700
Message-ID: <49395CC9.2010107@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 05 17:57:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8dy4-0006jN-FE
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 17:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbYLEQyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 11:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbYLEQyf
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 11:54:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:38278 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbYLEQye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 11:54:34 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 05 Dec 2008 08:48:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.33,721,1220252400"; 
   d="scan'208";a="411855110"
Received: from dwillia2-mobl1.amr.corp.intel.com (HELO [10.2.42.166]) ([10.2.42.166])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2008 08:50:07 -0800
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102404>

I noticed that with the latest StGit:
# stg diff -r /bottom
stg diff: /bottom: Unknown patch or revision name

Before I bisect to find where this disappeared, is there a different 
syntax I should be using?

Thanks,
Dan
