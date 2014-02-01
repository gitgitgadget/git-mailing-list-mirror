From: Duy Nguyen <pclouds@gmail.com>
Subject: splitting a commit that adds new files
Date: Sat, 1 Feb 2014 17:48:34 +0700
Message-ID: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 01 11:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Y8n-0007BU-7r
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 11:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbaBAKtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Feb 2014 05:49:08 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44642 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbaBAKtG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 05:49:06 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so8664496qcy.15
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 02:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3DArARG4CfYbnbcn39L7Y0RVA57avMLDVlZwEXp1Uf0=;
        b=ph18BVQcn+Bsqha+yPvBuwkb1wCVB3hNwctKHlVSIWivqe2PR8sgXeOBoIjhp3qSCC
         b86Nk3sUML9BVxqHQ2+XmgEqFRV3UruzDP8w9l2SzYGEv/BZFp40ezRTWlfTUtZTNqim
         p1L2nozDKnpCJVg2rfBxqSsJpaitZ4NmhhemQDTEY0LhJQDUUwSlLGgAuU7UynOA9fVF
         999uNzUhxlGQyE7dWO1rbU43ZaA367W8fZXLDzVuv77PTMR0C/F3X4DQ9YApzGXH588y
         aIIRS/PgEX1Z+Wc1aSaK4WElP9vSITAbnUeL9gEItPx7l/qWyBxfE2QkKQfPhPbh4GhQ
         Eceg==
X-Received: by 10.140.47.212 with SMTP id m78mr37182143qga.21.1391251745314;
 Sat, 01 Feb 2014 02:49:05 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sat, 1 Feb 2014 02:48:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241343>

I usually start splitting a commit with "reset @^" then "add -p" back.
The problem is "reset @^" does not keep track of new files added in
HEAD, so I often end up forgetting to add new files back (with "add
-p"). I'm thinking of making "reset" to do "add -N" automatically for
me so I won't miss changes in "add -p". But maybe people already know
how to deal with this case without adding more code?
-- 
Duy
