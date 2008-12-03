From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv2 0/2] gitweb: patch view
Date: Wed,  3 Dec 2008 11:07:40 +0100
Message-ID: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 11:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ofO-0002AJ-95
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 11:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYLCKHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 05:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbYLCKHd
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 05:07:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:63894 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbYLCKHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 05:07:32 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3342470ugf.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 02:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+UPZ8XOI0eEnDmF8h9WFUWiyEilHxjCZIp0lqRb4edM=;
        b=La8pgVp5McRNZLtZtgxdb6ecsAhBpLNRszgTg2U4tm1PjM4zgdl5sNVvjZam6rhrf0
         MMhIHEiSvdzl1QjNTtvZZepwibrF0YtKjiyRJNUH1n8WgiUs12mxxEWVDow9KlRzQS1r
         CRynx2B14DvtsLuw5vrH/udy8g9gl3tEnbT4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CHNCPTXhqJpzdf24QNdsrNuD7E/F0QEIrstrBwDNF7Btlj5/IwjwBf8rMRn+j3dYe+
         EQz0DACFUoWxm5cqy59ouy6QNZPK0Cv0gtGSzqiSAc6kxgWrTLsS40q3liptC0XOigkp
         lqbZH1w8A+Wf6gcCYZrRT61RUjgOQVgjchD5M=
Received: by 10.103.172.9 with SMTP id z9mr5845354muo.39.1228298850374;
        Wed, 03 Dec 2008 02:07:30 -0800 (PST)
Received: from localhost ([94.37.11.168])
        by mx.google.com with ESMTPS id b17sm11334805fka.27.2008.12.03.02.07.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 02:07:30 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102235>

Another go at the patch view feature. I'm marking this as RFC because
there are still a couple of points that need to be agreed on, esp. wrt
to the patch limiting and the insertion of extra X-Git-* email headers.

Giuseppe Bilotta (2):
  gitweb: add patch view
  gitweb: links to patch action in commitdiff and shortlog view

 Makefile           |    2 ++
 gitweb/gitweb.perl |   39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)
