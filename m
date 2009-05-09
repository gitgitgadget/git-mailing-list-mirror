From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 0/2] completion: config --unset/get
Date: Fri,  8 May 2009 18:23:31 -0700
Message-ID: <1241832213-23070-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 09 03:23:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2bI6-0007z8-0v
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 03:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbZEIBXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 21:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbZEIBXh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 21:23:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:27544 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbZEIBXg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 21:23:36 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1013959wah.21
        for <git@vger.kernel.org>; Fri, 08 May 2009 18:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=He7tTTuWf7TgawjkSbYPrywBxn9HWx3H/joodD7d2e0=;
        b=T2koMivP7Tpq0nlb2s5hbzmyA9VbVDRnGsm4NWFZnvdtzZM+JNAgAtAxdyliS9H82W
         fWxTKTsU/lw0GEFZj0rbDfImYr5hpSzgrTqT35EY/YaK5uW3nJvKgvolzrJLgg/gLH1B
         GF4FbLMM/6Ijrd6QRP6wDPMJRX3zPQHXtIYO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JbcpGqflHigloHndxMNhSTfxCNREfcHEPsoWcEuoN7Kanc7VI4wuqvNPpJd2B/OGhJ
         ZhwoJPJkVcxNE5j4t0sjd6GcQYpIZ1Q2orQXztPuZ+X3/tSx5yys0I20Jj/BEdW72vDA
         mXvxHu9TjGzv7La6NTY/OtvE6hDCr5bo6PWtU=
Received: by 10.115.92.2 with SMTP id u2mr3811440wal.228.1241832216406;
        Fri, 08 May 2009 18:23:36 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id l37sm2133718waf.40.2009.05.08.18.23.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 18:23:35 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Fri, 08 May 2009 18:23:33 -0700
X-Mailer: git-send-email 1.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118643>

Changes since version 1:
    - Simplified into one function
    - Config file search done in reverse
    - No longer messes up your config file

Stephen Boyd (2):
  completion: add __git_config_get_set_variables() to get config
    variables
  completion: complete config variables for
    --get/getall/unset/unset-all

 contrib/completion/git-completion.bash |   33 ++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
