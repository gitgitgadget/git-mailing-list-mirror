From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 0/6] Enhance popup dialogs in gitk.
Date: Sun,  2 Nov 2008 21:59:43 +0300
Message-ID: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 20:03:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwiEC-0005yD-FJ
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 20:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbYKBTBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 14:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbYKBTBq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 14:01:46 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:15346 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbYKBTBp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 14:01:45 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2459943fkq.5
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Xw/eJFhJB6wrJJqMoYPBfAP7LMO+Ab8fM2myj5M9ciU=;
        b=mJXNy4IVjADDOPkRuaoOJ3O4Xanj50jmPFG5WtbWI0dyzNkOkEM3y2JPJYIrxgR++N
         7YtQxOOjrsBgqS9PrFDMzsUgj+jYpnjJ8UBm1g8cQpLyB6ITN8Z7PR/XM1+Y76bMkfNl
         61aZTaTPAr+yz42GF37XvgguErWNZvZGXy0mU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=x46CesJhHzEXaXujxsEwoF1N9retbrHu/gPdMYIb8kdMFXVRiXAGtMWt6Yt/Z90oC6
         G1J7iHlSCjP8wwhW16it3gCxVPUzt4IEzJHqc25s1cimrlC8kdJ8VXpjPvviAh3huKL4
         uTYsyu+zeu/s7y35C8AkZxrA11bc6ODCPDY8c=
Received: by 10.181.137.13 with SMTP id p13mr1575932bkn.54.1225652503475;
        Sun, 02 Nov 2008 11:01:43 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm8536420fks.6.2008.11.02.11.01.41
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 11:01:42 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99862>

This is a resend of my gitk patches rebased on top of the current
master. I also split the first patch into three parts.

Alexander Gavrilov (6):
      gitk: Add Return and Escape bindings to dialogs.
      gitk: Make gitk dialog windows transient.
      gitk: Add accelerators to frequently used menu commands.
      gitk: Make cherry-pick call git-citool on conflicts.
      gitk: Implement a user-friendly Edit View dialog.
      gitk: Explicitly position popup windows.

 gitk |  375 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 303 insertions(+), 72 deletions(-)
