From: Renich Bon Ciric <renich@woralelandia.com>
Subject: Feature: support for file permissions
Date: Thu, 24 Oct 2013 16:32:36 -0500
Message-ID: <CAGxGTk5eOGoUjrweZ9gLwBE6ev7oCZcu-aWWK2ydtpLkWgx8ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 23:33:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZSWb-00054p-RD
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349Ab3JXVc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:32:58 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42193 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab3JXVc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:32:57 -0400
Received: by mail-ie0-f173.google.com with SMTP id u16so4978049iet.18
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 14:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=poK+OnFsesb2K5LBenMbuXKrNyFHhS27kGPbZdG7Bb4=;
        b=bKsP9asap+EO81TVX37CU3LRHNeKU7vLRh6R8BkmFPuoGbmrD0k9GRDIRKt3e4m4xz
         IarWO3LpxLFbHu0KFflGwdShJWbAdml7HVSJ0Pp9Rwgg3Dt8M+9ynhozkj1c5CikR9qw
         0JOne5HVgm+/gm8eRm7h2C3I7N6FCsRDE0D1UC1qBTffPDg/GPwN3PtoOQ5SBPww93tW
         +pM4ekFVod/I3hVZoykM4rHWxWYp9F5qLxyoJagRhWRx4YLpTMOedNCdNEdKMP/WDCb0
         32RHQr7ACYmQYiomzKb4+lxuwPlO9/mL0v1zeRBiCdTFFreIeKdVnRfoKXtJyDcZKYug
         +RmQ==
X-Gm-Message-State: ALoCoQloY13FdMvNJRKrLCbG5Iu5kLdTdnuQ/9Ta6vthSFOnXNeaXZiU5/yBpHENyE0rlCtrMkdt
X-Received: by 10.50.136.135 with SMTP id qa7mr3373742igb.49.1382650376893;
 Thu, 24 Oct 2013 14:32:56 -0700 (PDT)
Received: by 10.64.20.134 with HTTP; Thu, 24 Oct 2013 14:32:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236628>

Hello,

I think file permissions are really important for source code as well.

For example, in web development, you want configuration files to be
read only; specially if you're deploying with git.

Also, you would want some executable file to not be writable ; but
executable by world.

Permission support would become really handy when using GIT_WORK_TREE
on a bare repo.

Please, consider supporting them.

-- 
It's hard to be free... but I love to struggle. Love isn't asked for;
it's just given. Respect isn't asked for; it's earned!
Renich Bon Ciric

http://www.woralelandia.com/
http://www.introbella.com/
