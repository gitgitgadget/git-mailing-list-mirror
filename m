From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V3 0/2] git-p4: improve client path detection when branches are used
Date: Tue, 21 Apr 2015 23:49:28 +0100
Message-ID: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com>
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 00:50:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykh04-0006l0-Qv
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 00:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbbDUWug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 18:50:36 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34817 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965069AbbDUWuI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 18:50:08 -0400
Received: by wgyo15 with SMTP id o15so228940765wgy.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 15:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5C6rCmkKAwAXUk5j9gJgwPyl1z1niH9LWVqpePWnceE=;
        b=IZxWkmJ1E0PyMQltyOxNNVAsIWTfoKKEgNIc71ttYsMWwmHTCPSsLenPVWT3uD17f3
         jZbpyufG+Mnt9V4C5XV39+d48ymElE0yqAcvFRAEy84lDzgPV85KHq8te6pTIZZmpkV5
         B+sjtOvVqUh1NeCFdCq5TSbKMOM4lWLAV/VojhJBCmyobn0I1tINT+yLgtRq+OPDXTJr
         a7imsv4Ou8OSdctO02YW6yLLKJRzV6RKWB/vJmRySa9iB6z/HRaxSdcX54n3JN8cSBpd
         urTR+56KsgpLZsdgCLA8IrjVlgm3Ugquia6+F9FHd6vsGu/Yspk/sRXJ4i/P2fdQM6g0
         ujMg==
X-Received: by 10.180.188.193 with SMTP id gc1mr486446wic.7.1429656607696;
        Tue, 21 Apr 2015 15:50:07 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id dg8sm4573201wjc.9.2015.04.21.15.50.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 15:50:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267565>

The updates introduced in the third revision of these two patches consist only
on updates to the commit messages to better clarify what they implement.

Vitor Antunes (2):
  t9801: check git-p4's branch detection with client spec enabled
  git-p4: improve client path detection when branches are used

 git-p4.py                |   13 ++++--
 t/t9801-git-p4-branch.sh |  106 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 4 deletions(-)

-- 
1.7.10.4
