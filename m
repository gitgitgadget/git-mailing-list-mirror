From: Fabian Zeindl <fabian.zeindl@gmail.com>
Subject: weird rename
Date: Tue, 31 May 2011 21:12:52 +0200
Message-ID: <7760D048-5534-42A2-82D2-D5BB9C75739C@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 21:13:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRUNG-0004wV-Ct
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 21:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931Ab1EaTNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 15:13:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64078 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971Ab1EaTM7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2011 15:12:59 -0400
Received: by bwz15 with SMTP id 15so3911967bwz.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:to:mime-version:x-mailer;
        bh=Uw1WsViPGlWWvUXq2daOxm9oIRO1TloYZQPk3Gfflv8=;
        b=eeqN2xfPxkF4ouyPbRpB8RDgOb61S47g3gaj6X7E9St+Tt8x366QA0hzFJOvNPTU3j
         Ws7ldkfvYcluBCbd867LMwMufsYOPMm4fUzUJC2MxOgxFVE5mMGiOhVfcuhzhEH/b0Nq
         42wsfD40z83rmGAYa6Q6YaFeKoGeMgwHA3A18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=prUxpmocwnqGWvvVor9VOwmz4Mtdowf8Aq7OgcRd0jc8F1a+AQEVphcUjdglB04LMK
         YmsdqhxU9n+oymTLsOB03cUEGxpSnaaXh7pPx86KrzmMiXogGtc1uRn+5khmCV7eUxOa
         1V7hoVwTzKSnQ0gB29B+aTfcjcEm8DGyKZfWg=
Received: by 10.205.32.65 with SMTP id sj1mr1526457bkb.36.1306869178205;
        Tue, 31 May 2011 12:12:58 -0700 (PDT)
Received: from [192.168.1.105] (chello062178219088.12.15.vie.surfer.at [62.178.219.88])
        by mx.google.com with ESMTPS id k10sm275192bkq.10.2011.05.31.12.12.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2011 12:12:57 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174822>

Hi,

 i use a GUI for git and discovered that it showed me a rename in a commit where i actually replaced a file.
So i looked at the commit via git show, and found the following:

Binary files /dev/null and b/lib/swt-3.7M7-win32.jar differ
diff --git a/lib/swt-3.7M7-win64.jar b/lib/swt-3.7M7-win64.jar

Where is the /dev/null coming from?

Regards
Fabian Zeindl