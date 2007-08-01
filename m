From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Why does git-svn dcommit rewrite the log messages?
Date: Wed, 1 Aug 2007 17:19:19 -0400
Message-ID: <e2a1d0aa0708011419m1f6cb323ge9e93680147a298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGLbM-0006vB-3e
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 23:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbXHAVTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 17:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbXHAVTV
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 17:19:21 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:43426 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXHAVTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 17:19:20 -0400
Received: by wa-out-1112.google.com with SMTP id v27so306909wah
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 14:19:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H7CBbGln+CDkwcoHAKhvHMlB684+dGHzDdqJEDyF9wsPYLcoCu4ISwcvs+QNXXMLhSfthnW4w6kHbLRwowg7aOKKNHm86rXYPaN/n7BirfX2bg+2ZlnvnwGSF/eGcy+KE6gCr7kT8GwqQp5Q6J2uGbROc4XdzcdCVcZEqeHskLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HbIBHhlEO4TJeCpf4U98Ksk7mU2pSr9aStKy7f/IUTC2DHNO8jJf+XiPynwkdpvxNX2PYYadzVLnIAlVv9yGsZD+gveEJX9IwKPuG4B9aBplj2By0x0VIaCCSvedqin0b69TYvjG5vlnM7IK2vp1HpJORfJ9lQWcZzSyzlH6FUE=
Received: by 10.114.112.1 with SMTP id k1mr1133145wac.1186003159676;
        Wed, 01 Aug 2007 14:19:19 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Wed, 1 Aug 2007 14:19:19 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54478>

I see that it appends text to the log messages with the SVN repository
revision and ID.  Does it do that because:

1) That's the _only_ way to keep git & svn in sync
If so, then I guess I'm out of luck.  But it seems (to my
inexperienced eye) to make branching impossible in git -- as soon as I
do a "git-svn dcommit", I lose the commit on which my branch was
originally based.  Or, am I missing something?

2) That was the simplest way to keep them in sync at the time git-svn
was written and it hasn't bothered anybody enough to go back and fix
it.
If so, I'd be glad to see what I could do to fix it.  I would also
appreciate any pointers folks might care to give to get me started.

--wpd
