From: Uri Moszkowicz <uri@4refs.com>
Subject: Unexpected directories from read-tree
Date: Thu, 18 Oct 2012 18:10:38 -0500
Message-ID: <CAMJd5AQhcvWVwsZHPknAXvNpqnfqdCtx-xUv39Au1=x-1_ExMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 01:11:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOzFC-0002Pg-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 01:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab2JRXLC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 19:11:02 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:37847 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752819Ab2JRXLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 19:11:01 -0400
Received: (qmail 21760 invoked by uid 399); 18 Oct 2012 19:10:59 -0400
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 18 Oct 2012 19:10:59 -0400
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so14745358iea.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 16:10:59 -0700 (PDT)
Received: by 10.50.91.168 with SMTP id cf8mr6603803igb.20.1350601859281; Thu,
 18 Oct 2012 16:10:59 -0700 (PDT)
Received: by 10.64.15.7 with HTTP; Thu, 18 Oct 2012 16:10:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208030>

I'm testing out the sparse checkout feature of Git on my large (14GB)
repository and am running into a problem. When I add "dir1/" to
sparse-checkout and then run "git read-tree -mu HEAD" I see dir1 as
expected. But when I add "dir2/" to sparse-checkout and read-tree
again I see dir2 and dir3 appear and they're not nested. If I replace
"dir2/" with "dir3/" in the sparse-checkout file, then I see dir1 and
dir3 but not dir2 as expected again. How can I debug this problem?
