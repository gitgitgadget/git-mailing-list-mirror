From: Albert Netymk <albertnetymk@gmail.com>
Subject: git-diff-index man page
Date: Sat, 18 May 2013 18:26:11 +0200
Message-ID: <CAKEGsXQDB1=hizNqM6D=uuP6PXT4ytUiTgB5fvO-gVSsPqQkLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 18:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udjxt-0002XC-2M
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 18:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab3ERQ0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 12:26:33 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:46310 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3ERQ0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 12:26:32 -0400
Received: by mail-da0-f42.google.com with SMTP id r6so1720646dad.29
        for <git@vger.kernel.org>; Sat, 18 May 2013 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=ceIJ6Qfsk+6LDnP9usgrzly+T5GAqpmnOldPsseng0s=;
        b=phor24sDzwR3/NU2xp4eRgDxKFbj5fCmAglxDcUQRai7gMVtVJaLLtyCLaNgk+qXKs
         a/jb2hW5FmHHQuZgxIKNhfGb+GwfqfMIg6HD2BUII05poWmxHupeYk+/Hu49YfSe5Vfp
         pA1b1IJhH+IilA5vxyDrdN7kExAbPo/koHBP+gZqCplkN4tUi/TjLVVz/H01rRV6+H/2
         zazzqPShI8iSxKrofPrM9M4MzN6tRMlDJOznO6+elnBB+LI6JOpFuU/Y/2WedkiHQ97l
         xg839zGtWW0WWMXCrzmBpSv0mIgMCd2ChS1atjUyplcz5oBpG7NJXM5a/DlAd6aOuo+C
         +12Q==
X-Received: by 10.68.136.198 with SMTP id qc6mr54183342pbb.117.1368894391939;
 Sat, 18 May 2013 09:26:31 -0700 (PDT)
Received: by 10.70.88.173 with HTTP; Sat, 18 May 2013 09:26:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224796>

Hello,

The man page of git-diff-index:
http://git-scm.com/docs/git-diff-index
states that
`git-diff-index - Compares content and mode of blobs between the index
and repository`.

However, in fact this command compares between files on disk and
repository by default. It's explained clearly in here:
http://git-scm.com/docs/gitdiffcore

Maybe the man page could be updated to reflect this in NAME section:
`git-diff-index - Compares content and mode of blobs between files on
disk and repository or between the index and repository`

In DESCRIPTION section:
`Compares the content and mode of the blobs found via a tree object
with the content of the files on disk by default, and could be
compared with index only using cached option. ...`

--
Best Regards

Yours faithfully
Albert Netymk
