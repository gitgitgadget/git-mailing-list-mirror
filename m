From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 0/8] bash completion: more porcelain completions
Date: Mon,  4 Aug 2008 23:50:30 -0600
Message-ID: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 07:51:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFSV-0007Wq-E4
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 07:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbYHEFuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 01:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbYHEFum
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 01:50:42 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:56663 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbYHEFul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 01:50:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3753909wfd.4
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=J2MRvD/8DeCtv2qImbNBHeqesta/YByFwu4HYXIOm/o=;
        b=GH/mTpyosSd43T+kYX/iu8t51xlYgKuAHBOUZ6d+837xbfdHzH+A3ROHIRSqZE+ZtZ
         1Wa392K/4296cmF/ICHx8XnDSzlqOuueP38ddrFuCNiOdj++aykePn0CXu/rEE56QsvN
         SGoEf0Pj5MCd4GdnEXI/G2aBRzM4w/gDLoe2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TIw9wbECKu3Etm8MpGYphxuF25uktb5WtGwmADA/aeO2Ps+3DAuqDMX6c3lp6+ILxj
         MdLSMt0cVzXk47KGAd8D0XIsGdoWoCx1Vl9GcROimWPQWJ5oqEoiDfBHYR0hBZ0uTMJ5
         ZCkAB1Rg3jrsOImdsCMwsRh8A/a/DtnnnyMOQ=
Received: by 10.142.128.6 with SMTP id a6mr5282160wfd.68.1217915440684;
        Mon, 04 Aug 2008 22:50:40 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id 32sm10686014wfc.12.2008.08.04.22.50.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 22:50:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91421>

This adds basic long option completion for some common commands that I
use, as well as stash name completion.

Lee Marlow (8):
  bash completion: Add completion for 'git clone'
  bash completion: Add completion for 'git clean'
  bash completion: Add completion for 'git init'
  bash completion: Add completion for 'git revert'
  bash completion: More completions for 'git stash'
  bash completion: Add completion for 'git archive'
  bash completion: Add completion for 'git ls-files'
  bash completion: Add completion for 'git mv'

 contrib/completion/git-completion.bash |  143 +++++++++++++++++++++++++++++++-
 git-stash.sh                           |    2 +-
 2 files changed, 143 insertions(+), 2 deletions(-)
