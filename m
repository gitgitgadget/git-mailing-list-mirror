From: Pedro Sa Costa <psdc1978@gmail.com>
Subject: git push in a git-init without --bare option?
Date: Sun, 26 Jun 2011 11:42:28 +0100
Message-ID: <201106261142.28142.psdc1978@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 12:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QamoL-0005u6-5X
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 12:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab1FZKml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 06:42:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58139 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab1FZKmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 06:42:38 -0400
Received: by wyg8 with SMTP id 8so584842wyg.19
        for <git@vger.kernel.org>; Sun, 26 Jun 2011 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=25Aci9yi/hYwemTErCgjYlDDjxIoRjFVD0JYztBZGGc=;
        b=rztjS9xLqs/8D/pzMXTWKdSUmUpjsxTZJ8JZvbLwGtCCGpVa9NukaXOHOkEkJ/Z3rO
         ELCqK/4qnC8yKe5HVNAXh01q7okl9pUxTax0/Bnk5f9JhonYLTEeqeG92g27498r44uq
         05hY76pdMUbNtdIP8Hd+QH2X3PbYUT3Mc5PSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=PfAScz3b3it8t0dvy5opdWd6N78Q7B+iryIyZYQudGN6vwqrYPU1kBJ8ffbb+2CwFT
         EAFOTQrOvzm/c5LkdGhbJm/zbzwwHiITxe8Q21aac/L2sAdzuK4pTYq3KxaekxTX5ER3
         XYRX/IUaEtY+uFpJO4LGP0+007zUdSXye7ozA=
Received: by 10.227.38.101 with SMTP id a37mr4487332wbe.36.1309084955717;
        Sun, 26 Jun 2011 03:42:35 -0700 (PDT)
Received: from barcelona.localnet ([81.193.33.138])
        by mx.google.com with ESMTPS id c17sm3291911wbh.29.2011.06.26.03.42.34
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Jun 2011 03:42:35 -0700 (PDT)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic-pae; KDE/4.6.2; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176321>

Hi,

I'm newbie in git and I'm trying to understand how git works.

- I see that in git, I can't do git-push to a repository that wasn't created 
with git-init --bare. Why?

- But doing git-pull and git-checkout to the same repository is possible. I'm 
really confused. Any help?

-- 
Best regards,

-----------------------
