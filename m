From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: non-monotonic index error
Date: Tue, 2 Sep 2008 15:57:54 -0400
Message-ID: <9e4733910809021257v3012ec89l64b2bb412ac1ebbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kac1n-0002bc-W8
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 21:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYIBT55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 15:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbYIBT55
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 15:57:57 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:22185 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYIBT54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 15:57:56 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1435271yxm.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=xUSLaQ6bfu3SaE6+4N2QOUwyy7IsFNbqhEzblp32csI=;
        b=HOeCvm/gVf5oEd0CQkX9rJu8ifbtQSQGOFWNgoNHFUsjfb+BOmReP1sK+6lehtQeFZ
         5updueIxAbUdzl2za9e+iTxu3E87I4mygRFsuEn3D8PnU/dEfLqiRCHcRmvttvpMnXsf
         hb9eo2pfduUsrLFuUq10W1XO2snV0NxkDhBOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=qARA/BZGMJrypAkfYca6alzpiCHWSznS+6pG3lOnUA8s9BqcvEJwyRtZIUknApF9iZ
         mf5jkYf4mGhnkx8pjCVKACm5xdSzl2DzZEfGhI2WOizIdtbr52FY3JlzLJt40rdVucxy
         8IlRiDpNDl62jNRUcOvv2gTgg+zG/W0MGgqqc=
Received: by 10.151.49.8 with SMTP id b8mr11036197ybk.180.1220385475006;
        Tue, 02 Sep 2008 12:57:55 -0700 (PDT)
Received: by 10.64.178.13 with HTTP; Tue, 2 Sep 2008 12:57:54 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94698>

I pulled from linus, did stg rebase linus/master, git push digispeaker
and got these errors.

Where's the problem, at my local machine or the digispeaker one? How
do I fix this?

jonsmirl@terra:~/fs$ stg --version
Stacked GIT 0.14.3.195.g36a0
git version 1.5.6.GIT
Python version 2.5.2 (r252:60911, Jul 31 2008, 17:31:22)
[GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
jonsmirl@terra:~/fs$

[digispeaker]$ git --version
git version 1.4.4.4


jonsmirl@terra:~/fs$ git push digispeaker
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: refs/heads/asoc-v2 does not point to a valid object!
error: refs/heads/i2c does not point to a valid object!
error: refs/heads/jean does not point to a valid object!
error: refs/heads/master-old does not point to a valid object!
error: refs/remotes/origin/HEAD does not point to a valid object!
error: refs/remotes/origin/master does not point to a valid object!
error: refs/tags/v2.6.26-rc7 does not point to a valid object!
error: refs/tags/v2.6.26-rc8 does not point to a valid object!
error: refs/tags/v2.6.27-rc2 does not point to a valid object!
error: refs/tags/v2.6.27-rc3 does not point to a valid object!
Counting objects: 714, done.
Compressing objects: 100% (235/235), done.
Writing objects: 100% (451/451), 106.87 KiB, done.
Total 451 (delta 351), reused 277 (delta 214)
Unpacking 451 objects
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
fatal: unresolved deltas left after unpacking
error: unpack failed: unpacker exited with error code
To ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to
'ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git'
jonsmirl@terra:~/fs$



-- 
Jon Smirl
jonsmirl@gmail.com
