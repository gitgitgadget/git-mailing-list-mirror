From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Fri, 02 Sep 2011 17:18:21 -0400
Message-ID: <1314998301.19039.117.camel@ddn-tmpdesk.its.maine.edu>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 23:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qzb8M-00038m-OX
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 23:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab1IBVSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 17:18:36 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:34706 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927Ab1IBVSg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 17:18:36 -0400
Received: from [130.111.39.171] (ddn-tmpdesk.its.maine.edu [130.111.39.171])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p82LILfb015265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 2 Sep 2011 17:18:21 -0400
In-Reply-To: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p82LILfb015265
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1315603106.25516@tt7P7J1eCpqcNgO6sjvSnw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180637>

On Fri, 2011-09-02 at 14:04 -0700, Anatol Pomozov wrote:

> -	linkgit:git-config[1].
> +	linkgit:git-config[1]. Note that if this option is specified
> +	then only tags are fetched, refs under refs/heads/* stay unchanged.

Anatol,
Looks like a sane change to me. You might want to check
Documentation/SubmittingPatches in the git repository if you want Junio
to include your patch. It is probably also worth CC-ing those whom did
the previous work on that documentation and the tags code to make sure
your change is correct.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
