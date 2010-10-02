From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/2] Eliminate cryptic "needs update" error message
Date: Sat,  2 Oct 2010 10:02:57 +0530
Message-ID: <1285993980-28037-1-git-send-email-artagnon@gmail.com>
References: <AANLkTi=91-TJ=C1dUKRXKYWYShWZ-LuLFG3hq1Ms+C+Y@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 02 06:34:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1tnu-00040Y-2m
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 06:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab0JBEeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 00:34:17 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:54239 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab0JBEeR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 00:34:17 -0400
Received: by pxi10 with SMTP id 10so920103pxi.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 21:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JgpezF6YeGXOCb8pNsbT5snHikyqscHh5hlWb8XkWGg=;
        b=BOZKsyL34vlr/U8M2UgT2vsmpUiff9c0QaWd1BDvhDWof/WIb95jmu81vo8Fh9eNiD
         2sgY08mIhybZYSuAAqjVaSg9ZWrBd9PB0zaNHIPkRETHmrDdJGFYv2I34GefrBKMBUw5
         e21tzRRvlKry+UkzlodosCXJDQW47nA4pa0Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hW6/eISrJqDXRJYd+JNbgIj3/jjp6sCKhVzuHEbRUlt2MizAzeH4+yjDKpXY7SqBrn
         wZjErjo/Y0fDvP4gQze6MqzaAe9anrUnDyHt8VFa1I1PPG9Nd02RURpgaK1Ogv97n5yn
         Ro56/JFZtu2SZxDcLE0Izc4S7spXmhpRNlbQw=
Received: by 10.114.13.2 with SMTP id 2mr7485274wam.155.1285994056332;
        Fri, 01 Oct 2010 21:34:16 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 33sm3232939wad.6.2010.10.01.21.34.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 21:34:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
In-Reply-To: <AANLkTi=91-TJ=C1dUKRXKYWYShWZ-LuLFG3hq1Ms+C+Y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157790>

Thanks to Matthieu for reviewing round 1: all the changes he suggested
are incorporated in this round.

Ramkumar Ramachandra (2):
  sh-setup: Write a new require_clean_work_tree function
  Porcelain scripts: Rewrite cryptic "needs update" error message

 git-pull.sh                |    5 +----
 git-rebase--interactive.sh |   21 +++++----------------
 git-rebase.sh              |   14 +-------------
 git-sh-setup.sh            |   28 ++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 33 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
