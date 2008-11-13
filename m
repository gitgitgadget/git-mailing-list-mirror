From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 0/3] Add a customizable Tools menu.
Date: Thu, 13 Nov 2008 22:35:47 +0300
Message-ID: <1226604950-18667-1-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 20:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0i2K-00079I-S5
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 20:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbYKMTh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 14:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755817AbYKMTh6
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 14:37:58 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:32443 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803AbYKMTh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 14:37:56 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1027419muf.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=wi9iy2eqbDuk/zp7QnWe1ceYyamrUfnMLxLlnj1O5TA=;
        b=HT0BSHaAK/zYdIXdD53LNysWsm4zsbNTPL4ViY7cVL12biOvAJoNReZM1TPAtmrWCm
         G2oclCDylcFQEnbHJdDM9HGvS0xKFXqpnobHsot/LTutzPZLVNUo+4j3cJTsvbNOpICo
         On6x/MCSmExZiASKuQPUWrYxdO6UpmwUVROZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YM67aHxcxmwGUGBMDVpPwsqGzo0DWkIDMHxwhJG//MkOsgtXq+OeBas201GBDk4uIM
         u1oVKoj0IBPo2Sx/wP3DjvUNgwTA52FQVY+8FOwta5T4KEGOJIbfSFZQfZn7pbddt6EZ
         rK+mQ/lzv4cEMMP9mtzBSlLznVAWz35MhJV78=
Received: by 10.181.156.11 with SMTP id i11mr22440bko.177.1226605074694;
        Thu, 13 Nov 2008 11:37:54 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id h2sm5268685fkh.11.2008.11.13.11.37.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 11:37:53 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100900>

This series adds a configurable Tools menu, that can
be used to call any external commands from Git Gui.
It reduces the inconvenience of using tools like git-svn
together with GUI, by removing the need to jump between
the terminal and the GUI even for simple actions. QGit
already has a similar feature.


PATCHES:

    git-gui: Implement system-wide configuration handling.
    ---
    git-gui.sh     |   12 +++++++++---
    lib/option.tcl |   12 ++++++------
    2 files changed, 15 insertions(+), 9 deletions(-)

    git-gui: Add a Tools menu for arbitrary commands.
    ---
    git-gui.sh        |   17 ++++
    lib/tools.tcl     |  107 ++++++++++++++++++++++++
    lib/tools_dlg.tcl |  234 +++++++++++++++++++++++++++++++++++++++++++++++++++++
    3 files changed, 358 insertions(+), 0 deletions(-)
    create mode 100644 lib/tools.tcl
    create mode 100644 lib/tools_dlg.tcl

    git-gui: Allow Tools to request arguments from the user.
    ---
    lib/tools.tcl     |   13 +++-
    lib/tools_dlg.tcl |  194 +++++++++++++++++++++++++++++++++++++++++++++++++++-
    2 files changed, 202 insertions(+), 5 deletions(-)
