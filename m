From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv4 0/3] gitweb: patch view
Date: Sat,  6 Dec 2008 16:02:32 +0100
Message-ID: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 16:03:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8ygq-0001n4-Uc
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 16:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbYLFPCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 10:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbYLFPCM
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 10:02:12 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:47170 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbYLFPCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 10:02:11 -0500
Received: by ey-out-2122.google.com with SMTP id 6so180690eyi.37
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 07:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3KDKkgxTQ+wENyaLklqBcXrCRdFRO01qCHWCvIFK+W0=;
        b=IYyxDRlSdQuNOJGNlfZnbISC99nTY15CidX1TcKbo3TN0lhrSowMhjZfmtAI4Pl902
         Gxq1wWbZ8bQ772xv0AyLbXwgflcqW4AKHHRf5+hQ+ScHLcOzcWKYl2ayWmRdVo817QrI
         Dckv0k2SKLj1VYoVCo56xncTmutMPURrZiWh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MDwsb/Cc1780y2Qcn65XdfNzVeNEwy5AiA71K9tAacvkvMWY2wVUhsCQTM2Lw4SwZQ
         K3o9zwZ9itnqEtoQs6hs10cDFOwlfGv+fvm5mUyL6Oiv8aIMlW+7vQQnC6MEph8ui42i
         8ewi0i3JIbqwyhSMcE4Eru7MpkHUUTlVfxmdU=
Received: by 10.210.120.7 with SMTP id s7mr1328436ebc.78.1228575729148;
        Sat, 06 Dec 2008 07:02:09 -0800 (PST)
Received: from localhost ([78.13.53.163])
        by mx.google.com with ESMTPS id i8sm1698758nfh.27.2008.12.06.07.02.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 07:02:08 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102459>

Fourth iteration of the patch view feature, that exposes git
format-patch output in gitweb. The most significant different from the
previous revision is the introduction of the 'patches' view, that only
differs from 'patch' view in the treatment of single commits: 'patch'
view only displays the patch for that specific commit, whereas 'patches'
follows the git format-patch M.O.

Giuseppe Bilotta (3):
  gitweb: add patch view
  gitweb: add patches view
  gitweb: link to patch(es) view from commit and log views

 gitweb/gitweb.perl |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 106 insertions(+), 1 deletions(-)
