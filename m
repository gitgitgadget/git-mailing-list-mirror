From: Richard Rossel <rrossel@inf.utfsm.cl>
Subject: How to commit bug fixes from old revisions
Date: Fri, 18 Dec 2009 12:02:05 -0300
Message-ID: <4B2B996D.9070302@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 16:02:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLeLd-0003Bf-0n
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 16:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbZLRPCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 10:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZLRPCQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 10:02:16 -0500
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:49456 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbZLRPCP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 10:02:15 -0500
Received: from trompe.intra.wiseocean.cl (red-corfo.tecnoera.net [200.24.238.226] (may be forged))
	(authenticated bits=0)
	by alegre.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id nBIF25iB006361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 18 Dec 2009 12:02:05 -0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.0rc1 (alegre.inf.utfsm.cl [204.87.169.3]); Fri, 18 Dec 2009 12:02:05 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.94.2/10197/Thu Dec 17 22:59:38 2009 on alegre.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RDNS_NONE
	autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on alegre.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135413>

Hi,
I'm confused with how to commit bug fixes from old tagged version.
Lets says that I have a serie of tags (v1.0, v1.1, v1.2, v2.0) in master,
and there is a bug from v.1.2. The bug was fixed, but I don't
want to merge to v2.0, because there are not compatibles. The bug fixed 
should be
tagged as v1.3

So the question is how to commit between revisions( in the example, 
between v.1.2 and v2.0),
without made any change in the HEAD of master (v2.0)

Or maybe the solution is to separate the versions  in different branches 
or different repos.

Thanks for the help

-- 
Richard Rossel
Software Engineer at Airsage Inc.
Valparaiso - Chile
