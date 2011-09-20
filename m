From: Alexey Shumkin <zapped@mail.ru>
Subject: [PATCH v3 0/2] pretty: user format ignores i18n.logOutputEncoding setting
Date: Tue, 20 Sep 2011 12:20:16 +0400
Message-ID: <1316506818-5968-1-git-send-email-zapped@mail.ru>
References: <7v1uvptjhr.fsf@alter.siamese.dyndns.org>
Cc: Alexey Shumkin <zapped@mail.ru>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 10:20:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5vZH-00050W-7c
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 10:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab1ITIUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 04:20:33 -0400
Received: from smtp9.mail.ru ([94.100.176.54]:60232 "EHLO smtp9.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406Ab1ITIUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 04:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Sender:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=Kyrl7xXgiEAd418tKZqh5h1d1oy+FJ1K7LvgGr0sufA=;
	b=XUHqao0v6dJkQ5UaZ0gVQudEhtXlhltc820xCARNr+zaWzR3WDjS1XHOSl5t/hymnsoOEszgHuxbJcTP6As7U5sPJ3ayJDhlM08TIDTedQO88ViAk2Z2d5fFHjpTKlkY;
Received: from [91.77.19.104] (port=53939 helo=zappedws)
	by smtp9.mail.ru with asmtp 
	id 1R5vZ8-0002Nr-00; Tue, 20 Sep 2011 12:20:30 +0400
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <zapped@mail.ru>)
	id 1R5vZ2-0001ZF-4V; Tue, 20 Sep 2011 12:20:24 +0400
X-Mailer: git-send-email 1.7.6.3.4.gf71f
In-Reply-To: <7v1uvptjhr.fsf@alter.siamese.dyndns.org>
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181739>

>>You seem to have inherited bad grammar from some example; I wonder
>>where... ;-)
I rephrased... I made an attempt to as least ;)

>>Format it this way instead if you want to use multi-line:
>>	echo "..." |
>>    iconv ... |
>>    xargs ...
done

Alexey Shumkin (2):
  pretty: Add failing tests: user format ignores i18n.logOutputEncoding
    setting
  pretty: user format ignores i18n.logOutputEncoding setting

 builtin/rev-list.c               |    1 +
 builtin/shortlog.c               |    1 +
 log-tree.c                       |    1 +
 submodule.c                      |    3 +
 t/t4041-diff-submodule-option.sh |   56 ++++++------
 t/t4205-log-pretty-formats.sh    |   22 ++++-
 t/t6006-rev-list-format.sh       |  192 +++++++++++++++++++++++---------------
 7 files changed, 170 insertions(+), 106 deletions(-)

-- 
1.7.6.3.4.gf71f
