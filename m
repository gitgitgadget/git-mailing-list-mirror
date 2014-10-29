From: Peter Vojtek <peter.vojtek@gmail.com>
Subject: Is there way to set git commit --date to be older than 1970 ?
Date: Wed, 29 Oct 2014 19:49:19 +0100
Message-ID: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 19:49:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjYJW-0002X5-2J
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 19:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067AbaJ2Stm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 14:49:42 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:47945 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbaJ2Stl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 14:49:41 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so1929905iec.40
        for <git@vger.kernel.org>; Wed, 29 Oct 2014 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=QjXll4WM0iMyQ/PuXmZEunWPzOMzVbz1Xv1TgrT/pcg=;
        b=lB8MY0pZ2iJk2KqqauSLyuHmXVOyKcf9eNRebj7aKrPQKZkXL4U1XKw69cxGZ8klhU
         E0UE10sxb6IyjI/YP7hOKihJhTrOBNOASRfOJCW0o1zonqZd1nXbRQnYCAKSLCfN03J2
         J8bx0GzfxYFrsf1L+wc7WjTf93NKewF6S7sjm4sLkpjZt5XCucWCdrj0CH12jkNZcbli
         2+1Qt+Go0mZJ9Anflr4Gq6oJL23DTolNntGlZPpkgAYFRMTkYKxeZhI18cLTCEvP9jVw
         CxambXtmEupXg8+5dYkhJ3401VlOMrf97tiuJH8x/I4VORZiIHeV39VC6R0CYOrdPcQ6
         WxvA==
X-Received: by 10.50.253.67 with SMTP id zy3mr14934882igc.45.1414608581358;
 Wed, 29 Oct 2014 11:49:41 -0700 (PDT)
Received: by 10.50.207.3 with HTTP; Wed, 29 Oct 2014 11:49:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I am playing with git in slightly unusual manner - e.g., to use git to
store history of europe:

$ touch Italy
$ git add Italy
$ git commit -m "add Italy" --date="01/01/1861T01:01:01" # Italy
gained sovereignity at year 1861
fatal: invalid date format: 01/01/1861T01:01:01

It seems the commit date can be between 1970 and 2100 (on my 32bit
linux), however man git (section DATE FORMATS) claims ISO 8601
standard is supported.  ISO 8601 allows even B.C. dates (via minus
sign).


I understand that this is rather an esoteric use case :)

Regards,

Peter
