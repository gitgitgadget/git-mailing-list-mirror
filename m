From: "Yin Ping" <pkufranky@gmail.com>
Subject: [BUG?] git-pull and git-merge don't support option --ff as the document says
Date: Mon, 29 Oct 2007 00:36:58 +0800
Message-ID: <46dff0320710280936g4b1022fcpab02e72b99afa0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 17:37:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImB8T-0006Mn-MG
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 17:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbXJ1QhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 12:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbXJ1QhA
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 12:37:00 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:11297 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbXJ1Qg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 12:36:59 -0400
Received: by py-out-1112.google.com with SMTP id u77so2380697pyb
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=m4DVxdW1g/nbcnEc9lpYzYu9NWoDhMc34pLlCGN2JI8=;
        b=qdzpFubFqpUbpL/4o+uONHAVKR//Ve//NtQsA/4RYVSQfMfsfsq+hcCvh+jeG8TDbDwf6hpklY0G4rIAeOodzEkC2TEOAxveqtgxmW62Kunt2LnRsfigkTOZ7KM+EkcZniAwPf+HSU6qRjPpivSYTyNxHJTGaRwfCTmcPLuK2s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PMEWeWZDg92MHQJqKYbRigQt9PySSWHfRyfZ1tl2S8rzwUNNA0kgHK5UpTDHxqnxIW/56DPKGAyHOTIWlBfLAyPdzUfEQvvG8CIdb6SCYYN2rblg69ck8yjQ+uxuxzNBIOiJ70z8oHsiEeN9mD3cC7DpsmNA5ZTcrnh2MctrQdw=
Received: by 10.35.44.16 with SMTP id w16mr6323860pyj.1193589418627;
        Sun, 28 Oct 2007 09:36:58 -0700 (PDT)
Received: by 10.35.108.1 with HTTP; Sun, 28 Oct 2007 09:36:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62571>

Released git version 1.5.3.4

yinping@kooxoo235:~/git$ git-pull --ff
Usage: /usr/local/bin/git-fetch <fetch-options> <repository> <refspec>...
yinping@kooxoo235:~/git$ git-pull --no-ff
Usage: /usr/local/bin/git-fetch <fetch-options> <repository> <refspec>...


yinping@kooxoo235:~/git$ git-merge --ff origin/master
Usage: /usr/local/bin/git-merge [-n] [--summary] [--no-commit]
[--squash] [-s <strategy>] [-m=<merge-message>] <commit>+
yinping@kooxoo235:~/git$ git-merge --no-ff origin/master
Usage: /usr/local/bin/git-merge [-n] [--summary] [--no-commit]
[--squash] [-s <strategy>] [-m=<merge-message>] <commit>+

-- 
franky
