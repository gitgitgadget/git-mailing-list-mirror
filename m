From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Importing Mozilla CVS into git
Date: Thu, 1 Jun 2006 18:21:54 -0400
Message-ID: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 02 00:22:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlvYE-0003KA-NG
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 00:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWFAWV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 18:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWFAWV4
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 18:21:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:4881 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750773AbWFAWVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 18:21:55 -0400
Received: by nz-out-0102.google.com with SMTP id s18so397541nze
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 15:21:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Bvt51S0SqaDI1TNy+5GzfWUNv7DTz/X3gUlzzTIVRbpL0RCYkdewLr2F/z9zxmhbPuhIs9xjpKdO7mCvMfaGIsV/j/kQr651SKwyEPTySr3GX4CQEkan9zaOr9xsVHLWq36PNpI/Jpk2wxQFUwgs9rRUt1Jc9YSowHfb+jOq1OU=
Received: by 10.36.158.2 with SMTP id g2mr1593625nze;
        Thu, 01 Jun 2006 15:21:55 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Thu, 1 Jun 2006 15:21:54 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21124>

I've been working on importing the Mozilla CVS into git for the last
few days. I've fixed up parsecvs so that it can parse the entire
repository without errors. Now I'm running into problems because there
are over 300 branches.

I just run into a problem with git show-branch. Mozilla CVS has a lot
more than 29 refs, is this something that can be expanded?

Is anyone interested in helping out with this? My knowledge of git and
CVS is limited. Mozilla CVS is about 3GB and it is available via
rsync. I can post the parsecvs changes if wanted.

rsync -az cvs-mirror.mozilla.org::mozilla ~/mozilla/cvs-mirror

-- 
Jon Smirl
jonsmirl@gmail.com
