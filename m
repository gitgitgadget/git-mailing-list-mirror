From: dturner@twopensource.com
Subject: [PATCH v6 0/3]
Date: Tue, 12 May 2015 13:45:56 -0400
Message-ID: <1431452759-17732-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 19:46:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsEGA-000283-HV
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 19:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001AbbELRqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 13:46:21 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36017 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932918AbbELRqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 13:46:21 -0400
Received: by qku63 with SMTP id 63so11009492qku.3
        for <git@vger.kernel.org>; Tue, 12 May 2015 10:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=cIZi7pKoGNV897mz6Aj1RX81Bq2L2aHzykQT5ySy+S0=;
        b=ctVuQn/nUYV04YjLHkdGJZK1ukavRKvSU78Rx5e+baQBaTRkpZEgMpVXdFF7ObB284
         aqB7YymwNWSrU4CDOVRAXDcqdF+r11CYx+gKLPvXjngd0RkihCWjYXLPKRke9vbx0d07
         IECmWn2Jg5RQXymsU7ALDuraoD6mFBrQmsDSHijPHUGYO6aL8iE4NUPrCGVuH9CBFyiC
         OcO/tWPbh0EOpSFcKvo1mngBZtuVzuE/oMx0yoyEWdkpzuhx6d2n14YcHfoG1MzVVb3+
         d8GIRFhoOTnQMpJat57VACWuPxGnu5Pq5OdGQY9nYE/AbmcmdHwGNmQ8/MDC2k4x/dgc
         ONzg==
X-Gm-Message-State: ALoCoQnjoj8CyM6LuKEun56SMemNL4HuQhPnIWYLeFX5mVz8gHDqQ0h6fT3VNPv/8k8G1K7xaAki
X-Received: by 10.55.23.96 with SMTP id i93mr35287555qkh.75.1431452780272;
        Tue, 12 May 2015 10:46:20 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id 143sm13700748qhw.21.2015.05.12.10.46.18
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 May 2015 10:46:19 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268863>

This re-roll fixes a couple more issues found by Johannes Sixt: use
of a size_t instead of an unsigned long, and a broken &&-chain.
