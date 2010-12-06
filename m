From: Konstantin Kivi <kkivi@yandex.ru>
Subject: git fetch vs push, git am questions
Date: Mon, 06 Dec 2010 23:27:55 +0300
Message-ID: <99351291667275@web152.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 21:28:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPhfK-0003x0-Jp
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 21:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab0LFU2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 15:28:00 -0500
Received: from forward13.mail.yandex.net ([95.108.130.120]:47343 "EHLO
	forward13.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab0LFU2A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 15:28:00 -0500
Received: from web152.yandex.ru (web152.yandex.ru [95.108.131.165])
	by forward13.mail.yandex.net (Yandex) with ESMTP id 783B61080B0A
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 23:27:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1291667278; bh=HIMPFdHNyzKtMVl/v1tl0TIktu9mpkikZv8wciAF/Js=;
	h=From:To:Subject:MIME-Version:Message-Id:Date:
	 Content-Transfer-Encoding:Content-Type;
	b=FkQn/bd7aqd3I1paGBiTbXYgbCSrGhp3kw03bUUL7TtXozHP7HLBLSITi/el/Nux5
	 ASc00uGm7J8vs8RwGoBGkEt6ulIYSR7gimfi+y63poKWQh5wx0eIBQXtgVCe67r9IU
	 TTyw9RZtH4s7ycXBsTAfYfdFc+X0zEfg6jM1vT94=
Received: from localhost (localhost.localdomain [127.0.0.1])
	by web152.yandex.ru (Yandex) with ESMTP id 7142967A0027
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 23:27:58 +0300 (MSK)
Received: from konst.order.hcn-strela.ru (konst.order.hcn-strela.ru [91.192.71.209]) by mail.yandex.ru with HTTP;
	Mon, 06 Dec 2010 23:27:55 +0300
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163019>

HI all
I honestly tried to find answers in various docs/books about git and failed, so I have to ask here.
 
1) Is it possible to achieve the same result with git fetch, as I have with git push. I have cloned a bare repository (2) from my repository (1) and 
I want fetch made in (2) get all info contained in (1) . I talk only about 'master' here. git push from (1) to (2) does the job, but git fetch in (1) updates only origin/master, and not master.
I also found that there is a notions of current branch in bare repository (master in my case), that stops my experiments of deleting master and making new master out of origin/master.
How can I change current branch in bare repositry?
 
2) I read that git rebase used 'git am' internally. How can  force git am/apply to create conflicts like rebase does in form
 
<<<<<<old
dksjfd
========
>>>>>jfkjdfkd
 
instead of *.rej files 

Best regard, Konstantin
