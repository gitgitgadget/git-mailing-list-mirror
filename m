From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: remote-testsvn: Hangs at revision
Date: Wed, 5 Dec 2012 11:50:07 +0530
Message-ID: <CALkWK0meveeKQe81hHyojPX0GH_WRrv7ob9-NA1Q7-TuKso+1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Barr <b@rr-dav.id.au>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 07:20:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tg8Lc-00034g-DZ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 07:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab2LEGU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 01:20:28 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62567 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab2LEGU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 01:20:28 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so4650997obb.19
        for <git@vger.kernel.org>; Tue, 04 Dec 2012 22:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=Kz47FulzQNpk6AoDfY+FiTxD03VE7fuZMgCjvsADyRw=;
        b=Rh4eyd74WGtYKUx+ll4uatGLAFZ7YrXe6SmozNn6eSf/TRM8mWgawjTrMtAQ8j63sy
         FIcoIPCofJjc5vNLcpUcIWiMqMTB23mBzGdOEk/jUkm8/ZCiQdydK6E9qpFudrg4fAcY
         bZdqdkSMiLefeO2boHQRvrxSeWktSh6ZhuEiFLm7anbMjzwppgtVBldzjcSrrV8CuF8i
         p6cYjPBkGvJhQkSe1u67ozr0kjDP2g7VH9lOibNY/ykrNNRvvc07dYEaoDQ0QLgfCpsN
         UijxBihK+xcU3z49wBw1FwhkoJgfbkBt314bfQGM4LUr/ZoyMc0Ccy/pPUdTcVYwKlYs
         Ti0A==
Received: by 10.182.188.36 with SMTP id fx4mr9574464obc.6.1354688427640; Tue,
 04 Dec 2012 22:20:27 -0800 (PST)
Received: by 10.76.75.198 with HTTP; Tue, 4 Dec 2012 22:20:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211107>

Hi,

I tried out the testsvn remote helper on a simple Subversion
repository, but it seems to hang at Revision 8 indefinitely without
any indication of progress.  I'm currently digging in to see what went
wrong.  The repository I'm cloning is:

  $ git clone testsvn::http://python-lastfm.googlecode.com/svn/trunk/

Thanks.

Ram
