From: Zganyaiko Dmitry <zdo.str@gmail.com>
Subject: Git new-feature-branch best practices
Date: Sun, 11 Sep 2011 22:31:15 +0300
Message-ID: <1315769475.2560.39.camel@mamburu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 21:36:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2pp3-0002fX-B9
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760364Ab1IKTbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:31:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34028 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760342Ab1IKTbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 15:31:19 -0400
Received: by fxe4 with SMTP id 4so188103fxe.19
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=wzmrIlu5iJJKElOWL+5FjnLeRtXLWsOK3pPITCc8/DY=;
        b=S0FTtSPGJ6DSyj7lNQP2kHkvN2uEcmne8GdvE7NfBCDtjDkJFtLO+ubDljcxgXhanq
         hesGTVXu93Wp1P410LU75Ywe3RUX1kmgYRDPsyLefaX0at01BMGSD0duVUO1NDU6x4YA
         UPZQkOTMobt7UFqWKq0Sh+WC/Wwlj41lzJT3g=
Received: by 10.223.49.209 with SMTP id w17mr1383772faf.8.1315769478546;
        Sun, 11 Sep 2011 12:31:18 -0700 (PDT)
Received: from [46.173.65.253] ([46.173.65.253])
        by mx.google.com with ESMTPS id q23sm7236166fae.1.2011.09.11.12.31.13
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Sep 2011 12:31:17 -0700 (PDT)
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181181>

Hi all! I have a question about using branches.

For example, I make branch for some experimental feature. After some
time I have completed this feature. I'll checkout previous branch and
merge this new feature's branch to it.

And there is my question. If I know that this feature was implemented
very good and _will not be changed lately_, should I remove this new
feature branch (because it will be unused)?

Is there some best practice what to do in my case?

So, should I remove a branch for some new feature after its
implementation if I sure that I will not edit this feature's code later?

May be, there is answer for my question already and I missed it?
