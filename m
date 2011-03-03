From: allstars <allstars.chh@gmail.com>
Subject: 1 patch to two branches
Date: Thu, 3 Mar 2011 04:46:36 -0800 (PST)
Message-ID: <38ac3be3-8d09-4a38-b31e-9365fe0f2992@v11g2000prb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 14:27:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv8Yb-0001XP-LW
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 14:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248Ab1CCN01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 08:26:27 -0500
Received: from mail-gx0-f184.google.com ([209.85.161.184]:43680 "EHLO
	mail-gx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757974Ab1CCN0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 08:26:24 -0500
X-Greylist: delayed 2387 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Mar 2011 08:26:24 EST
Received: by gxk20 with SMTP id 20so741988gxk.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 05:26:23 -0800 (PST)
Received: by 10.91.123.15 with SMTP id a15mr174454agn.59.1299156396179; Thu,
 03 Mar 2011 04:46:36 -0800 (PST)
Received: by v11g2000prb.googlegroups.com with HTTP; Thu, 3 Mar 2011 04:46:36
 -0800 (PST)
X-IP: 211.22.63.249
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.13
 (KHTML, like Gecko) Chrome/9.0.597.107 Safari/534.13,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168392>

hi
my case is as follows
I have two branches
basically they are the same, except they differ from different package
name(java) and namespace(cpp) due to customer request

but now I have a fix , say a patch
I want to commit it to both branches

but I am lazy so I just want to do just one 'git commit' and 'git
push'

so I am thinking using a githook in remote server
and each commit to branch A can also commit to branch B as well

but I am not quite sure what I should use in the hook

git rebase , git merge or git cherry pick ?

seems these 3 ways all lead to the same result
but I dont know which is better and why


thanks
