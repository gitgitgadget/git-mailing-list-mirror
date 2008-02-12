From: "pradeep singh rautela" <rautelap@gmail.com>
Subject: git-clone fails with out of memory,malloc failed7
Date: Tue, 12 Feb 2008 21:27:10 +0530
Message-ID: <6bc632150802120757r5dbeee6bmed9ccde4ca6f40d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 16:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOxW4-0003IT-Aa
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 16:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbYBLP5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 10:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYBLP5R
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 10:57:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:7106 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYBLP5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 10:57:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so526493ugc.16
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 07:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=+CbIEN8Fnl/g42BCSyrfZNLtkv2YYLF9OLHgD+VfDB4=;
        b=xjmVgEOSNdBdX5h0ymKaIIWM0pSLJ+y8d/VaRj2xGtCEgKtdggIqG9rDzOm4W8oIwh2QcylMPHsMkTH5G4fxWIisZT4MMKyDjGW+tmBOgvqzLj6vmqDeeAttgTViiRZA7oNuieIbw8vJuOqdpb6j4XGlbpjw5friAPADjxwgb2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lMbPouoyrFlZ2KIqHmPik4ieSS9oQvybvL/WdkswkaBmIHBiXtwW4eYb+nE1eWm6bivmFyDADuQVbBK/Z66bJy9UIo+y7UJWO9ubklzgms4Pf9Zq4Xaq2pXEDhD9rmY/8sHQVku1E9FY9PbejnN7pthFNgND7Gg/pgYMVB1FEWc=
Received: by 10.142.143.7 with SMTP id q7mr1167608wfd.3.1202831830978;
        Tue, 12 Feb 2008 07:57:10 -0800 (PST)
Received: by 10.142.102.10 with HTTP; Tue, 12 Feb 2008 07:57:10 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73670>

Hi All,

I compiled a fresh git 1.5.4 and tried to clone Ingo's kgdb-lite tree.
I got rather strange out of memory. malloc failed7 error.

I am using a 32 bit kernel on a pentium D processor with 1 GB of ram.

Is this a git issue or something else?
Can someone help me in telling me which is the correct place to report this?
Better if this is a known issue ?

isn't 1 GB of RAM enough for git???

luser@helvella:/opt/repo/archive$ sudo git-clone
git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-kgdb.git
[sudo] password for luser:
Initialized empty Git repository in /opt/repo/archive/linux-2.6-kgdb/.git/
remote: Counting objects: 712950, done.
remote: Compressing objects: 100% (124251/124251), done.
remote: Total 712950 (delta 591747), reused 708812 (delta 587713)
Receiving objects: 100% (712950/712950), 173.74 MiB | 40 KiB/s, done.
fatal: Out of memory, malloc failed7)
fatal: index-pack failed
fetch-pack from
'git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-kgdb.git'
failed.

ps: Please CC me, as I am not subscribed to the list.

Thanks,
           --Pradeep
-- 
Pradeep Singh Rautela
http://eagain.wordpress.com
http://emptydomain.googlepages.com
