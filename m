From: Shouichi KAMIYA <shouichi.kamiya@gmail.com>
Subject: Question about include feature in .gitconfig
Date: Thu, 5 Apr 2012 06:09:41 +0900
Message-ID: <CALOHgxG2q_6EN5HFs=btX2hF4jC7AaJuMu=2AqbCeZBD+wNj3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 23:10:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFXT0-0005xh-Qc
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab2DDVKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 17:10:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37987 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2DDVKD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 17:10:03 -0400
Received: by pbcun15 with SMTP id un15so724335pbc.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=QAAUbc8cTiYQlm37x7Q8vW7svViSMSN7Nl/DCkvghLE=;
        b=VUq+fNVb1h2uxL0Q0/f5XxMiO8v6BP/F2UbsaI1aY1N9XYEXL5L/mjD68FDrQiNpU0
         DmG1yE+qn5CcxFcn7Ylwr7lkqRPs0m72LhsWnzbNILrMG0Z+MTfqReq/pnAZbzs6vV9f
         A4KgWN5O2RQ+iFJuajLpHGZWdBs18fWHtvH6RD6wrwd92sGekR3qyAU6Q6Md6fxBGR4c
         esLioH7PoSr5+0avj3kim0KzZUC1Tg/nZceC5ehBw9EGD3v82L9jdEcIlFesKGgakW/i
         41SpTTVq/wWgAH7+7BP2UYDGtPG7n41VDCAghmJoYjxdOqLTZx/5zI/gWsLSogk/tsJ4
         2l1Q==
Received: by 10.68.197.39 with SMTP id ir7mr1368994pbc.17.1333573803062; Wed,
 04 Apr 2012 14:10:03 -0700 (PDT)
Received: by 10.142.222.4 with HTTP; Wed, 4 Apr 2012 14:09:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194742>

Hello git users and developers,

I have a question about "include" feature in config file.
In .gitconfig I included .my_super_secret_file like below.

# .gitconfig
[include]
    path = .my_super_secret_file

# .my_super_secret_file
[github]
    password = foobar

Now, my question is return value of "git config --global github.password".
I expect it to return foobar but it returns nothing. Is this behavior expected?

Cheers!
Shouichi

-- 
Shouichi KAMIYA
