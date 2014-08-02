From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH] lots of documentation fixes/rewordings in git-init(1)
Date: Sat,  2 Aug 2014 11:06:50 -0700
Message-ID: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 20:07:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDdiJ-00078X-GM
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 20:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbaHBSHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 14:07:10 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:39464 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbaHBSHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 14:07:09 -0400
Received: by mail-yh0-f52.google.com with SMTP id t59so3365461yho.25
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Q8flmod4IqCGfPDH8JfMiDhH76N1zWv4IMCnqPwr1HQ=;
        b=rTvEQpBrC883l6K+1w2IICUrXQJslrlio6t8p1ZHcCXdP3JWaZtg67Tq2uiz0PmCvr
         KtW50sgoH/rc/Y2kK9pv5BmFIArTSRmBBQFKtZyfvwhGQWz+DPt3j7Tyl0V70Ba+CnBM
         t1y5qbxL7HQdibz/K9iuns4tLKNOswWOh2Kc7XBNU4cnBFt4djyygBYt4FjUqQ2DBATC
         cjuPgw4JKIBVhNtpYwtr+h5GTQGq3/UzPLkpPTsSg/C3xi2nGFRiDSWzxJNy1FiRPd7L
         UKhiTUn+urrQawaSt9p5vuft93Z2LFxZcjnXufjW6JpcY0z3drntIw74wa9ChTwOsd92
         hI7A==
X-Received: by 10.236.120.130 with SMTP id p2mr4129195yhh.166.1407002828043;
        Sat, 02 Aug 2014 11:07:08 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id i24sm20618668yha.12.2014.08.02.11.07.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Aug 2014 11:07:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254705>

Hello,

I noticed a typo in git-init(1), which led me to some related changes. All
changes are in Documentation/git-init.txt. I have cc'ed the people involved
(thanks git-blame), just to make sure that my changes maintain technical
accuracy.

I've tested out the compiled man/html/etc. files and everything seems to look
correct.

This is my first patch submission to the git project, thanks!

-L
