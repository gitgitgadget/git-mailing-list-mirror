From: Evgeny Kotkov <evgeny.kotkov@gmail.com>
Subject: Re: git svn fetch segfault on exit
Date: Mon, 2 Sep 2013 15:57:33 +0400
Message-ID: <CAPWhs-6E_9T61uf20YKXzwE2j8Tq-sOU9BUw_dVVe=LAH69_iw@mail.gmail.com>
References: <51E7B382.8050302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, uli.heller@daemons-point.com
To: Jonathan Lambrechts <jonathanlambrechts@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 13:57:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGSlZ-0007GQ-To
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 13:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758273Ab3IBL5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 07:57:54 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:59878 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab3IBL5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 07:57:53 -0400
Received: by mail-qc0-f174.google.com with SMTP id e9so1122819qcy.19
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8DsyBvwNHJsxrCXfya/4J5fQkH8jybmQn6x22fboVhY=;
        b=owJSTtL7GNzIQtwlRapooQBWecnZBKXY3/QAjWvnt+37X3Tn3UXgmOcbxnC7jIaGJk
         9LWt5qINCyaGajaMcUhYdjoBIFmUms/LF3lkGBcSz6wSEl8YiKmpEEvqjjBxUNf+VVP6
         60J5c5hsIxZzU2JBisHFiY851/wBpmVkyLAU94BwB+5A5kxHJ7AfGn+HjpTZFLP9WAPe
         0CN8sM1V9B1Lbckjh9u3uxi71BrzpROXMuXru+/EhZCjnzORf6MVgMYWpioQom075VSN
         FCDA+D3gURt9nX1W9LxjDYTbWhkFVmWGOTZJ5gYt3ttmXuSB5t/Z2t4bvDqSbalT9+Je
         0aRw==
X-Received: by 10.229.47.71 with SMTP id m7mr848751qcf.25.1378123073076; Mon,
 02 Sep 2013 04:57:53 -0700 (PDT)
Received: by 10.49.81.176 with HTTP; Mon, 2 Sep 2013 04:57:33 -0700 (PDT)
In-Reply-To: <51E7B382.8050302@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233634>

> Every git svn call that involves a fetch produces a segmentation fault on
> exit (but the operation succeeds).

>From what I see, this looks quite similiar to the 'serf' issue I've recently
reported to the serf-dev mailing list [1].  It should be fixed by now, so,
the latest serf@trunk build should work fine.

[1]: https://groups.google.com/d/msg/serf-dev/gOn9HTUN98U/pz0_AqdrmJYJ


Regards,
Evgeny Kotkov
