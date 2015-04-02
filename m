From: "Reid Woodbury Jr." <reidw@rawsound.com>
Subject: git 2.3.4, ssh: Could not resolve hostname
Date: Thu, 2 Apr 2015 10:18:33 -0700
Message-ID: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 19:18:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdilO-0006im-DO
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 19:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbbDBRSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 13:18:37 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36850 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbDBRSh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 13:18:37 -0400
Received: by padcy3 with SMTP id cy3so89991598pad.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 10:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=Gh1yEe1gj3LEYszVUkTQFgTSTvO4/Lp+nm2yuc2RiSU=;
        b=C6sZ92jN046mD53RtgzcxnEga/EM4r/nTXiQWBBPXte46ZjkJDozav0XUgP0sA5zqE
         ZgyroHKd92wm+8a1YzbDVRteiAKmsMVfkwUTAlh53mLnAvNNd9lsuu1SLo+tw6mizOxW
         V7kH1NBscDgqwPWb5D7gkD/OqY9PXG39RS5VD87dcv9Q0uCo2TdSSjXhxYdebUEYy6dS
         XlX4Mec3+LebVEGLV7Ol3+wy7Sfdg7kXeeE0yOjoReOY+0wNOPbO9bzJ408KW0PWXYZQ
         nQVWBqAMCtWEXjq8isiEOpwEHX69y0k4YfplzKTZaF71QK/aF7V4pIJhtjo5YLdZAvB7
         3vvQ==
X-Gm-Message-State: ALoCoQkIb3CCFFrEjDFdUZ96GtxNK/gjtOnZ5WBOVy3zV77VR9BsfeUUCAcIQijaxD65TI4KAV+H
X-Received: by 10.70.88.16 with SMTP id bc16mr88213665pdb.140.1427995116416;
        Thu, 02 Apr 2015 10:18:36 -0700 (PDT)
Received: from [192.168.1.87] (107-128-47-25.lightspeed.irvnca.sbcglobal.net. [107.128.47.25])
        by mx.google.com with ESMTPSA id kl10sm5775253pbd.15.2015.04.02.10.18.35
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 10:18:35 -0700 (PDT)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266649>

Dear Sirs

After upgrading from GIT 2.3.3 to 2.3.4 (on Mac OS X 10.10.2, installed with MacPorts) I received this error message when doing a push:

$ git push
ssh: Could not resolve hostname xxxx:: nodename nor servname provided, or not known
fatal: Could not read from remote repository.


It was working previously and nothing in ~/.gitconfig nor .git/config was changed. I rolled back to 2.3.3 and it is working again.

Reid Woodbury
https://github.com/diskerror