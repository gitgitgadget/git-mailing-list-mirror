From: Martin Gregory <marting@adelaideinterim.com.au>
Subject: Issue with sparse checkout
Date: Mon, 16 Sep 2013 22:50:28 +0930
Organization: AI
Message-ID: <SDZPSjFXUiRJMCkwPVQvMjk3OTAwMzE@IBMLT4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 16 15:25:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLYoC-0007F9-Vd
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 15:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab3IPNZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 09:25:41 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41200 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab3IPNZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 09:25:40 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so4113831pdj.31
        for <git@vger.kernel.org>; Mon, 16 Sep 2013 06:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:subject:to:message-id:mime-version
         :organization:content-type:content-transfer-encoding;
        bh=VffkA6IFVxSnZKkSOjTVxO+77xK+QoJa2ttwcZ+ahJo=;
        b=PVEm+4pCdR0krICq2DBvPHqoZfvpWIKz3e6PkGmTNRIsHzQ9eeiV9SEck0dV3jv51Q
         BP2en8YBEs0jsoJPT/GP6HEWta9KxXEJT1nQNuydBgbaE104OCl3M1TNOVst1+L/FVh+
         k/9T/aujh4lyZAC5qsj0S/9SM4zTwW93jdbKnuldqEOq0dmpx3dpeH+FtGwM5aMXNwNj
         z52+NxRm2dSgeUTn8L2wKbOWs+wGWcOe0dy0IL9rPeWh/RPp8MQw0heGmjOMTovfbNvE
         htPh2ra5FGDVesKRKH07W9AleDIcGwJ8Qbmy4dBkhBcM54hIA6kydBtS8UTegfcOS7j+
         6dVQ==
X-Gm-Message-State: ALoCoQmEhwP6+K/MHpuO6gs995wPnQGlo4qCSn9N2e8TNPSJYe93rx52yN+GCk1usoSz49REqKYD
X-Received: by 10.66.158.196 with SMTP id ww4mr31164969pab.57.1379337940059;
        Mon, 16 Sep 2013 06:25:40 -0700 (PDT)
Received: from IBMLT4 (ppp14-2-54-108.lns21.adl2.internode.on.net. [14.2.54.108])
        by mx.google.com with ESMTPSA id bb1sm31260188pbc.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 16 Sep 2013 06:25:39 -0700 (PDT)
X-Mailer: GoldMine [9.2.1.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234836>

I wonder if you can advise me if this is a bug with sparsecheckout, or if not what I'm doing wrong:

http://pastebin.com/HUaWrtef

Basically, I believe that when I do git read-tree, I should be left with only
the directory CONFIGURATION.

However, DV_TDM remains.   But it's status seems to be "indeterminate" from
git's point of view - it neither reports it as being an untracked nor as being
deleted when I delete it.   FWIW, that directory contains a folder which
contains files.

I also tried a simpler sparsecheckout file, with just
/CONFIGURATION

in it, but this was worse: it left DV_SERVICES in place as well.

Thanks for any advice.

This is git 1.8.3.msysgit.0

Martin
