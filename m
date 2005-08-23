From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: cg-update/cg-merge refuse to update if state is dirty?
Date: Tue, 23 Aug 2005 20:09:04 +1200
Message-ID: <46a038f905082301096285a3cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 23 10:09:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7TqI-0001ul-1r
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 10:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVHWIJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 04:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVHWIJF
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 04:09:05 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:50594 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751172AbVHWIJF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 04:09:05 -0400
Received: by rproxy.gmail.com with SMTP id i8so1111833rne
        for <git@vger.kernel.org>; Tue, 23 Aug 2005 01:09:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pyBnDu89+CWH3lTo6VxTNbzviEKzPiuoHdogCapKe0Fror9GjprHvQ0yK3SFN3v/EbCiwXmmEDR0CCk1N5TSrNj+lNTafI++ABXAIcAhWCWcvgWttw9foL/mEUO8cJ1rBTn85jOQhLJuDdROx2K9lMj4g/Hi4iGI6St6PPLrapE=
Received: by 10.39.2.74 with SMTP id e74mr326158rni;
        Tue, 23 Aug 2005 01:09:04 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 23 Aug 2005 01:09:04 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Should cg-update or cg-merge be refusing to merge if the tree is
dirty? If there are uncommitted files, and the merge fails, a lot of
unrelated changes will be dumped on the working tree, which ends up
with a mix of things.

cheers,


martin
