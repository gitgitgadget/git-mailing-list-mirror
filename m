From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: `git checkout --orpan` leaves a dirty worktree
Date: Sat, 9 Feb 2013 01:20:37 +0530
Message-ID: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 20:51:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3tyr-000532-61
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 20:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946915Ab3BHTu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 14:50:58 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:55060 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946795Ab3BHTu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 14:50:58 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so4431706oag.16
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=RteNrBz9SnC/lSHCk/4KjXPlVWwD8/bcbB2YRWD6rzQ=;
        b=hI/SwdLN3zSW3p8vhS1C4vwlcVDGai8FXAis/6yIpMG8fmG26RYa7Sw/A9Xu1UnEgb
         0JxdpbK0HOiWXTdaB7yRb2isSsGsxQiNKlzJXLZXbOG9kIUBG97uQolKT2h01wS96fyK
         MDrVF4cxuXRkqZMN352ZErI17jF7KB/ogudVRow4Yu3sjIWbtei3y+iBmubIkQ/oUuER
         zBaGSD0nMx4RhoFPIXk3LWBP/ylMuAYvtPuUOKqai038nzyjNA8FD1BEi+7nw26ugY1q
         IkYavl2r+XNOwqvBD8lrdSIELyrnASG0zu7mWqWkgyudeK4x1OIXou27XPueWFQdOy5V
         FuIA==
X-Received: by 10.60.3.103 with SMTP id b7mr5083497oeb.86.1360353057385; Fri,
 08 Feb 2013 11:50:57 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Fri, 8 Feb 2013 11:50:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215807>

Hi,

Why should I have to `git rm -rf .` after a `git checkout --orphan`?
What sort of misfeature/ incomplete feature is this?

Ram
