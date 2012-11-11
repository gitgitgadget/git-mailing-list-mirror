From: Thomas Adam <thomas@xteddy.org>
Subject: [RFC PATCH 0/1] status:  Allow for short-form output by default
Date: Sun, 11 Nov 2012 22:53:02 +0000
Message-ID: <1352674383-23654-1-git-send-email-thomas@xteddy.org>
Cc: Thomas Adam <thomas@xteddy.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 23:53:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXgPK-0003hJ-JD
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 23:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233Ab2KKWxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 17:53:25 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45442 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab2KKWxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 17:53:25 -0500
Received: by mail-wi0-f178.google.com with SMTP id hr7so1929822wib.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 14:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=+2J16xz2MxTKmjtOQaPRWBQSuSqylIUdC3DkwmrwZig=;
        b=nZ2WnXjkRX/kfTq7mG7MCFybD/kdNZ6Cb0E0+LND4xJwiwVzX+8I7lzcmSlbgalii1
         QO+p2+duzkByz+u1Lr8iBQOxvTa0/WP+kymEVp7Kts11jReHFC975j7bRlbcrqioMIvt
         a0bs6qqmLIC3UUhO9KUrdsVe1Nr+MZKIA1ZeqJVIbsYyFODojnMWZlj1dFNmgMMj9XaV
         VrqlKyAmc/mhqCFpRZhsxrnIrNQxuR3N1dB2oEdxaChF39q0wAyFWQ2DbUyLJBFZTUfN
         Go42Qe7IixPOIOXVB3dJQ79zwSPLMITYNPHrjAFohGIOP6YtDyjJTLV4205GdaIRIE90
         415Q==
Received: by 10.216.197.230 with SMTP id t80mr7441353wen.90.1352674403876;
        Sun, 11 Nov 2012 14:53:23 -0800 (PST)
Received: from freebsd.my.domain (cpc2-fare6-2-0-cust935.6-1.cable.virginmedia.com. [213.104.227.168])
        by mx.google.com with ESMTPS id ea9sm867018wib.11.2012.11.11.14.53.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 14:53:22 -0800 (PST)
X-Mailer: git-send-email 1.7.11.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209453>

Hi,

It was asked recently whether git status could output the short-form instead
of the long output (via its "-sb" options).  To that end, I've created a
rough POC on how this might look.  It's deliberately lacking documentation;
I was curious to know whether:

status.shortwithbranch = true

Was going to cut it.  Likewise, I was unsure if instead there should  be two
separate options, one for just short (i.e. '-s') also?

What do others think?

ISTR reading on this list recently the addition of a "--long" option to git
status?  I'm wondering how this would relate to that, if at all?

Kindly,

Thomas Adam (1):
  status: Allow for short-form via config option

 builtin/commit.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
1.7.11.4
