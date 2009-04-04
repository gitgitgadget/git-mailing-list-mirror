From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/7] user-manual: general improvements
Date: Sat,  4 Apr 2009 12:38:22 +0300
Message-ID: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 11:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq2MJ-0001om-1g
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 11:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825AbZDDJio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 05:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbZDDJin
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 05:38:43 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:63046 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbZDDJim (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 05:38:42 -0400
Received: by bwz17 with SMTP id 17so1248807bwz.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 02:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=e3b/+sCdILgw+Gk0Z/GT/BjP4cx1ai6WI+nZunpEAGs=;
        b=rjMBWl307ezOAPRKcyfDIul2NAhjKtRFoGDrmWddSG1F/SPnifTGNodSn4hSgdoOBl
         di1C0gVTGVABi9u8T7B7li+Tek8Rl6F69olKr9xFd6BJHeKT0a6us2FNQNZS6vQBy+5H
         FBagy6xBKxb+m/NouqmB461Hh1SxT+DcSP1IU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=i0KbmlAdP+RYC6n7Cn3VvET92F8vCtKEeH0evIG85DqepvNLUGizIZfJCUsX46/0r/
         9cram+q+ESAXmTFGO8Y/+2eKJ80PcSm0GNh6Gur3oDMEwAJeAGIg2Y+HqnN6zqDqO7Pq
         NoUOP4dD3kTzxBn27GgzTwHmQ8G6QJlvwiduY=
Received: by 10.204.52.197 with SMTP id j5mr756037bkg.157.1238837918259;
        Sat, 04 Apr 2009 02:38:38 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 21sm1296165fkx.19.2009.04.04.02.38.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 02:38:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115573>

This patch series tries to improve different areas of the user-manual,
including style and git configuration.

For a quick preview check:
http://people.freedesktop.org/~felipec/git/user-manual.html

Some changes are non-controversial, like s/git-foo/git foo/ while the font
style changes might be.

There's one huge patch for quoting improvements, which requires the css style
patch in order to look good.

Also, a new section 'Getting started' was added, which currently only deals
with git configuration. This allows other areas of the manual to be less
verbose on 'git config'.

Felipe Contreras (7):
  user-manual: remove some git-foo usage
  docbook: improve css style
  user-manual: general quoting improvements
  user-manual: use 'fast-forward' instead of 'fast forward'
  user-manual: use SHA-1 instead of SHA1 or sha1
  user-manual: add global config section
  user-manual: simplify the user configuration

 Documentation/docbook-xsl.css |   14 +-
 Documentation/user-manual.txt | 1034 +++++++++++++++++++++--------------------
 2 files changed, 543 insertions(+), 505 deletions(-)
