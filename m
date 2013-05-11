From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Colored prompt for zsh
Date: Sat, 11 May 2013 21:55:11 +0530
Message-ID: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 11 18:24:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCbF-0001Lt-Kd
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab3EKQYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:24:41 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58898 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3EKQYl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:24:41 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa10so3620038pad.33
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=6I1sSc7gg0hmNa1LSAuGDgssJDuzeHDKDa81KfWouXQ=;
        b=mhgpT487H+eX+Gdav/lzjSKnsCM9nep0U0j9XjGJsDQyt/FtxGhcb4nVVyCVDNXZvD
         OdR7kc4Gqqcer29jwX7+li8wHwon77hftkbHqvIj81BHm8hTNQrjNL4ljtWnEwckdUrg
         +NCHi1Pi99BRSuKKGKC3i215D5pgo62fgslptxv1LXExUD59y6yrJZMUOrxp/eN9548I
         A7IYCX7tQIo1UmxDkmyZy6rMn4715PcEHAgybywfJu+gkoxZ0EYUznko/FYuRMlmLqa1
         XJurunYTHjC3of3KcqGcTAocwuU2rAAq8ML0qmG+mCzYHSazFNx1gEu5XYwwU4LhH1uz
         oW7A==
X-Received: by 10.66.21.38 with SMTP id s6mr22413299pae.103.1368289480454;
        Sat, 11 May 2013 09:24:40 -0700 (PDT)
Received: from localhost.localdomain ([122.164.109.165])
        by mx.google.com with ESMTPSA id fn2sm7096965pbc.15.2013.05.11.09.24.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:24:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.g4537cf1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223992>

Hi,

I was using ZSH's vcs_info until now, and just discovered
contrib/completion/git-prompt.sh.  Other differences aside, it's
simple enough that I can hack on it.

The first patch strips a small whitespace (we can't waste valuable
real estate on unnecessary whitespace), and the second patch should
get you a beautiful colored prompt in ZSH.

Enjoy!

Ramkumar Ramachandra (2):
  git-prompt.sh: strip unnecessary space in prompt string
  git-prompt.zsh: introduce thin ZSH wrapper

 contrib/completion/git-prompt.sh  | 80 ++++++++++++++++++++-------------------
 contrib/completion/git-prompt.zsh | 59 +++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 38 deletions(-)
 create mode 100644 contrib/completion/git-prompt.zsh

-- 
1.8.3.rc1.52.g4537cf1
