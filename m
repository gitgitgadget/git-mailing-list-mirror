From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3 (resend)] gitweb: Various to_utf8 / esc_html fixes
Date: Sat, 17 Dec 2011 10:22:20 +0100
Message-ID: <1324113743-21498-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Juergen Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:23:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbqU9-0002fp-GQ
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516Ab1LQJXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 04:23:07 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38176 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab1LQJXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:23:03 -0500
Received: by eekc4 with SMTP id c4so3913375eek.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 01:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=oGGcSWR8Ug2pIvr/3nWhfu2jN67YfnEzI6wbqBnhT5I=;
        b=j8mF/QBDvJNIAcFxa3F8WVHt6bqh8gAakC88fHn5ZtQLjosNNmLX1Yma+nWOYD8DcD
         FI+DsLr7WPmULKvTxll6YzuXX5Gx+l5XG/9mjgwRDyx3WgScmdAWLKFcvqmu0hJ06xfe
         MsoEMyaUe9Sdd/hJGpvQJs7NHuSbgrSIRx8i0=
Received: by 10.213.7.80 with SMTP id c16mr1024840ebc.115.1324113782734;
        Sat, 17 Dec 2011 01:23:02 -0800 (PST)
Received: from localhost.localdomain (abrz159.neoplus.adsl.tpnet.pl. [83.8.119.159])
        by mx.google.com with ESMTPS id 58sm10768875eet.11.2011.12.17.01.23.01
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 01:23:01 -0800 (PST)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187358>

Sorry for resend of this series, but I forgot to generate patches in
UTF-8 instead of i18n.logoutputencoding=3Diso-8859-2


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
