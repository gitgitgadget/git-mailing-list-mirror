From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 0/3] Enhancements to the bundle documentation
Date: Sun, 24 Feb 2008 14:41:14 +0100
Message-ID: <1203860474-12291-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 14:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTH7Q-0004ZR-FE
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 14:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYBXNl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 08:41:28 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbYBXNl2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 08:41:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:13969 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbYBXNl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 08:41:27 -0500
Received: by fg-out-1718.google.com with SMTP id e21so928032fga.17
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=OG4xvA54zU/MDdJrTPeg3mpCOsmbeqxAWFRwsgo6dbI=;
        b=DnDg5V/ejgafXZYADnqhpC+bO5HUtDc/Nv0MM86pzExZcTkZ+uGQGs2s1cUXh15ewO2T5pUxXm8GWRx1U1ec+iQ+6SmtTw6ZKgYR/8Ys/3KtZj6BujxPjMH2eREXKeq7m5+auI4Fe1w+3GaLsXEa0ltotbnh2MbSQ3kjNCPCUQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Pz/qtT6a5CVqHTyDlbmaB6BBVy636egvAtiucdDWIUS0bcW9H1h/DXycKZkApaFWWmAqFyvgROUIjsuIaNLhhKp2PnbOErZLjCsPQirjM6e7Yqa73MeMLXNyXWydnHGFRiXjLPeuXxEXAwnOmjJIo3ecfQ3GEqWzEOShq7c6dyY=
Received: by 10.86.84.5 with SMTP id h5mr1639718fgb.49.1203860485995;
        Sun, 24 Feb 2008 05:41:25 -0800 (PST)
Received: from localhost ( [91.13.69.136])
        by mx.google.com with ESMTPS id l12sm3667670fgb.8.2008.02.24.05.41.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 05:41:24 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.293.gac81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74929>

At the end the most convenient way to work with bundles (at least for m=
e) is
just:

$ git bundle create mybundle HEAD --since=3D2.weeks.ago

or:

[alias]
	bpush =3D bundle create bundle --since=3D2.weeks.ago

$ git bpush HEAD

The bundles are bigger than strictly necessary, but not that much.

Santi

Santi B=C3=A9jar (3):
      urls.txt: Add bundles to the list of local urls.
      git-bundle.txt: Bundles as [remote ""] is a feature, not an examp=
le
      git-bundle.txt: Add different strategies to create the bundle

 Documentation/git-bundle.txt |   66 +++++++++++++++++++++++++++++-----=
-------
 Documentation/urls.txt       |    5 ++-
 2 files changed, 49 insertions(+), 22 deletions(-)
