From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: git-pull suggests deprecated git-branch --set-upstream flag
Date: Tue, 23 Oct 2012 09:23:24 +0000
Message-ID: <1350984204-ner-3492@calvin>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 11:25:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQajZ-0004EF-3W
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 11:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab2JWJZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 05:25:00 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:63077 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753Ab2JWJY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 05:24:59 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1088683eaa.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:mime-version:date:message-id:content-type;
        bh=F6PkgtuVMIBgp+ZIpDotWVdo61TZrveQwqjHGJ/H/Oc=;
        b=wl1hY0AG7ggA8m8gikgjH/YqW0ZDdfZEGDVcYO+qrld35CKpbMzcsSc2/mApOYHAJd
         tlXhA1h9qh9GFNMTdKkRbbc42erJH2OYFy4hrTEQBy7HclI6VRhbTaJlDIzL9JAE839c
         NK+XXa5PUOFPD2+JzrtyIqX1oBgnlALGUtGv+0JhjDeEAOZz1weP7pED6B0VawsRKSOS
         DrVSFX3sCChZmUXDzOPtjaN/szfTWVp0Kpg5+BtDoJzQIUL0aJjdE/PrFcTE4lt2krPQ
         koBYgTxMofPsMVASOOAry3zsYBZuzZFOVe+T33ggkjJOswZCXALZjcSJj60IlDk4Xuk8
         Hkvg==
Received: by 10.14.199.134 with SMTP id x6mr15959767een.31.1350984298228;
        Tue, 23 Oct 2012 02:24:58 -0700 (PDT)
Received: from calvin.caurea.org (250-3.79-83.cust.bluewin.ch. [83.79.3.250])
        by mx.google.com with ESMTPS id e7sm4921364eep.1.2012.10.23.02.24.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 02:24:57 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 2ADC9114865; Tue, 23 Oct 2012 09:23:24 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208219>

I just ran git pull, and it suggested that I should use `git branch
--set-upstream`. Yet when I used it, git-branch told me that the flag is
deprecated. Git version 1.8.0.

tom
