From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/3] Juggling between hot branches
Date: Sat, 28 Sep 2013 08:29:18 +0530
Message-ID: <1380337161-803-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 28 05:06:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPkrO-0006ca-OR
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 05:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab3I1DGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 23:06:17 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34735 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab3I1DGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 23:06:16 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so3321567pdj.39
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 20:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Nz6cPPtXSh+TNjq+GxBX8qz9HxTOjD4wbtGtuuQ40Zw=;
        b=ur2HonE2T7/DuZMbWRD4sh2SCh2HX9qQzsTeLAWvTFmAXXs2F+ZhdbX+M+ZyMl8yZF
         uz1JARUVcDxGOZO5wky/cMPYjjcu/7qXpOdBQeor00E1jg4vk+Ac1s7tE3mIGJLCLE1J
         hqWw99RbrFD1wDnpDlVUzakhIzW414s+3EEcJh2i81fUKAWq4CUsWtQSU91z+ggSzPw4
         UVIdhfFvGAsfNasuJuenhTb3BTmKNSfBpWJ0+1vkoUJga8oZD6Mi9ZWsHkPjgwmWd09+
         zYKo8LG4LlEDir79OXgFmYVHA3t6veesPAd0rLIqxjC90ZskOVByHnBRmN8RyswCc3o9
         RXPg==
X-Received: by 10.68.200.200 with SMTP id ju8mr1145pbc.172.1380337575469;
        Fri, 27 Sep 2013 20:06:15 -0700 (PDT)
Received: from localhost.localdomain ([122.164.156.52])
        by mx.google.com with ESMTPSA id hx1sm11880794pbb.35.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 20:06:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.477.g4cae6f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235483>

Hi,

This iteration incorporates the suggestions made by Phil Hord.

Thanks.

Ramkumar Ramachandra (3):
  for-each-ref: introduce %C(...) for color
  for-each-ref: introduce %(HEAD) asterisk marker
  for-each-ref: introduce %(upstream:track[short])

 Documentation/git-for-each-ref.txt | 14 ++++++-
 builtin/for-each-ref.c             | 75 ++++++++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 10 deletions(-)

-- 
1.8.4.477.g4cae6f5
