From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Rebase & Trailing Whitespace
Date: Wed, 31 Aug 2011 16:55:03 -0700
Message-ID: <CAE1pOi0rY4kRR4rvEdFhzzTgfhUczHMX=H5_9+o5aHnv4vTadw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 01 01:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyucu-0004M4-Pp
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 01:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab1HaXzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 19:55:05 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54155 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab1HaXzE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 19:55:04 -0400
Received: by ywf7 with SMTP id 7so1042018ywf.19
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=zTeh03SOonZ9Na3M/dS4493Bt0On4hZUWrsY5L/ZBgs=;
        b=CDVHKTxwkZmyRsLo3j4nEftkCoguZoDXeHJ5D8afixJr7+3acHUbhuj6Yeqk7D+sVn
         O5kPBzCTQSgFQ85jWzSYYcs5ClbzaXFcuuCm8H5JIxj/IKcI/x5o+A9A5lGXfbPJipOu
         q1Hp7eyyJl0TnKOPLur7Mao+CUWu6Avt8eGWA=
Received: by 10.236.173.67 with SMTP id u43mr5877657yhl.119.1314834903705;
 Wed, 31 Aug 2011 16:55:03 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Wed, 31 Aug 2011 16:55:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180511>

Hi all,

Please have a look at the output below.

hilco@centaur ~/workspaces/project-next project-next (next $)$ git rebase master
First, rewinding head to replay your work on top of it...
Applying: ...
Applying: ...
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
No changes -- Patch already applied.
Applying: ...
:
Applying: Use static WAR for SWF files and assets.
Using index info to reconstruct a base tree...
<stdin>:721810: trailing whitespace.
Canadian word list.
<stdin>:721859: trailing whitespace.
SFX N   y     ication    y
<stdin>:721860: trailing whitespace.
SFX N   0     en         [^ey]
<stdin>:721869: trailing whitespace.
SFX H   0     th         [^y]
<stdin>:721876: trailing whitespace.
SFX G   0     ing        [^e]
warning: squelched 1067 whitespace errors
warning: 1072 lines add whitespace errors.
Falling back to patching base and 3-way merge...
:
Failed to merge in the changes.
Patch failed at 0008 Use static WAR for SWF files and assets.

Note the trailing whitespace warnings. How do I find out which file(s)
generated these warnings? Would it be possible to add the file name
causing the warnings to be output? By default? (Using --verbose
doesn't seem to make any difference where the whitespace warnings are
concerned.)

Furthermore, why didn't I get these or similar warnings when I
committed/pushed that particular commit ("Use static WAR for SWF files
and assets.")? I did just find "[core] whitespace = trailing-space"
which I will add to my .gitconfig, I suppose. So I guess what I really
mean to ask is, why do rebase (and merge?) behave differently from
commit?

Cheers,
Hilco
