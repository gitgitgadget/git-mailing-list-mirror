From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH 0/3] jgit: Verbase branch command
Date: Mon, 18 Aug 2008 21:01:42 +1000
Message-ID: <1219057305-9284-1-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 13:03:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV2Vp-0003uM-66
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 13:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbYHRLB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 07:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbYHRLB5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 07:01:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:60016 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbYHRLB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 07:01:56 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1218265waf.23
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender;
        bh=c3HkzWq2t8afRS04CooepSi0IOSXpJ8kePPeiEtoDAU=;
        b=FDXE/AHvTQwdYkm5shDb+O/gA5L7AGOsBUrMjEsSt/wapPbdD3z6qM5k0RTtRzgR72
         ILb5qcD+lvbPt5KBVVysMV9lVedx+Swo9td2Da9A/qj5l5O37GpiZjL2j2hTKs5y+Cbt
         /th0FM+J8lPTg18qWQiuMrp3nX7WWl2BfObUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=jpZcz/XOhgVzcdJ8+mRSZVVCxjYBq/pO93cu7xZSthW4h+CjyVttnCmHthpRO/dfYk
         MxqW2FUpN+Z4BU18u+fK623yJEPrs2ec0cchycJ2Vm16dmLJeUjgUoUJuhl9Q/uftLnZ
         CkQNNPYuytZMxTSQv/UYBUBPko04O0XJM86PE=
Received: by 10.114.153.18 with SMTP id a18mr4835327wae.161.1219057316086;
        Mon, 18 Aug 2008 04:01:56 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id m28sm1842154poh.10.2008.08.18.04.01.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 04:01:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.g2ebc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92695>

Verbose branch listing added for the sake of completeness

Charles O'Farrell (3):
  Extract RefComparator to sort collection of Refs
  Cleanup of Branch command ready for verbose mode
  Verbose branch command

 .../src/org/spearce/jgit/pgm/Branch.java           |   60 +++++++++++++----
 .../src/org/spearce/jgit/lib/RefComparator.java    |   72 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefWriter.java        |   14 +----
 3 files changed, 120 insertions(+), 26 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java
