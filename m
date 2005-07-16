From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 0/5] cogito: compatibility with OS X
Date: Sat, 16 Jul 2005 19:23:14 -0400
Message-ID: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 01:24:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtw18-0007X0-2Y
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 01:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVGPXYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 19:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVGPXXz
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 19:23:55 -0400
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:18055 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261883AbVGPXXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 19:23:14 -0400
Received: (qmail 19836 invoked from network); 16 Jul 2005 23:23:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=QCF8Jkd0i2LsqhHXqybKHq+3PfyMEn/rmhIv3YGeJSkA5TBSkDxqz3vDTmtJe2BUp5sN6KBOpjn5Rm93dzvYfpYdaMIKe7jVbRm5gUHJcdU3HoL3ilmEqZMuEaq6I3rfyNkXSiNN4HT+1RMT13S+d2PKmmPNaD1Aa5RaJn+KH2I=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@65.93.75.85 with plain)
  by smtp111.mail.sc5.yahoo.com with SMTP; 16 Jul 2005 23:23:13 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Since Linus and Junio were unhappy with my previous set of patches to
make git and cogito compatible with OS X and other BSD unices, I have
redone my patches to cogito along a similar line.

There is still one outstanding incompatibility:  cogito makes use of
cp -u.  I have this message from Junio:

> I do not speak for Pasky, but to me "cp -u" sounds just like an
> optimization, so maybe defining CP_U='cp -u' and detect missing
> support at config time and falling back on the simple "cp" would
> be an option?

Pasky, does this seem reasonable?  Is there a better way?  So far I
have been able to avoid adding the "config.sh" contained in my first
script.

cheers,
Bryan
