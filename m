From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/4] fmt-merge-msg improvements
Date: Fri, 20 Aug 2010 17:53:57 +0530
Message-ID: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 14:32:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmQlQ-0004L4-9P
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab0HTMcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:32:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46068 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab0HTMb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:31:58 -0400
Received: by pzk26 with SMTP id 26so1201460pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GBeILDShAG17+/xnaU5EDJKaVabOHZT+zmpubNJIhOs=;
        b=Tt30jlZtwvp/YiB230XHhNomSln62ppC4c0YVVCoTzL8e1rB78tJRXn3XeCk98HBmc
         Z6lFGtA37gaabSkwi5cNFLhow0fRuejLw/OWUWefIr9sf1K/GWJzApvJRjEE6hC9/A5F
         45ztAhP/GNeHYSeugFF86pNOF8O8oXtq8Z19U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MsCcsj9X3uP0XWH+h0gr2V0MFzwmhWwV8GEQxIADGA6K+MXzXbxbD1UoVlbDnxi0Px
         kcb8n6sEiwajg9uGLTd1VBN2drGN0xbE8Hu15f7O0Zga78KtX1ypLKf/wFvr3iSUn42a
         3jHAZlPgmPoXoFNIJXKCj3IIexGUAvXjSV6Dc=
Received: by 10.114.137.8 with SMTP id k8mr1379685wad.202.1282307158652;
        Fri, 20 Aug 2010 05:25:58 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm4770439waa.21.2010.08.20.05.25.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 05:25:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154023>

Hi,

The first three parts make `merge.log` and `--log` an integer. While
at it, drop the deprecated `--summary` option: blame tells me that it
was marked deprecated back in 2008. The series is based on pu for no
good reason.

Thanks to Johannes and Jonathan for their inputs.

-- Ram

Ramkumar Ramachandra (4):
  fmt-merge-msg: Make the number of log entries in commit message
    configurable
  fmt-merge-msg: Update command line options to sync with config
    options
  fmt-merge-msg: Update fmt-merge-msg and merge-config documentation
  fmt-merge-msg: Remove deprecated --summary option

 Documentation/git-fmt-merge-msg.txt |   28 +++++++----------------
 Documentation/merge-config.txt      |    8 +++++-
 builtin/fmt-merge-msg.c             |   41 ++++++++++++++++------------------
 3 files changed, 34 insertions(+), 43 deletions(-)
