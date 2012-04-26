From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: UI issues
Date: Thu, 26 Apr 2012 10:47:10 +0200
Message-ID: <CAHVLzc=xynGv=Mhr2yW4=GaLxX=W6xMQS9bosrvCCo8tHZjarA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes.Schindelin@gmx.de
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 10:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNKMW-00076c-FZ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 10:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab2DZIrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 04:47:33 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:47475 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab2DZIrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 04:47:32 -0400
Received: by qadc11 with SMTP id c11so1286073qad.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=+FoW5ptyXv91ISJcUeaX1xJ7fI3a6DssWZQz+Arv75k=;
        b=L4MBHy5+WqtUDIoem/GULmuvr6xR9Wu7EjVjqDlr3HVR7zPz1g++3ZHS+2wqyBv/Ud
         dmewPe/PFboeOIe616tAcWDBdwX8PqxHQ0a3LNh3tQZMw50LQFz6ah6bM06O6jLavMT0
         XRyh0vFM88NyE0LtPXqhDNzsJgp20XS/Ghof/XFkJpHVAnHZiGBoA+Vkqz95ep8YSyYH
         54dyzeskndYJ4Xx2FBPaRH5jdjDDBzE4+gcVMS1WTKFYYwJRK5RzLwpTc/Qx5BPbkkVt
         l8q/QmjRqnTRgsqe1/Iswi78bTCaSdaN0cYnHzyGhBCS2J+uKy92jiRSlDsZDdnjUP7q
         5cCA==
Received: by 10.224.198.70 with SMTP id en6mr4415223qab.62.1335430051202; Thu,
 26 Apr 2012 01:47:31 -0700 (PDT)
Received: by 10.229.70.210 with HTTP; Thu, 26 Apr 2012 01:47:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196357>

Hi,
in a interesting discussion in G+ Dscho raised a few issues in the GIT UI.
I think there is value in summarizing the thread and opening a new
discussion here:
- short names for uncommon operation, long names for common ones (e.g.
cherry vs cherry-pick)
- lack of undo
- the usual discussion about the terms index, staging area and the
"add" command. They all look not consistent.
- 'git remote' has sub commands 'rename' (but not 'mv') and 'rm' (but
not 'remove')
- git remote add -f blub WRONG_URL fails but you still have to remove
the remote before you can try again to add something.

Regards,
-- 
Paolo
