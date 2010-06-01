From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Improve git-am error messages
Date: Tue,  1 Jun 2010 11:20:19 +0200
Message-ID: <1275384022-12131-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:19:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNcs-0001VH-Dr
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab0FAJTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:19:05 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:11682 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab0FAJTC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:19:02 -0400
Received: by ey-out-2122.google.com with SMTP id d26so242089eyd.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=va3y4gMCyIQqdD9Ryv4q1DHJPf/2vX3j3T20gQ7XsJU=;
        b=pCN+RtIOAPMjganJTTZ5yGDKR2ppGHNkJoCxoYhVlOcRJ4Mq+h9kIxn/akzwx6VJte
         T8R42OEv1ExR3+IfyYXM2zEkGchF+bGPLxMkpchXypI2zfcgISgBaYbv/GbYhs/ZxrRK
         cVzD9WOr1KqyQnZ0g+AjevWmO1U/725QbPvKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PXL+VSTRg4i7EyA0NBE4SUm10tFUi4OSwvZSoznq8TLLbNAiqVy4agOugW9cOOfhEF
         hCIRS/Emw50QGzzf93MNOZWGy4Xg9zynol3AvrVRQbDCALEeZA1Z6W/LBQ+ze+E0Qpm8
         eesFaOW5OOkpeVIfkBcUGZG+rSCmNSsbsm/+4=
Received: by 10.213.15.146 with SMTP id k18mr3126600eba.80.1275383940698;
        Tue, 01 Jun 2010 02:19:00 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm3629676ewy.4.2010.06.01.02.18.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 02:18:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148095>

Hi,

This patch series aims to improve some of the error messages in git-am
that I came across.

-- Ram

Ramkumar Ramachandra (3):
  Initialize cmdline globally, not in stop_here_user_resolve
  Display some help text when patch is empty
  Remove stray error message from sed when continuing without changes

 git-am.sh |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)
