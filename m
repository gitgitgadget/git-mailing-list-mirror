From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Various to_utf8 / esc_html fixes
Date: Sat, 17 Dec 2011 10:15:21 +0100
Message-ID: <1324113324-21328-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Juergen Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbqNn-0000v5-4K
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136Ab1LQJQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 04:16:07 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57685 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1LQJQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:16:05 -0500
Received: by eekc4 with SMTP id c4so3910006eek.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 01:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=YrCFP8y1oRIBqAWmnS/rWB5jWLcNxDjljQPi4mWHZ3Q=;
        b=TeRvUP1ZZgMmqQFcDkqxPmggDEBdY1QolHotAc1tQaGCiFkw+VR3BSB7zfQTSRAxU+
         mPA/9wkkGRK7pSgxWH75tqMTjcKthFMT95XCvUXWiUjRFPlgs3/yHrGv7vpGufXhPW4m
         ZHk4pMOuujL6Uwx58npuCwbvou+/dF/EfVSkE=
Received: by 10.213.17.208 with SMTP id t16mr1029217eba.117.1324113362954;
        Sat, 17 Dec 2011 01:16:02 -0800 (PST)
Received: from localhost.localdomain (abrz159.neoplus.adsl.tpnet.pl. [83.8.119.159])
        by mx.google.com with ESMTPS id q28sm10728465eea.6.2011.12.17.01.16.01
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 01:16:01 -0800 (PST)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187354>

This is post-release resend of J=C3=BCrgen patches (which were sent
during feature-freeze).

I have slightly extended commit messages, and added my ACK.

J=C3=BCrgen Kreileder (3):
  gitweb: Call to_utf8() on input string in chop_and_escape_str()
  gitweb: esc_html() site name for title in OPML
  gitweb: Output valid utf8 in git_blame_common('data')

 gitweb/gitweb.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--=20
1.7.6
