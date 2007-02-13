From: Andy Parkins <andyparkins@gmail.com>
Subject: git-cvsserver doesn't respect core.sharedrepository
Date: Tue, 13 Feb 2007 14:38:27 +0000
Message-ID: <200702131438.30291.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 15:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGyo3-0001tc-FN
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 15:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbXBMOiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 09:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbXBMOiw
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 09:38:52 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:3800 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbXBMOiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 09:38:51 -0500
Received: by wr-out-0506.google.com with SMTP id i21so2204291wra
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 06:38:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LvBaxRlB7/OC9ELxCJb/ektMxIctktmzwka+Vutu+y4dpTizTCdOo6gE7/tgXbBdbIwILjzzcQYbziVoHI7gHOhIY2HoMHl9Bo9kS9uaEsIN1i+M/Y5NSQ8pR5r9IGKcXU6G92EihBBy9IM1snLVI0Bd5JMXuzchw9e823yu1q4=
Received: by 10.90.49.1 with SMTP id w1mr19173218agw.1171377515610;
        Tue, 13 Feb 2007 06:38:35 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id e33sm12224560ugd.2007.02.13.06.38.32;
        Tue, 13 Feb 2007 06:38:32 -0800 (PST)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39529>

Hello,

I'm using git-cvsserver with a repository that has core.sharedrepository set 
to "group".  After a commit has been pushed using git-cvsserver I have to 
correct the permissions again.

I suspect then that git-cvsserver is somehow bypassing git's normal fixing of 
the permissions bits.  I'm not entirely sure though, as I can't entirely see 
how the calling of path.c:adjust_shared_perm() can be avoided.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
