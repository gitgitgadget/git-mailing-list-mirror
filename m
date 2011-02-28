From: Perry Smith <pedzsan@gmail.com>
Subject: AIX problems
Date: Mon, 28 Feb 2011 13:16:40 -0600
Message-ID: <EFD0AEC9-BEF8-412C-920F-DE6FAADBA544@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 20:16:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu8aS-0000bt-GL
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 20:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab1B1TQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 14:16:47 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41477 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab1B1TQr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 14:16:47 -0500
Received: by vxi39 with SMTP id 39so3434552vxi.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 11:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:to:mime-version:x-mailer;
        bh=k0M41VzNqYW1TAfHgwanQv4qkEWuFRtN+cKsdD6Unmk=;
        b=VyxKvmC9uyGq1WlaXx2w1S/8RwM8Ho34Swt3JJEU+uiJej0j/geXZqCMS35jyixBU6
         bf2JcCVZ1n91lY25Yp1t4GfN9IHMbSmyuZdG6lpLd4cwohIhA0Tya299SzFMwbEByQRV
         nPiM1HMg8OYgkSU3K1LnDnAXYHneDsZAz1hCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=EqMxvL9dbrUlhd7dz6lf19IP6kfuzW+HSJcXHApzuwPeAP6mt/aRIle4iFeZKqeMhw
         xshlqfGq2B54CKE0PsqlhV60seLgZCKzBv1FRJ9x5qeoZU4p1AEK8agqL35opwrVC8M/
         HOb+gFLZrmmRMvSbZS83+u/nA3NwF0u+tXmA0=
Received: by 10.52.93.193 with SMTP id cw1mr2899244vdb.151.1298920602531;
        Mon, 28 Feb 2011 11:16:42 -0800 (PST)
Received: from dyn864894.austin.ibm.com ([32.97.110.54])
        by mx.google.com with ESMTPS id n13sm1779625vcr.17.2011.02.28.11.16.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 11:16:41 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168134>

I forked rvm on github.com, pulled down a copy, made a small change, did a comment, and tried to do a push and got back this:

git push
fatal: bad object b0dfdc67dcd5e466d2e0799e38727d065882edcf
error: pack-objects died with strange error
error: failed to push some refs to 'git@github.com:pedz/rvm.git'

I deleted the fork, recreated it, tried again, got the same issue.

Surfing the web, it was suggested I upgrade.  I'm currently at 1.6.1.  So, ok... I pulled down the newest copy and tried to build it and I died with:

make
    SUBDIR perl
    SUBDIR git_remote_helpers
gmake[1]: /usr/bin/python: Command not found
gmake[1]: *** [all] Error 127
gmake: *** [all] Error 2

I don't have python and even if I did, it would not be in /usr/bin.  Does git now depend upon Python?  That is such a lame language... I hope not.  Is there any way to build git without python?  If I have to get Python -- which Python.  My biggest complaint with Python is it is so incompatible with itself.

I can't find how to subscribe to this list so please remember to CC me on any replies.

Thank you,
Perry
