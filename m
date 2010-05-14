From: Ali Tofigh <alix.tofigh@gmail.com>
Subject: many files, simple history
Date: Thu, 13 May 2010 22:57:22 -0400
Message-ID: <AANLkTinHZbJ4obpa1FpT8boFWjNYpgU184HUTvki_A0G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 04:57:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCl60-0001o8-1e
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 04:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934Ab0ENC5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 22:57:46 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:41482 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab0ENC5p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 22:57:45 -0400
Received: by qyk13 with SMTP id 13so2852589qyk.1
        for <git@vger.kernel.org>; Thu, 13 May 2010 19:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=ebPJn/g53CYKG9NixYqFmSESahxmCsf7tlYF8t753+A=;
        b=IXfTQAuiLA1c64WVpwvQGCEjtm4214kiw/2kKjDhNF1HIysksYqWFeinfvhRxqTk8a
         2koMk6QherVSIcgBA3a50twG3/qivVqvKs6tD3vBEQSF9pfpYzgsLg5dSYFkee8PGDjW
         P5s3iNn7lVqPY7BpjVza3pF4kStBsm3bNkFNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=VasW35dF4ZThfNhf82oDxNJOCVW9z5lvqhUpJJ6WhlJwl3BwJxbIf+jfJQrCIz/5EK
         XQHHLn9ydZcVjOxvo1Z8o+u5Ws+M10K8gU8Oc5HE4Vci8117aFEGZegH4bxrk4aPercw
         MlGYqe3NtVIdiaW4jNy9ixZLOyy30NMai9pcA=
Received: by 10.229.182.9 with SMTP id ca9mr214674qcb.118.1273805863555; Thu, 
	13 May 2010 19:57:43 -0700 (PDT)
Received: by 10.229.51.84 with HTTP; Thu, 13 May 2010 19:57:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147039>

short version: will git handle large number of files efficiently if
the history is simple and linear, i.e., without merges?

longer version: i'm considering using git to keep track of my
installed user programs/files on my linux machine, mainly because i
want to be able to uninstall software cleanly and completely (i almost
always build from source code and install in non-standard locations).
so i would want to use git to keep track of every program i install or
uninstall. this way, i could go back and uninstall a program simply by
finding the commit when it was installed, get the list of files that
were added as a result, and remove them (and of course, commit the
removals into git so i can always undo the uninstall too!)

so the history stored in git will be linear and consist of file
additions and removals. but this will potentially involve many files.
will git be able to handle this (as yet hypothetical) situation
efficiently?

/ali
