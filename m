From: Diego Viola <diego.viola@gmail.com>
Subject: Please consider adding a -f switch to git-clone (or something similar)
Date: Sat, 7 Mar 2015 18:54:25 -0300
Message-ID: <CA+ToGPEZN7TBcYF3o5YgbayjZ8WKok-fjTPeq5nbt2vAG1wDDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 22:54:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUMg4-0002nI-AH
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 22:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbbCGVy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 16:54:28 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34331 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbbCGVy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 16:54:27 -0500
Received: by lbvn10 with SMTP id n10so10322570lbv.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 13:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kZM7PcrvrFdT2T/sQDDFxe+28hi2A74V3jQ+S8PlG+o=;
        b=wehJdjhB62VQw3tK419g8OQz/hg1QTcfV3ogcZypRzdm6sOxgG76e6dBDgFpKqMtGB
         cnTErO0bgrpfalZbopM/0ZF5MMOO0L1V/QrR2xi8sKD+tNdmNDPohUWojmrIdsf18eNC
         +xugg2Y1f6hyafVgqu0OWFDE4JI7SWiwtdQeFPYvU8FoK0X6vTz1+fNhAsWYjnhkowgj
         xP9JMohGmDVftVNMOYlTRF+zYIMBLmchFAIaogsWTEoR8qghN6wkNeLrhDsetzHI7/3n
         l/or40YEWAhWiEGymRi68JAR/QllsZFN/ug7h90m127ZxUtRpjI3Xp00SbqLhRO9gjrX
         at6A==
X-Received: by 10.152.245.41 with SMTP id xl9mr2137037lac.24.1425765265860;
 Sat, 07 Mar 2015 13:54:25 -0800 (PST)
Received: by 10.114.1.208 with HTTP; Sat, 7 Mar 2015 13:54:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265005>

Hello,

I was thinking about creating a new repository in my home dir so that I could
keep my dot files in it.

However, I found that I can't do a `git clone url:user/repo.git .` in a
non-empty directory.

Is there a possibility of implementing a -f switch to git-clone so that when I
use that, git would still clone the repo in the non-empty directory and keep the
untracked files untracked/unstaged? (just as if I copied files to the git repo).

I know I could git-init in a empty directory and then copy the .git dir to the
non-empty directory as a workaround, but I like the idea of cloning better.

My C skills aren't that great or I would have sent a patch already.

Thanks,

Diego
