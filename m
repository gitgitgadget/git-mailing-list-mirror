From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v0] fast-import: Add drop command
Date: Sat, 24 Sep 2011 16:27:44 +0100
Message-ID: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 17:28:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7U9N-0008Ao-8p
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 17:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab1IXP2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 11:28:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48205 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab1IXP2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 11:28:06 -0400
Received: by wyg34 with SMTP id 34so4764465wyg.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dTGiNtGNVb7Z8crl1HS1mjV2kF2+sbOyVF8ESGJr+DE=;
        b=lJVFSoBdMJ2g05ydu+0HGb80aheNov7/YIQz/IwqUJIANj4Uq2is1X6O4hG9ndSjaO
         U8woect+xvQvhAt4TPaMPeERQ+uepNaCUjOivsiLf6U6MCpActkK2zvf7dgV9cLef8X6
         O5AomMIwSYVcPv8iTYNakVEEyOOIfmQxxiM2I=
Received: by 10.216.220.218 with SMTP id o68mr4883741wep.83.1316878084680;
        Sat, 24 Sep 2011 08:28:04 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id fr18sm21661126wbb.9.2011.09.24.08.28.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 08:28:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.11.g4aecf.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182030>

First try in implementing the drop command that was discussed in the
past. Please be gentle, as this is the first time I touch C in many
years. The git internals are also rather new to me.

No documentation and test cases were added at this point. It would be
great if someone could implement the test case for me.

Vitor Antunes (1):
  fast-import: Add drop command

 fast-import.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

-- 
1.7.7.rc2.11.g4aecf.dirty
