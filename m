From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 2/2] builtin/apply.c: report error on failure to
 recognize input
Date: Sun, 04 Dec 2011 15:30:16 +0200
Organization: Intel OTC
Message-ID: <1323005418.9400.49.camel@sauron.fi.intel.com>
References: <1322944550-27344-1-git-send-email-drafnel@gmail.com>
	 <1322944550-27344-2-git-send-email-drafnel@gmail.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 04 14:29:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXC83-0007bD-S6
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 14:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab1LDN3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Dec 2011 08:29:12 -0500
Received: from mga14.intel.com ([143.182.124.37]:20403 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928Ab1LDN3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 08:29:09 -0500
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga102.ch.intel.com with ESMTP; 04 Dec 2011 05:29:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,293,1320652800"; 
   d="scan'208";a="43737211"
Received: from sauron.fi.intel.com (HELO [10.237.72.160]) ([10.237.72.160])
  by AZSMGA002.ch.intel.com with ESMTP; 04 Dec 2011 05:29:07 -0800
In-Reply-To: <1322944550-27344-2-git-send-email-drafnel@gmail.com>
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186266>

On Sat, 2011-12-03 at 14:35 -0600, Brandon Casey wrote:
> When git apply is passed something that is not a patch, it does not produce
> an error message or exit with a non-zero status if it was not actually
> "applying" the patch i.e. --check or --numstat etc were supplied on the
> command line.
> 
> Fix this by producing an error when apply fails to find any hunks whatsoever
> while parsing the patch.
> 
> This will cause some of the output formats (--numstat, --diffstat, etc) to
> produce an error when they formerly would have reported zero changes and
> exited successfully.  That seems like the correct behavior though.  Failure
> to recognize the input as a patch should be an error.
> 
> Plus, add a test.
> 
> Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>

Brandon, Thanks a lot for picking this. I did not reply because I did
not have time to look at this after your review yet, it was in my TODO
list. But I am happy you picked this and fixed the issue.

Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
Best Regards,
Artem Bityutskiy
