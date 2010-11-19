From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 0/2] git-p4: Rename and copy detection improvements.
Date: Fri, 19 Nov 2010 01:38:11 +0000
Message-ID: <1290130693-30855-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 19 02:38:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJFvi-0005q8-Dz
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 02:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084Ab0KSBiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 20:38:16 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52154 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab0KSBiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 20:38:15 -0500
Received: by wwa36 with SMTP id 36so4062924wwa.1
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 17:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VmSy19Kah+G9IPzAaQdQxBpOQD6OGed4AwZ3sgcVUQc=;
        b=ooWlBoXBsbum3ujDEcJOU8d/diE2uhBgpW+wj/Pr4W7Jugs39adZlnQsFJIBpdMmGR
         w0jcTGtMhgc9xYxZaUbXmhsLtD6ciKhz+efaDzGJ+YPNJ4gsop8mgZutaY8PPTJav/XI
         SCxTBtTuv3UqFxa4LJAPSDw2uApFYaHOe6SZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WWyJHULsR5NMO7L04dm6+fuLwgQr+JMgwOzcdkpddRE5sV3ydpBYUN/3PsA6ELIrJV
         8g8vNr8l3qdXNyX7FXrifQeShWVaj56S6DL+uw1uOU3ReNSlru3WAPcSursZvIufnFdm
         ICwzVEbJlCTsPYxw0aYjs3OFBEb5SMBa8PniI=
Received: by 10.216.244.11 with SMTP id l11mr344001wer.43.1290130694097;
        Thu, 18 Nov 2010 17:38:14 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id a2sm540988wer.17.2010.11.18.17.38.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 17:38:12 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161720>

Two patches to improve the rename and copy detection implementation in git-p4.
Also added some configuration options for ease of use.

Vitor Antunes (2):
  git-p4: Don't edit renamed files if not necessary.
  git-p4: Added copy detection support

 contrib/fast-import/git-p4 |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

-- 
1.7.2.3
