From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH v2] lots of documentation fixes/rewordings in git-init(1)
Date: Fri,  8 Aug 2014 10:29:13 -0700
Message-ID: <1407518960-6203-1-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 19:30:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnzo-0002Xw-NS
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbaHHRaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 13:30:20 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:45168 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaHHRaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 13:30:18 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so4101514ykp.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=55fK0KSg+lrYsj07aDOzhOO5gdxjGCIcgkvJMe/1iT4=;
        b=paqTGCt96QdDABt90+6Q0dPnT2Tjr4eJkCHxCBULTQC1ApQdzM+93fOiN1/jmLjd5B
         VBrMauPBKHxuMTLz5sfCXwiDDzE4KFSyLBizXzA5M9nmpg1fCl7AcKB1E8iTuOTqp+0k
         YeVP0bXWqOybzAe1IS4PBZ/LZDGLKdz58fyJIgOcM1n7Q63sMKXpIsUG3eJKcOrkzwE2
         iuvkfjtVISdr3cM6NqpLpUpBOOQBBfbYoOo4q1h6ginuonE/VaRm6NH56LUfBv5uY4DP
         YY4SK4h5YZO2cgeKTwMus0oO0I7/6OzBSHjAOx+uePGc854/5Npqp7nBvhTS9pGwKGuE
         ST9g==
X-Received: by 10.236.142.227 with SMTP id i63mr16314484yhj.88.1407519017954;
        Fri, 08 Aug 2014 10:30:17 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id u47sm6776458yhm.35.2014.08.08.10.30.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 10:30:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255050>

Hello,

Aside from the changes stemming from the discussion, I have also separated out
some typographical changes from patches 3 and 7, and squashed them into patch
1. So, those commits are cleaner now.
