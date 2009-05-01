From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/4] user-manual: general improvements
Date: Fri,  1 May 2009 11:44:18 +0300
Message-ID: <1241167462-5984-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 10:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzoMf-0003LM-B0
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 10:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbZEAIoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 04:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbZEAIod
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 04:44:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:4668 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZEAIoc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 04:44:32 -0400
Received: by fg-out-1718.google.com with SMTP id d23so30873fga.17
        for <git@vger.kernel.org>; Fri, 01 May 2009 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fr/2go4XEBFGlSaa6HbKDMyj8HKudGWyJNSagF8WUK0=;
        b=sEVwjJhsg2q9egg6EbD1/2H5XGDf5F00Ej4nUgyO5ySv9xZ5JzPMCUhMtC3l0s3Myt
         Mnb4MQPvZju8xg92BzuACKARLAYXEVm7OrsbnLWdfelToBuCtp2YQDwhI8yAhu7rm/VD
         FCLIHRpnYys+s7mJqNLgmO0sBETOUo11JVgMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pCOsX47dOrk+sCp/aqRx6lezzVeZyNP4/E1CCu43JMyITA/n0eVzxoUHmiprlXAjLd
         JDR2/mbXVIL4j5MErcDglP4XJ+HhFSbKaUbDsGOVl3HR3BJVCH9+uNPgewePdHfXmV16
         aK7Zo9RXChejrtIHXIa0j+yZ1i7G/1t9B9Ot0=
Received: by 10.86.59.2 with SMTP id h2mr2647631fga.73.1241167471758;
        Fri, 01 May 2009 01:44:31 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id e20sm414759fga.25.2009.05.01.01.44.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 01:44:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc3.13.g195b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118061>

Part of the original patch series was already merged, this is the missing part
modified to address the comments.

Felipe Contreras (4):
  user-manual: general quoting improvements
  user-manual: use 'fast-forward' instead of 'fast forward'
  user-manual: add global config section
  user-manual: simplify the user configuration

 Documentation/user-manual.txt |  923 +++++++++++++++++++++--------------------
 1 files changed, 474 insertions(+), 449 deletions(-)
