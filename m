From: Tong Sun <suntong@cpan.org>
Subject: Mirror plain directory under git
Date: Mon, 20 Sep 2010 15:12:45 -0400
Message-ID: <AANLkTi=9nqfzR-Zo85LieBuhv97oudCVZCex8ZL3mM0t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 21:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxlnX-0004od-Co
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 21:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185Ab0ITTMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 15:12:48 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52115 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab0ITTMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 15:12:47 -0400
Received: by wwj40 with SMTP id 40so1875wwj.1
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=DaOw+cIyUwTi/mxg2O91JmzDX/IeccdApUmyHWKazhI=;
        b=cybaUcy7tnjBCDeLTnlULwRgNQQRc3EQFKJ9MjCJLCbsUnQzNMmlbWN/pKfCiPkoWw
         4fG4CaODHbEVDvUOoPw10pG0DybPMlDIiF/8H2TUkR5K2aTfxb5WGsphNd+OrxJ2/8FI
         aNjVzqDpVxlgDi+wEqiOeHOyLM6QtlxGXtHbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=VYov5gmn1GVSTm870zVgofP49GAXtknjLKyAafS1vn9/ggd3UpW3+XenTg9xWy0eUF
         1YcTR6G4jef3lg/HWkodoC4KCMniL8IC0mVULu2b6e6lC2Y7VLTaKQCGmZ02hNMtcTMe
         QCcnpU0Bb5pif77tolainRhhPAOW8rjT2ABgg=
Received: by 10.216.21.204 with SMTP id r54mr8166958wer.95.1285009966028; Mon,
 20 Sep 2010 12:12:46 -0700 (PDT)
Received: by 10.216.180.81 with HTTP; Mon, 20 Sep 2010 12:12:45 -0700 (PDT)
X-Google-Sender-Auth: xAPQHRI1KO77eFMCU_qkibSyOqI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156650>

Hi,

How feasible it is to mirror a plain directory and put it under git
revision control (leaving the original intact)?

More or less like what etckeeper is doing to revision /etc directory.
I.e., I want to use git + some magic to replace rdiff-backup, so as
not only easily to restore, but also easy to track revision changes as
well.

It is just a wild dream?

Please CC me when replying.

Thanks
