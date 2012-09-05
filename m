From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Renaming a remote is 'rename', but removing is 'rm'
Date: Wed, 05 Sep 2012 07:59:21 +0000
Message-ID: <1346831961-ner-2892@calvin>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 10:00:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9AXB-0007HV-2M
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 10:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab2IEIAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 04:00:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:46984 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab2IEIAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 04:00:14 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so195371wey.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:mime-version:date:message-id:content-type;
        bh=geWo4dftWflgBiah3KUH1XUZTv/1FkzqGm5e/Fu/6NY=;
        b=kap/YjNk4XlYlFrvYdcbmfb0WXJMCKJGjYRn0fyj6gJ17lzUo/XWFsS052zOIILRe3
         xhU3FGCSDWB18xronXgKkd19K/p7Uadojjmw7pFIaSch7spxiVO0r/fOTg4LoCDrGwRy
         m8+PuIlhAvpM9U9R7r/OolSexKXNhXbF/nGIYSicqaFxUyone6eZOlsypNKtEL81re06
         0n3bipKou8uicrjPiJ6j+l0kpSGl84qghddwmXQ9Llx3m+w9trk7Ve08VBy6qJNGJULN
         bYJDca/oVVAWv30kCmkGjM3uA5qT6R7E629UAyWnGlEHb7VDRL/EA+hsH2bbjk/llaiI
         X9RA==
Received: by 10.180.105.130 with SMTP id gm2mr36212568wib.6.1346832013553;
        Wed, 05 Sep 2012 01:00:13 -0700 (PDT)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id cl8sm27889642wib.10.2012.09.05.01.00.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 01:00:12 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id B11AB588B84; Wed,  5 Sep 2012 07:59:21 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204801>

A fella on IRC was confused by $subject. And it did bother me sometimes as
well. If you don't use `git remote` often, it is confusing that the commands
are named inconsistently.

If I know that there is `git remote rm` then I kindof expect `git remote mv`
to exist. Because I am used to rm/mv and git rm/git mv as the standard unix
commands for renaming and removing something. On the other hand, if I know
that there is `git remote rename`, with the verb fully written out, I expect
`git remote delete/remove` to exist (or something similar, with the verb fully
written out).

Would there be any desire to make the subcommands more consistent in that
regard?

tom
