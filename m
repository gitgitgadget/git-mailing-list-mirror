From: "Rajkumar S" <rajkumars@gmail.com>
Subject: StGit: Notice: no parent remote declared for stack
Date: Fri, 20 Apr 2007 10:50:49 +0530
Message-ID: <64de5c8b0704192220j6f5f9493md91a33f537ebb25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 07:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HelYH-0001VL-T3
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 07:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbXDTFUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 01:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbXDTFUy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 01:20:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:45406 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161039AbXDTFUx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 01:20:53 -0400
Received: by nz-out-0506.google.com with SMTP id s1so659349nze
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 22:20:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mj0u6WsR/5sIKWvo9QZo1RUyRi4EWnMCjm8XiWraToGqRG83DA1dGtljTcMpjUJlS4pr8WBuKSgr9DopITJRsqleQbD2nfhtd63EuPsDW7kmormhRkgVrXS60F5BD3LvxLZxEYYwAP/YCrB57R+0zTl6DbvVjEeIqbCcqcAXBZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C09B6h9L3LhPhgcGOpSm2apguF0Q0i5PmNgLnF2TAepaE3n11J1xgpMPu5whTb9DuFofC6TlObcQ7pzzk1sbFOZOpYp0fg9kbHZVbyhvR56k6te5or92IiXg/fBdHPlBgaR4yoOZlkSzWyR8TATf5UD9pyQtTBvdtEyD8XooBps=
Received: by 10.114.184.16 with SMTP id h16mr1095665waf.1177046449156;
        Thu, 19 Apr 2007 22:20:49 -0700 (PDT)
Received: by 10.114.255.4 with HTTP; Thu, 19 Apr 2007 22:20:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45062>

Hi,

I am following another git repository with StGit. In the remote
repository I am following RELENG_1_2 branch.

I created the StGit repository using stg clone and then changed to
RELENG_1_2 branch and did a stg init and edited the
.git/remotes/origin to

URL: /usr/local/upstream/.git
Pull: refs/heads/RELENG_1_2:refs/heads/RELENG_1_2

When I do an stg pull I get the following error:

Notice: no parent remote declared for stack "RELENG_1_2", defaulting
to "origin". Consider setting "branch.RELENG_1_2.remote" and
"branch.RELENG_1_2.merge" with "git repo-config".

What should I set branch.RELENG_1_2.remote and branch.RELENG_1_2.merge
to ? a sample command would be very helpful as I am not very much upto
speed with git repo-config

raj
