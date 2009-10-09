From: Auguste Mome <augustmome@gmail.com>
Subject: can't create a branch on remote
Date: Fri, 9 Oct 2009 23:35:03 +0200
Message-ID: <17cb70ee0910091435l4c4d1736hf4d403a2fe6331a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 23:46:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwNID-0004vf-L6
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 23:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761480AbZJIVgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 17:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761478AbZJIVgM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 17:36:12 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:12345 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761477AbZJIVgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 17:36:11 -0400
Received: by ey-out-2122.google.com with SMTP id 4so1560843eyf.19
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 14:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=wsnACvy3T5lpl0LAhb0VY0gQMEJgW4wEg3eNdJhJTQk=;
        b=F0p9a4IOUktQjWCvJ7m1xllfPkHxZSkRUAFww0ZYf4upFmzWa+hrD7KhN0D8YTdl6i
         dULBXgpb2u6Nbt6TTSFTLgBuumhMjzQIHfKBtcCCT+GEZzjzVXK4ynKZ+m7Nc+VoC6c8
         9P/75gLAQPaDDDwEGJl98FFzprMpTgTmbfRNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Y3grMmfjKm4W+G4iagCRsNQvdt4TU1tNMFkyGMlfLxkYWqYYLD5EKSKM0U2j/4fYxv
         RHpLVCl7uytF/yRc7yJUyQO+2RxwynPezv9uMgNSoBXmpncbzx5Mt3bq6ZCYCJFmuT6H
         Wo0WZ9T8oe1m0NK5t1yuqfgZ1L6RzTHzmlAcE=
Received: by 10.216.86.74 with SMTP id v52mr1083520wee.124.1255124103953; Fri, 
	09 Oct 2009 14:35:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129844>

Hi,
I have two repositories=A0 /home/user/linux and /home/user/dev/linux,
same user on same machine.
Here is how I create a local branch at v2.6.21.7 in /home/user/dev/linu=
x,
#pwd
/home/user/dev/linux
# git remote add l2621
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.21.y.git
# git fetch l2621
# git branch mylocal26217=A0 v2.6.21.7

Now I would like to do the same from the other repository /home/user/li=
nux:
# pwd
/home/user/linux
# git remote add other /home/guerin/dev/git/linux-2.6
# git fetch other
# git push /home/user/dev/git/linux-2.6
=A0=A0=A0 v2.6.21.7:refs/heads/new_feature_name26217
Total 0 (delta 0), reused 0 (delta 0)
error: Trying to write non-commit object
170684ef0557d4b711a86595d31dcbebcb9d4ba2 to branch
refs/heads/new_feature_name26217
To /home/user/dev/git/linux-2.6
=A0! [remote rejected] v2.6.21.7 -> new_feature_name26217 (failed to wr=
ite)
error: failed to push some refs to '/home/user/dev/git/linux-2.6'

Maybe something to configure to authorize the creation of branch?

Thanks,
Auguste.
