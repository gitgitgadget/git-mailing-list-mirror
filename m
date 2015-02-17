From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: 'make test' fails in pu
Date: Tue, 17 Feb 2015 09:39:17 +0100
Message-ID: <1424162357.30155.14.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:39:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNdgk-0002f4-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 09:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbbBQIjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 03:39:22 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:53376 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919AbbBQIjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 03:39:21 -0500
Received: by mail-we0-f182.google.com with SMTP id m14so27687546wev.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 00:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:content-type
         :mime-version:content-transfer-encoding;
        bh=6Zuexeu+tcEmvFCrownNE9xGPEGOYPZ3JZSUFWGkWJI=;
        b=c995cfzYVxQoTohCiu+1cdtQhhXxO0zvbYCoB9lReV8dQWTWAfx/W1Y1EipUdNCkMr
         IbEj6UhLUSGhSUOLkuB9RnpR8r3Lmz/B/GDwR/sWBHTo34VjilJUSrOzqh18ggRmGRsL
         caVtk/JkUsrdZIrODt7KjOywgi+4BW5vlF4cAMhRDe2HQ7sBCLZ31U+hYAZGSJu21VJE
         iDO7fw556WCr9Gol7tLBvdcBWaoZduKPZHiWxjSNjLY3xsP8fDbZY6uAtCq9PWeIVQuM
         XmBs0qznIFS/tSq+mYnab3FFkOSRAf8uY9+ONjrLn8DPqF56TiCJ161JfvAC/5qUnma4
         jp5A==
X-Gm-Message-State: ALoCoQmuT6J18Z7MnVU+BuRoGaLz6++OrT5otM7P0BzDw3jq7Zho1CbiZQbA3AFbpx9C4MegUGVt
X-Received: by 10.194.133.101 with SMTP id pb5mr60628287wjb.40.1424162360009;
        Tue, 17 Feb 2015 00:39:20 -0800 (PST)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id d10sm26279549wjn.45.2015.02.17.00.39.18
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2015 00:39:19 -0800 (PST)
X-Mailer: Evolution 3.12.7-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263936>

Make test has been failing for 'pu' yesterday for and today at
t4016-diff-quote.sh. Full log:
http://ci.kaarsemaker.net/git/refs/heads/pu/1df29c71a731c679de9055ae5e407f3a4e18740a/artefact/test/log

I noticed this a few times before and it tends to get fixed again
relatively quickly. So I'm wondering:

- Should I even mention that it's failing, or is that just useless
  noise?
- If I should report this, I could also make my testing thing send 
  mails. Would that be useful?

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
