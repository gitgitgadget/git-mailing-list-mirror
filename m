From: "Pat Maddox" <pergesu@gmail.com>
Subject: How do I set the committer with cherry-pick? (or is there a better way to get changes from someone?)
Date: Sat, 5 Apr 2008 16:42:55 -0700
Message-ID: <810a540e0804051642r79dc10a7h2a231561062b13ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 01:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiI39-0004VB-Tw
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 01:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbYDEXm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 19:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbYDEXm4
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 19:42:56 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:5020 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbYDEXm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 19:42:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so641974wah.23
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=xyfTb+o1QDmu5IqDCwmnDLzTCLZYIw9fuWZc1jW29nI=;
        b=xIcNBpg52xeLRG6Ygar7FBD8R6cufC2zD4oFaZ9yKBZ5r88eyEOswTtV4NdPQb9Jo9nyCOKONvLCOpYWNxUwcp3Y3RCviL8r/YgSQ0nEfDBV1B9KeAH7JAPqyngEyjzhrqxRpKZx1QOxr98fO7W8mPAOFxQ0oAL24fNhwkJ/04E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WfcqUGT+2TB7ksoTYfjZtTxu7sOBb/yjxX8xRqwDfYRArx0VEhS675Ci2yHd6YOtw0z+ko0qY+UOKGerP4s4lc+3dQi1MOKsCKK9A8Nll/hLCd6nFJLn0Thujo3buRzO8bIThmHmMDsJZCcLSgRaOyqc4D/oxvKba/lz0tRb91w=
Received: by 10.114.56.1 with SMTP id e1mr4289339waa.52.1207438975690;
        Sat, 05 Apr 2008 16:42:55 -0700 (PDT)
Received: by 10.114.146.5 with HTTP; Sat, 5 Apr 2008 16:42:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78868>

I'm helping to maintain a project, so people send me requests to pull
from their repos.  So I create a branch and then pull their stuff in,
taking a look at the various different commits.  I write the commit
numbers that I want to cherry pick to a file (also is there a better
way of handling this?  it's a bit tedious.  it'd be nice to mark
certain commits for cherry picking and then suck them all in later).
Then when I've gone through all the new commits and chosen the ones I
want, I check out the master branch and cherry-pick those commits in.

At this point the commits are in the repo, but they only have author
information.  I'd like to specify that I'm the one who committed this
change now.  How can I do that?

And finally, is this a good way to incorporate changes from other
devs?  Is there a better way?

Pat
