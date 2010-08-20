From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/5] fmt-merge-msg improvements
Date: Sat, 21 Aug 2010 00:44:57 +0530
Message-ID: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:17:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmX5m-0006w7-Iv
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab0HTTRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:17:17 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64833 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0HTTRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:17:16 -0400
Received: by pxi10 with SMTP id 10so1329950pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gYOyZXifp+YnPGHkkFCL76yj2Fyq5ZIB5dd1mxGfGQg=;
        b=Cet6pEcfq4+ZPBEcpebGR3zrUFgn/vLnHFYSVjMWUcAbHQVKm51lb9IUnM0FvomOOZ
         mSrjqzn+1XDM/lAoyRnLQYOxWI3ncP7EgQrKEcpbAmQdTKdhCaikz91UjtQp4WPQPQj4
         y4TRm0VzJ+4E4QqpV0dRVH+becjteoRknDhFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=N4SOVhVjVvLradLze1nrNBkz0levJrE8HoPClgHSVd9FdAg7xAe41Y9EYTb7qvqcm0
         G42bP1j3cT+yTSv+zaAzkpZqT3ooKMq/VkV0VofoxyKPJNXs8fQ4F0tW/kZcfsNQ66DD
         olvh/u7pe5bj/rKTzW1hLi5ZPq357zbMDHHA8=
Received: by 10.142.226.14 with SMTP id y14mr1441840wfg.95.1282331835557;
        Fri, 20 Aug 2010 12:17:15 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm3610572wff.7.2010.08.20.12.17.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 12:17:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154069>

Hi,

There's now a new patch in the series; thanks to Jakub for poking me
hard enough :)

-- Ram

Ramkumar Ramachandra (5):
  parse-options: Allow PARSE_OPT_NOARG in integer arguments
  fmt-merge-msg: Make the number of log entries in commit message
    configurable
  fmt-merge-msg: Update command line options to sync with config
    options
  fmt-merge-msg: Remove deprecated --summary option
  fmt-merge-msg: Update fmt-merge-msg and merge-config documentation

 Documentation/git-fmt-merge-msg.txt |   24 +++++++------------
 Documentation/merge-config.txt      |    8 ++++-
 builtin/fmt-merge-msg.c             |   44 ++++++++++++++++------------------
 parse-options.c                     |    3 ++
 4 files changed, 39 insertions(+), 40 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
