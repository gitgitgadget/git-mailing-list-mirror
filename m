From: Ilya Basin <basinilya@gmail.com>
Subject: are X-like merges bad?
Date: Wed, 16 Nov 2011 12:20:09 +0400
Message-ID: <972241491.20111116122009@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 09:20:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQajG-000345-Jy
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab1KPIUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 03:20:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56957 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab1KPIUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 03:20:13 -0500
Received: by fagn18 with SMTP id n18so1156897fag.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=rJtngurGwYSYnsI7sHvPWNrGfQvaOWieTrInIF+hgeI=;
        b=CeikDUoA/qTgvieQoEb6LeUrfF9NsoIZOex7cJCZ+SX93exKAt+qfw5t0RFDesLKey
         jjCBpH5AF4Xlu+448Seminn8ig58Q6olEMK6yEbsuH3r5PCLGUZRlWjEoqJr93mDzWH8
         EEcY52w+JQIZ2n8JD1rBNQbR7yx1mwI89Zeec=
Received: by 10.205.128.138 with SMTP id he10mr27719701bkc.13.1321431611742;
        Wed, 16 Nov 2011 00:20:11 -0800 (PST)
Received: from BASIN.reksoft.ru (gate.reksoft.ru. [188.64.144.36])
        by mx.google.com with ESMTPS id h7sm28325427bkw.12.2011.11.16.00.20.10
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 00:20:11 -0800 (PST)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185525>

When you merge branch A with branch B, you can then fast forward
branch B to the merge commit. git merge even does this automatically.
Such commits have 2 parents and 2 children.

On both branches 'git log --first-parent' shows the same history
before the merge.

Is it true that in this case you can't filter commits by branch name
in 'git log'?

I'm thinking of using 'git merge --no-ff' since now.
