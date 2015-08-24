From: Brett Randall <javabrett@gmail.com>
Subject: Doc, git-svn, added mention of config key: svn-remote.<name>.include-paths
Date: Mon, 24 Aug 2015 10:23:44 +1000
Message-ID: <1440375825-2587-1-git-send-email-javabrett@gmail.com>
Cc: javabrett@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 02:24:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTfYt-000866-Q9
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 02:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbbHXAYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 20:24:05 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35719 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbbHXAYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 20:24:04 -0400
Received: by pacdd16 with SMTP id dd16so83015220pac.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 17:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=o92kiovVwnrPuaCsJT1gZ2op7QY7pYFgE0yy3K6IeOs=;
        b=V8PwR46iuT6gkgZRwL1UsSRlsLVmQMFNpheGmkJs7gPUiGztUQnRpugafgnEFDeejK
         ICGpRoQVSiXO3fDcHEIXIHa3TpjI6ROUISOLthRr7EgvFVVWZQwVhdv/VGd3jaH0PCsm
         71bX6wOGll42Nya9P1iGW/ZFQ5Tg3xiA9jd/rrc0dOj5qt3/hsys8n9LfDLBSH7bHT+K
         QnSOfARwbO4Tr4upBT8gZ9udk/iWvi3XB+yp9WqWpLy/DnKndjKfPP7wvrwgQy/8IGbF
         RlEXkNtdGxwS7OwnPw5OgQAjrrxsZjeH6bqnMpDtuUlFtwXDbRxy/IwFduW6a37jMpmp
         l4jA==
X-Received: by 10.69.2.69 with SMTP id bm5mr39625298pbd.41.1440375842932;
        Sun, 23 Aug 2015 17:24:02 -0700 (PDT)
Received: from bsrandal-t3600.iiNet (124-149-100-161.dyn.iinet.net.au. [124.149.100.161])
        by smtp.gmail.com with ESMTPSA id im2sm15100521pbc.34.2015.08.23.17.24.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Aug 2015 17:24:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276428>


I send this small doc-patch back in June[1], but it may not have come through properly, or may have been lost, so I'm resending it.

Thanks
Brett

[1] http://marc.info/?l=git&m=143313445425214&w=2
