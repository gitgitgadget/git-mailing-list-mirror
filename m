From: David Turner <dturner@twopensource.com>
Subject: Git autocorrect bug
Date: Wed, 04 Jun 2014 23:49:05 -0400
Organization: Twitter
Message-ID: <1401940145.18134.170.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 05 05:49:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsOfz-00031B-QI
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 05:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbaFEDtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 23:49:10 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:46030 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbaFEDtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 23:49:09 -0400
Received: by mail-qa0-f41.google.com with SMTP id dc16so603579qab.28
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 20:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:content-transfer-encoding:mime-version;
        bh=vyS46J2OL0oDeU7Yu0b9qjw5FHFeyEuP3ouWGQrDHkc=;
        b=Kf09+L2afGWoBoWiAUxVP+f4f2+oXFT60SpWGAWM1yC4C8swqhL2VXpTMoxku1EE/l
         cPxJ2IJtY4PeuiHOxUgeLDHKUWeaPowqS3FaBrxanF3D00WsjQP3n0/EJofKjMaqVh5C
         veHtbAxlkkAbboiuNb4FNRI5Y7cEWl3Jo1mu550nVcVWPA6Ym7X5gfIpV/0+ASi/02bG
         OjPC3dnqIswekUezs14Z4O1aw5rU8IC2zcjRV8oIqQyibFn/fghhebED3mFbRQpL2Adc
         jl1mFENg7lxSFV8Y3g2HAEs72sqYni4YJsBozhnvuaTDmfrexgT+Bzsed14XOBBUjGDw
         G2/Q==
X-Gm-Message-State: ALoCoQks3ViAIzOYnTCBJaBVSdZ8i0im8nIok1ha8ViiGHn2TCdDpQMmDOPJXmGapLVvS3EcLrz/
X-Received: by 10.224.28.135 with SMTP id m7mr13286641qac.44.1401940148731;
        Wed, 04 Jun 2014 20:49:08 -0700 (PDT)
Received: from [172.18.24.70] ([8.25.196.25])
        by mx.google.com with ESMTPSA id j3sm2962032qgj.24.2014.06.04.20.49.07
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 20:49:07 -0700 (PDT)
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250803>

$ cd [some existing git repo]
$ git git foo
WARNING: You called a Git command named 'git', which does not exist.
Continuing under the assumption that you meant 'init'
in 0.1 seconds automatically...
fatal: internal error: work tree has already been set
Current worktree: /home/dturner/git
New worktree: /home/dturner/git/foo

(I am extremely unlikely to fix this bug myself, since it only arises in
very rare circumstances).
