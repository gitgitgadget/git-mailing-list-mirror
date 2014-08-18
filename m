From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Relative submodule URLs
Date: Mon, 18 Aug 2014 13:22:12 -0500
Message-ID: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 20:22:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJRZS-0005o5-BT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 20:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbaHRSWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 14:22:14 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:34827 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbaHRSWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 14:22:13 -0400
Received: by mail-vc0-f169.google.com with SMTP id le20so6325688vcb.0
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=qHFAru17DCHfGuVisSMJgJlQSRD3iIgUiubSMJE7wHo=;
        b=D1O8dHdy7i74xdNkupl6M4U3I11jD3fBvUQY8MbOWuSoYUqMVZIJMBo7Gss3uqzq+y
         4lM8BwfjRURRz/unbZXSIROLmD5OQNj8R9PrL25ZPfsJ2UHJLsbrdXWCsbzdHO+63dr1
         ssFdn/kzbob5eZORxodcP1pUE51iIUWqVfKKfx/RPvlJQG5RFXuYvZoUF9nEhousrfMx
         JgxiFUamCIM7kI671GICHQA1KFdtOUE37ft5/wXx8Qbb7mHUDIOjDi5Lg4IqfXbBQVun
         XkxVbcCoVfqd7UbTxXasJbEiRdiiIiCcH0F3hKI03DN2KMM2RVsjp/8rH9StD7u7CaCg
         4KaQ==
X-Received: by 10.52.248.42 with SMTP id yj10mr1789577vdc.50.1408386132749;
 Mon, 18 Aug 2014 11:22:12 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Mon, 18 Aug 2014 11:22:12 -0700 (PDT)
X-Google-Sender-Auth: j20T2p5AjcTCs_VfXMi8FTVclGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255407>

The documentation wasn't 100% clear on this, but I'm assuming by
"remote origin", it says that the relative URL is relative to the
actual remote *named* origin (and it is not using origin as just a
general terminology).

Is there a way to specify (on a per-clone basis) which named remote
will be used to calculate the URL for submodules?

Various co-workers use the remote named "central" instead of
"upstream" and "fork" instead of "origin" (because that just makes
more sense to them and it's perfectly valid).

However if relative submodules require 'origin' to exist AND also
represent the upstream repository (in triangle workflow), then this
breaks on several levels. There is also the common issue of upstream
submodules needing to be forked as well.

Would like to see if there is a way to workaround these issues with Git 2.1.0

Thanks in advance.
