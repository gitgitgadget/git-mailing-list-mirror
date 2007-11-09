From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git push failing, unpacker error
Date: Fri, 9 Nov 2007 09:37:21 -0500
Message-ID: <9e4733910711090637tcf7e837na863a4276578bf3f@mail.gmail.com>
References: <9e4733910711082155t62df9d4by10bd3f546ffbd950@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 15:37:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUzK-0002ek-Qw
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 15:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758992AbXKIOhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 09:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbXKIOhX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 09:37:23 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:31356 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbXKIOhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 09:37:22 -0500
Received: by wa-out-1112.google.com with SMTP id v27so625737wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 06:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1ALuecdvDygG9fVlVGOZ6QEEtPDHMUIBF2d0GwImH1Y=;
        b=MFnvlhkBQJpAgvJPXbBSC1pPUXJcVJnyO1geRluC3EdsRPJTkh0aZsU4QRxPTPyPfRDanYswPhyL4JDzTOGNKcfpn/3YYUJLRhxEVnIJ/qWdANqXwX0ChxbxGfehrStD9n+3BKTQqu90rC7dCH6rdKZopTXjaUgO74shTpZT52c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rjhW0yHCq7pCwhutuSTbEUIot3qbc19jn/l5ooUKwmj2vfItP1M+FlhWoDrj1gxKbLQKR4NVFjtCTHSXLxHVxe6bsuabnfNgobD+0MUtfZo+J3QaUUyDeoHbcoiPebRbKW2F+SJQae68eioDDlxQgGrQ1VS/bCULIYjdSRzOCpg=
Received: by 10.114.167.2 with SMTP id p2mr511463wae.1194619041866;
        Fri, 09 Nov 2007 06:37:21 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 06:37:21 -0800 (PST)
In-Reply-To: <9e4733910711082155t62df9d4by10bd3f546ffbd950@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64192>

I updated both sides to current git and it still fails. How do I debug this?
What's causing this, "error: pack-objects died with strange error"?


jonsmirl@terra:~/mpc5200b$ git push dreamhost
To ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git
 * [new branch]      m24 -> linus/m24
 * [new branch]      m25 -> linus/m25
 * [new branch]      m26 -> linus/m26
 * [new branch]      m28 -> linus/m28
 * [new branch]      m29 -> linus/m29
Counting objects: 81156, done.
Compressing objects: 100% (15280/15280), done.
error: pack-objects died with strange errorMiB | 412 KiB/s
unpack index-pack abnormal exit
ng refs/remotes/linus/m24 n/a (unpacker error)
ng refs/remotes/linus/m25 n/a (unpacker error)
ng refs/remotes/linus/m26 n/a (unpacker error)
ng refs/remotes/linus/m28 n/a (unpacker error)
ng refs/remotes/linus/m29 n/a (unpacker error)
error: failed to push to 'ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git'
jonsmirl@terra:~/mpc5200b$



-- 
Jon Smirl
jonsmirl@gmail.com
