From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 0/4] New git-related helper
Date: Fri, 31 May 2013 02:46:16 -0500
Message-ID: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:48:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiK4K-0004D2-DC
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab3EaHsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:48:08 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:51310 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab3EaHsG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:48:06 -0400
Received: by mail-yh0-f46.google.com with SMTP id v1so331074yhn.19
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=c3tA3M8GnCI4/iG/A4EsdUx4m/UnSQhEPpfSij20n/o=;
        b=d/QC9UTRbWFVSdGwRnLPFY3xhgECl11cfgcwon02oi+xmV7U47D3hADzvtU04K1LXv
         D4y92vjoFEyjIcKTywr4cfi/ji3rpdeyd7wkdepMzGr7QxsJLJzPQbVF/AE9rLjTod0q
         R34Y4dXgnfzWHrXcThye0ZpywqIjdWNyan6/ioqv5M6YBn/XMpxERzh54zQ64q0ZQDGy
         M0ppVsO+PxSmR8w7w79XyQ40BAr1pWIq0eBDuvjMhoMMzsqhVoTP2mK9qRljomqni0Dt
         6OdDJymO4bTmjY6Clf51KN0GEQFzuoc5FdZnYVaEuzI7bfcCA8Q1jo2bGrB5kWBCG3/2
         5ERA==
X-Received: by 10.236.26.68 with SMTP id b44mr6205956yha.198.1369986484552;
        Fri, 31 May 2013 00:48:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v31sm24730774yhe.13.2013.05.31.00.48.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:48:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226065>

Hi,

I changed my mind, this is the same as v9 but minus some potentially
controversial changes.

Felipe Contreras (4):
  Add new git-related helper to contrib
  contrib: related: add support for multiple patches
  contrib: related: add option to parse from committish
  contrib: related: parse committish like format-patch

 contrib/related/git-related | 172 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100755 contrib/related/git-related

-- 
1.8.3.358.g5a91d05
