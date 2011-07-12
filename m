From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [ANNOUNCEMENT] two new tools in InterfacesFrontendsAndTools
Date: Tue, 12 Jul 2011 21:36:20 +0200
Message-ID: <CAKPyHN0JFfurvuMxBsqAo2n6m3-Nt3BnWCGaqxMQMiEYqQo4KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 21:36:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgiku-0000ho-36
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 21:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129Ab1GLTgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 15:36:22 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60756 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab1GLTgW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 15:36:22 -0400
Received: by vxb39 with SMTP id 39so3690202vxb.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=usoJ5hgR21b/7v25S8ORSiIhT7mPqwbjB6xmK0FfOO8=;
        b=vGC2X4cXltl2/0t+voMv3ns8MAK4Qr/CUg+fhW5IP7Yj0ofSp1AzVzQsOY67a488mQ
         H6Ax4fwPbb+mq3bosr5Po742PInWqj0qqVN+6Kg0p+fjokHCoY650BphgIFNbGnfbzwb
         pFpPSFsvm0vmAoH4qpiYf3v0biamkl6xMESjM=
Received: by 10.52.111.200 with SMTP id ik8mr7939vdb.128.1310499380924; Tue,
 12 Jul 2011 12:36:20 -0700 (PDT)
Received: by 10.52.185.105 with HTTP; Tue, 12 Jul 2011 12:36:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176969>

Hi everyone,

I added two new tools to the git wiki. Here is a copy of the descriptions:

* git-edit-index[1] is a tool which lets you edit files directly from
the index, without changing the working copy. The temporary file sits
next to the original file, and the index will be updated with the new
content (including the file mode).

* git-build is a tool which records the output from an arbitrary
command, but also the state of the working directory (including
untracked but not ignored files), the start directory used, and the
exit status of the command by creating a commit of these and storing
it in a special ref refs/builds/default. The commit message is the
command. The author date is set to the start date and the committer
date to that of the end date of the command. The reflog is used to
automatically discard old records. My main intention is to use this
for builds, such as './configure && make && make check'. Thats why
this is called git-build, and also to have a command history by using
the reflog. Dumping the environment at command start is on my TODO.
Any other hints what should be recored is welcomed.

Any feedback is welcomed.

Regards,
Bert

[1] http://kgb2.thruhere.net/git/?p=bertw/homerc.git;a=blob_plain;f=bin/git-edit-index
[2] http://kgb2.thruhere.net/git/?p=bertw/homerc.git;a=blob_plain;f=bin/git-build
