From: Jimmy Thrasibule <thrasibule.jimmy@gmail.com>
Subject: Re: Git and Quilt
Date: Mon, 09 Jul 2012 15:00:29 +0200
Message-ID: <1341838829.10119.42.camel@sysadmin>
References: <1341835029.10119.36.camel@sysadmin>
	 <20120709162042.0149100574d2d04497a952fc@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Mon Jul 09 15:00:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoDa4-0006PM-LC
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 15:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab2GINAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 09:00:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59575 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab2GINAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 09:00:38 -0400
Received: by eaak11 with SMTP id k11so4315198eaa.19
        for <git@vger.kernel.org>; Mon, 09 Jul 2012 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version:content-transfer-encoding;
        bh=YBqDVwCf6D9nb4dDnnrzNAZkoueAJNNCbT6ZWUDoTro=;
        b=BFjKw7c/u6FbXtZfg8ONXBaJP+3V3D0TNGmQbOK82A0JntsAAm2pg0vamB+YeSiIfM
         XY1iAyCMwyiWMrkiDSTTFnIFl+12QQ7de9BqIvXLm0AeaDuhFbLgFEwgQl9YwxYWO6Ud
         M1xkTOkkAE1HnTNNDaH8dkkPrDC0ygbMAt56zfQivc1hCDqAf8ADfUGZTrQaXmJ5OOwB
         80jPQXe3dxsFoeR+xZP5uYVv3YuhhUUGRFS+RN1YRkPiLYNxPzWdWcIVMCU208eY/Xbc
         9gLAB98zlSSvUpYPko8XFKwupr4+aLu5q6lfWReDxDJ2JrX/71dyFm0lf5qapakWTOjV
         q9nw==
Received: by 10.14.95.79 with SMTP id o55mr9867373eef.163.1341838837319;
        Mon, 09 Jul 2012 06:00:37 -0700 (PDT)
Received: from [10.0.0.45] ([213.246.250.146])
        by mx.google.com with ESMTPS id h53sm93702593eea.1.2012.07.09.06.00.35
        (version=SSLv3 cipher=OTHER);
        Mon, 09 Jul 2012 06:00:36 -0700 (PDT)
In-Reply-To: <20120709162042.0149100574d2d04497a952fc@domain007.com>
X-Mailer: Evolution 3.4.3 (3.4.3-1.fc17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201202>

> Isn't what you're doing a perfect fit for rebasing [1]?
> That is, you keep your changes as a series of commits on top of your
> "upstream" branch and each time you're about to bring upstream changes
> in, you rebase your local branch on top on the updated upstream branch.
> 
> 1. http://git-scm.com/book/en/Git-Branching-Rebasing

Yes it can do the work, but I afraid that it gets messy in a
collaborative work as said at the end of the article. I prefer to
maintain my patches using Quilt so everything is clear.

--
Jimmy
