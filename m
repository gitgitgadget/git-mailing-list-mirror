From: David Lee <davidomundo@gmail.com>
Subject: Separate default remotes for pulling and pushing
Date: Sat, 7 May 2011 01:10:14 -0700
Message-ID: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 10:10:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIcao-0008Qx-AB
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 10:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab1EGIKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 04:10:20 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49858 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1EGIKS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2011 04:10:18 -0400
Received: by pvg12 with SMTP id 12so1731299pvg.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:to:mime-version:x-mailer;
        bh=aaGachg+iX6d8SOaZ1fRmXcJEw+P8nUgkdxH2WyGxkE=;
        b=qVgAYND6Cs5R0gT8UdWUa0r57dyBBPbD+H942j6SObrxlmcQPkmDeip6IgXauc+MwZ
         SRSm/PeOc4gV5Wbd4ewXZ3ws2wzOyp57m5v5uhmqvA25CCAeJF752DGux0jCVC77lil5
         Qw7YwD761Lp1khkkStO4zi+f2RkgNkwXIeuDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=PKIQfCXPTMuLJEej/NuMoKIGV3zIm7lLmrQSYZJpRG1oyatBnl+BXXVfq1h8tXl5hA
         OH3DYieIGUpd2ITwngu9wtsN5PyVOXHle8oD7kOwra2qBzc8oNqCfp3mpmnB+z8M6KcT
         GD1RKG0vzdbV9glfBXxoo6a09L5Cka1vNEnkw=
Received: by 10.68.30.71 with SMTP id q7mr6065206pbh.519.1304755818451;
        Sat, 07 May 2011 01:10:18 -0700 (PDT)
Received: from [192.168.111.253] (c-24-130-22-226.hsd1.ca.comcast.net [24.130.22.226])
        by mx.google.com with ESMTPS id q10sm2685561pbk.39.2011.05.07.01.10.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 01:10:16 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173040>

Hello,

I couldn't find a way to do this, but it seems it would be a fairly common use-case:

I want to set up different default remotes for pushing and pulling so that I can pull from remote a using "git pull" and push to remote b using "git push". This is particularly useful when committing to projects on github, since you may only push to your fork, but you only want to pull updates from the original.

Right now, I can either set the original as my default remote, in which case I must use "git push myfork", or I can set my fork as the default remote, in which case I must use "git pull original".

Please let me know if I'm overlooking a feature already present in git that allows me to have separate remotes for pull and push. Otherwise, I hope it gets implemented in the next version of git!

Thanks for reading,
David