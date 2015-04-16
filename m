From: Pedro Rodrigues <prodrigues1990@gmail.com>
Subject: git-archive ignores submodules
Date: Thu, 16 Apr 2015 18:35:38 +0100
Message-ID: <CAL1ZDKZs++NkLoHZ_w_YebQuZYG3rgAiH5SsaQfTmb9MPHjR3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 19:35:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YinhY-0005MZ-IB
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 19:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbbDPRfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 13:35:39 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35988 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbbDPRfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 13:35:38 -0400
Received: by qgeb100 with SMTP id b100so9367427qge.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=WXTNbvFf2WMdOZeAXqwnVQMiDdRdo1LzCSImDa6Kzck=;
        b=gdqauu8rZCyZwfLW3OGANOmY4xXxa9eL1GeZR9A514JN+W/KbzxN/tXhd4OhG7Ge1U
         pI8HmTQ2pbb7HgAuLLXwmACMV0kntJ25y0Gg2Kr5PNVxTMrurelXyPjMlhlBw79G0sw6
         0n6ZY2SglilELgWl08SRKdEFyqf0R48NXxvJ8lS/vgbzgHWcO20Mob1nlyJusEcDFDU7
         s98lEaUcaBtWaKnSBOPmpQ2W7djn4I9W1DNvOHF1+NUZljQEEVyixNE24LqEY+Xq2qG/
         qRaveGYPo4hGO6pg5VKL37oVPLwAlq1PoPlE2wZj5MU0uz8k+1rvN2ruGJ23aohBvtKm
         7QRA==
X-Received: by 10.140.216.18 with SMTP id m18mr41897220qhb.19.1429205738164;
 Thu, 16 Apr 2015 10:35:38 -0700 (PDT)
Received: by 10.140.97.100 with HTTP; Thu, 16 Apr 2015 10:35:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267312>

I've been using git-archive as my main way of deploying to production
servers, but today I've come across a git repo with submodules and
found out that git archive has no option to include submodules on the
output archive.

This simply makes git-archive unusable on this scenario.

-- 
Pedro Rodrigues
+244 917 774 823
+351 969 042 335
Mail: prodrigues1990@gmail.com
