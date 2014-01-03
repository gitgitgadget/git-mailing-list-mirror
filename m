From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/4] Fix branch.autosetup(merge|rebase) completion
Date: Sat,  4 Jan 2014 01:26:58 +0530
Message-ID: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 20:57:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzArq-00031L-A3
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 20:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbaACT5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 14:57:08 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:37066 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbaACT5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 14:57:07 -0500
Received: by mail-pa0-f52.google.com with SMTP id ld10so16122952pab.25
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KhGU+ki4NedKdYmK48AvgVMovyYVfciL0e9nhqmTAL0=;
        b=X6qJIsbvhLow/HwGKWuTazw8crEmEfX1MQnTpOLMpusbXHwx6wkCQ3JowRjL/2mwE1
         V2GLO5xU5T/gWtfccBGKBSxLRT8cXSHiBqBfPxtFYTXYTOckwKYFQXMJuVfw9CIDZuZv
         1xuHbRUe7kav2gEsyn1m08jVzPQJNCa93+69MkJ2+xVQsdzrvdLwERgaHcCawoJJvBIm
         v7+TKd7nDbpA4my43qcByzaDFQt8rShlISe6A6gXzAuk86Zr8twZT5R7JRbezQtFi3TI
         u17T2rmI41Uot0btJDyopGso+LqMXn+znM6y2tnNql9kSk6Zg7papTmuczPRnVH56hkg
         Iuqg==
X-Received: by 10.66.142.107 with SMTP id rv11mr97883503pab.17.1388779026156;
        Fri, 03 Jan 2014 11:57:06 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id e6sm110782903pbg.4.2014.01.03.11.57.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 11:57:04 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239929>

Hi Junio et al,

In v3, I've implemented __gitcomp_nl_append (), like you
suggested. After implementing it, I feel foolish about having gone
around my head to do __gitcomp_2 ().

Thanks.

Ramkumar Ramachandra (4):
  completion: prioritize ./git-completion.bash
  completion: introduce __gitcomp_nl_append ()
  completion: fix branch.autosetup(merge|rebase)
  completion: fix remote.pushdefault

 contrib/completion/git-completion.bash | 15 +++++++++++++++
 contrib/completion/git-completion.zsh  | 10 +++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
1.8.5.2.227.g53f3478
