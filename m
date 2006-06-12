From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: bisect and gitk happy together
Date: Mon, 12 Jun 2006 23:41:34 +1200
Message-ID: <46a038f90606120441p74dd4872y441fe04470f4acd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 12 13:41:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpkna-0000Mt-It
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 13:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWFLLlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 07:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWFLLlg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 07:41:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:6324 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751165AbWFLLlf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 07:41:35 -0400
Received: by wr-out-0506.google.com with SMTP id i20so1118411wra
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 04:41:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KzALP9Us/7GmXJUuQAYXpxPOxjoE2otfmKvH8+42MuEYKTXuiijyKf28wKSxTGCE9aUcjkX7KpXRz2PWug8qdDZTi4d0of2QawMm4VeTHNzF0qQ8RfSMwqhuwg+XVmWIOIzeMHmXoqYxHb6CtxRhNukpnJjujX/pA5mUU29bq7U=
Received: by 10.54.109.13 with SMTP id h13mr3450200wrc;
        Mon, 12 Jun 2006 04:41:34 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Mon, 12 Jun 2006 04:41:34 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21702>

I was using git-bisect earlier today, and at the exact point where it
told be about the bad commit, I opened gitk, which was showing all the
bad and good commits. It is great!

Two "user" notes, however:

 - git-bisect visualise wasn't as useful as just a plain gitk. (This
may be because I was working with ~60 commits in a medium-sized
project).

 - gitk didn't show the bad commit tagged specially, even if
git-bisect had just identified it. Of course I could find it, but I
had all the other good/bad commits well labelled. And not the one I
was looking for. Odd.

In any case, the bisect + gitk combo saved the day. I'm too ashamed to
tell what the bug actually was, though ;-)


martin
