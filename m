From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Merge conflicts as .rej .orig files
Date: Fri, 19 Aug 2005 15:06:14 +1200
Message-ID: <46a038f9050818200625d64a12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 19 05:07:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5xD4-0000h9-EJ
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 05:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVHSDGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 23:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVHSDGU
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 23:06:20 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:49894 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750933AbVHSDGT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 23:06:19 -0400
Received: by rproxy.gmail.com with SMTP id i8so429673rne
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 20:06:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oPWDwlNYuOdjj3lHrD1kIBo/Q5cTEhuxXIHzIHxdTpJ3eIOeFdhLvBgumA3E4bgjVhht7SwKtdyggGTFwXd7A2S/Wgf6BpmilK1HkvAiGLwzJe4MRLGuqo/qEpjfM5DndPOXZ+NVL/3gUKQfW4aiqOLlBKm6Z4gXWeCX/WQbRg0=
Received: by 10.38.104.19 with SMTP id b19mr582688rnc;
        Thu, 18 Aug 2005 20:06:15 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 18 Aug 2005 20:06:14 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

After using arch for a while, I've gotten used to getting .rej and
.orig files instead of big ugly conflict markers inside the file.
Emacs has a nice 'diff' mode that is a boon when dealing with
conflicts this way.

Is there a way to convince cogito/git to leave reject files around?
What utility is git using to do the merges? Or at least: where should
I look?

cheers,


martin
