From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: pre-receive - 1st push / rev-list didn't work
Date: Mon, 28 Jun 2010 23:25:51 +0530
Message-ID: <AANLkTikGtbfcHCUXm7aVljj_Opb3blKWC0dzfq_HiV8-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 19:56:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTIZF-0005zE-LX
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 19:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab0F1R4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 13:56:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40770 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab0F1R4A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 13:56:00 -0400
Received: by gwaa18 with SMTP id a18so2115256gwa.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=UG1ITv2//9/7MI7H2IWYOv9pT5Wt+blffcGBZ4BOrTQ=;
        b=BXCwbYqpyEh4Qwxom4y6QSHZ3AMjwzB33y1enq5dhMIm+prBQq8zemKIkQxpIAjt5k
         x5wmedHRQM2t/sLAyMLj/5f/c1BWCh9NjmX8/RUo272QGfiVfgZ5GfdNglo5WHkRr/9c
         vbtpl7yLtCWB2q1DbKmZpQviR6lb7adSudB7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=nrHE0crqkH3++p7mYqUP5x5f3XiNI4fQf/BQQRWrv1juLdgrRqiAXWcRlsRcwP1vsi
         CI4f16Idnf+XHuH9UZU1Dt4BHsXgERZwavZ2d2Egyr6Ao2jJF4YKavtYXfaGXEWKNzMD
         65w79QpOrYQ85/+g2lijZcPwH9p2KGL4ZpnPA=
Received: by 10.90.80.7 with SMTP id d7mr464335agb.189.1277747752018; Mon, 28 
	Jun 2010 10:55:52 -0700 (PDT)
Received: by 10.90.25.8 with HTTP; Mon, 28 Jun 2010 10:55:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149844>

I am writing pre-receive hooks for commit validation. I use command
"git rev-list <from> <to>" to determine what am I pushing. I can
possibly pust more than one commit at a time.

If I am doing 1st ever push ; then <from> becomes "0" (40 times). How
do I determine what all commits I am pushing i this situations ?

Thx. Mahesh
