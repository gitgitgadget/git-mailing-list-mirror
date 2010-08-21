From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 0/5] fmt-merge-msg improvements
Date: Sat, 21 Aug 2010 15:28:14 +0530
Message-ID: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 12:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmksF-0004uw-NQ
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab0HUKAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:00:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39425 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0HUKAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:00:21 -0400
Received: by pzk26 with SMTP id 26so1588171pzk.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Ks07WE6/7upeU2UdVfJoqV6o749+91JaULGnEm6CThA=;
        b=pG06D1X6/OElii7DZqzhjLNURBvPSN05PQ1h8U5SjfAkBg4ZoM0A2sIkrcLwVFNKDG
         RHeJ9NpWOM7s9CWRkDmuUlze5wp86SXMwLERnPjkQoKiTlTfo/VjiZlMG4in8+MOj/7Y
         8u340Uo53zAMewSt55AXU07gFCaBVn62N7Wco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=h/hFI1MBoPUzRz8PUXdNpIkhbwAvTTcSwEJz4ya/SNnntGqxJI3e2nYt7kB8Pbqmop
         lid3Uno8pXTgAgue3aqeviYPnOpC0rwMOkKFHDGVhqqW7Vcm8QkTOs2bNg4CzV+jNF8o
         UoUZGBaGeH9uZSFD/91vE21msekBdNGkyIdU0=
Received: by 10.142.132.15 with SMTP id f15mr2117328wfd.14.1282384821561;
        Sat, 21 Aug 2010 03:00:21 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm4641270wff.7.2010.08.21.03.00.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 03:00:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154128>

This version uses PARSE_OPT_OPTARG instead of PARSE_OPT_NOOPT. Also,
there are a few minor fixes from Jonathan's reviews.

Junio: If the --summary shouldn't be removed before 1.8.0, feel free
to drop PATCH 4/5 for now. I've made it independent of the other
patches in this round.

Jonathan Nieder (1):
  parse-options: clarify PARSE_OPT_NOARG description

Ramkumar Ramachandra (4):
  fmt-merge-msg: Make the number of log entries in commit message
    configurable
  fmt-merge-msg: Update command line options to sync with config
    options
  fmt-merge-msg: Update fmt-merge-msg and merge-config documentation
  fmt-merge-msg: Remove deprecated --summary option

 Documentation/git-fmt-merge-msg.txt |   24 +++++++------------
 Documentation/merge-config.txt      |    8 ++++-
 builtin/fmt-merge-msg.c             |   44 ++++++++++++++++------------------
 parse-options.h                     |    2 +-
 4 files changed, 37 insertions(+), 41 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
