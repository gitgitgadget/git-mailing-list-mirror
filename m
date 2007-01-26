From: Andy Parkins <andyparkins@gmail.com>
Subject: git branch -D won't delete the branch you're on
Date: Fri, 26 Jan 2007 12:00:47 +0000
Message-ID: <200701261200.48813.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 13:01:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAPll-00017g-4b
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 13:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965408AbXAZMAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 07:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965465AbXAZMAy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 07:00:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:40708 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408AbXAZMAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 07:00:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so698367uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 04:00:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MhSw9f4qJr7oQgiUJ9mVnEOA3/PhnitVA+7oxsImciJiQJMhN+3td2uKPY4OHMWxpkiWCfAJUD98ol2DQ265WzcupyIWscHf1NavKJxN+XhRxVj+btA4xOm/kfSrcVlAKn929+o0peELfJWlokgEN0+jgjaTXISfS9L3KauZW+c=
Received: by 10.66.255.7 with SMTP id c7mr4214803ugi.1169812852053;
        Fri, 26 Jan 2007 04:00:52 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id k30sm4250702ugc.2007.01.26.04.00.51;
        Fri, 26 Jan 2007 04:00:51 -0800 (PST)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37848>

Hello,

Minor nitpick, that is not dreadfully important, but now that we have the 
detached HEAD facility, is it reasonable to expect this to work?

 $ git checkout -b somebranch HEAD^
 $ git branch -d somebranch
 error: Cannot delete the branch 'testcvs' which you are currently on.

Especially given that this will work (albeit with a warning):

 $ git checkout HEAD^
 warning: you are not on ANY branch anymore.
 If you meant to create a new branch from the commit, you need -b to
 associate a new branch with the wanted checkout.  Example:
   git checkout -b <new_branch_name> HEAD^




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
