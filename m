From: anatoly techtonik <techtonik@gmail.com>
Subject: git gui is not GIT_TRACE=1 compatible
Date: Mon, 22 Jun 2015 17:40:59 +0300
Message-ID: <CAPkN8xJWAnfgqRa5sTTf_g8jFoPWpN_6od8R19nfG=8ksuepcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 16:41:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72ua-00087C-N4
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbbFVOlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:41:20 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36057 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbFVOlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 10:41:19 -0400
Received: by qkfe185 with SMTP id e185so101350401qkf.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=4Fx3YLaE1eRzw2T7/QA8Pz8PAFbo2Vqv4F5sImL1i14=;
        b=jsYUnFEGWg1XgtEyE/bAOABQBJORGDXnZRe7xJM8gvFuC+naaL0yuof5dDWNvkRBkZ
         OprLbSkCzMkIlr9RyWHzDAtclidskudxy2mfSrQI8q4vPa2fEcMR3h6E6Wm2ivsCxgu7
         BfhNm7xfY0Hy0sesr3+PRXybRzbcxClThaborjYpf12xAOxJQS7u6y6q//C4dravgmwK
         JwwHH7uudb/dVlAHdBR46c2Eb9qCgotegIZogxfs5aK3H9bwlbk8aJa/Cuij3DWhfdUA
         V6Q/rjYkQ64d4R9Z5/JFAv7PwmpW053gLUm/EgV/6nr6tJrYvC7oF1sXN3TkY7YpoIo3
         k2kw==
X-Received: by 10.140.152.72 with SMTP id 69mr39318345qhy.85.1434984078687;
 Mon, 22 Jun 2015 07:41:18 -0700 (PDT)
Received: by 10.96.42.136 with HTTP; Mon, 22 Jun 2015 07:40:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272364>

https://github.com/git-for-windows/git/issues/218#issuecomment-114085764
