From: Francis Moreau <francis.moro@gmail.com>
Subject: Question about "git pull --rebase"
Date: Sat, 14 Nov 2009 21:39:24 +0100
Message-ID: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 21:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9PSM-00015l-Ka
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 21:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbZKNUjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 15:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbZKNUjU
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 15:39:20 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42886 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZKNUjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 15:39:20 -0500
Received: by bwz27 with SMTP id 27so4532537bwz.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 12:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=+Hrp6b/MZdzmL1yJtjE8F1YQp+nuZLgkTVfrRbMF+kY=;
        b=NNfnPx8rxHQdQHTW8oChbUH8ZuibQj4cNCL2gOEz9wpIzok2mDU7RDnT54qLlJH2Hu
         eftVswesqfgpCnjbR65SlOSGZr01Om64XWN0IP8T2DWiokMxhWYQ678DHqSuJ3ZFIHLn
         Q0lWQhM09lMHHQUAThpofpU2S6aaO5D3iejqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=kRTwS9GosH0Sg++RKdSCQMy6aZ70zFAQOVXT84UOTBhNLDMRLyJiRrVzynBC0+NO8r
         3pcNre8MB0yiW1Hdhx60dbyGkQYA5zKsvsjvnZnlB1tvTDD7bEexgR50sqA9co34AHtD
         58nfdRJAhtxGeGcQ8KjRo95uNpFF+3FY50n1U=
Received: by 10.239.138.23 with SMTP id n23mr570094hbn.154.1258231164617; Sat, 
	14 Nov 2009 12:39:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132884>

hello,

Let's say I'm on a branch called 'foo'.

I tried to rebase this branch by using 'git pull --rebase'.

I first tried the following command:

    $ git pull --rebase origin master:foo
    remote: Counting objects: 5, done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    From /dev/shm/git/A
    ! [rejected]        master     -> foo  (non fast forward)

which failed.

Then I tried:

    $ git pull --rebase origin master

which worked.

Reading the man git-pull I would assume the 2 commands are equivalent
but obviously they're not.

So the question is: why ?

Thanks
-- 
Francis
