From: Matthew Mendell <matthew.mendell@gmail.com>
Subject: git-p4: planned view wildcard support
Date: Sun, 6 May 2012 16:46:20 -0700
Message-ID: <CAF0RQx-0M4iUHgGdH=RE_UFmLLZH8uy4kkMW=XspNzGm-vsyEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 01:47:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRBAY-0002bx-4p
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 01:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab2EFXqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 19:46:42 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33145 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab2EFXql (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 19:46:41 -0400
Received: by wibhj6 with SMTP id hj6so2923210wib.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=wNpO+SQXRZ5xdiwFEIQGFclaf41hOUphMjZ9nfllc24=;
        b=j0hMACTEvPCawAYS8LPVEvztQNshZBZI50ad0mk/f8ySPCsecPMBNlkdHihC5bS3mT
         y20qaoDh6z0GmnvZ27q4DnsJzjmX2Qc/fnepAcXjS7psVtzFCsnhBbydUzYTcDyjd6hC
         td5EFM5/nsAXAynq0o+cbpWMpesXU4Jcs9uxnugSq8bJubldMONsgJiGlwt5O2HgjYMU
         F1gdrPOHsNXSzmArOXE/mBErF81IWQA8ovDdHwKgYM5DXpJzpo5yETzqNRRpyDXaeobi
         D7RC8biePCW2i6B5Ny58QQJCFmdcXHSv+p/LXhRJonmieAuKjgTCMSdWU6AddGafy4Q7
         od3A==
Received: by 10.180.78.233 with SMTP id e9mr364132wix.5.1336348000740; Sun, 06
 May 2012 16:46:40 -0700 (PDT)
Received: by 10.180.96.72 with HTTP; Sun, 6 May 2012 16:46:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197222>

Hello,

Is there any plan for the git-p4.py script to support the "*" wildcard
in a p4 client?

The specific test that exposes this unsupported feature:
./t9809-git-p4-client-view.sh
...
ok 4 - unsupported view wildcard *

Thanks,
-Matt
