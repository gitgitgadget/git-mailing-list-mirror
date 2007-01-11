From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: t1410-reflog.sh broken on cygwin
Date: Thu, 11 Jan 2007 11:35:57 +0100
Message-ID: <81b0412b0701110235u7df1c963k26c757bd15e03eb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 11 11:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4xI8-00065X-Pa
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 11:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbXAKKf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 05:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbXAKKf7
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 05:35:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:6361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030256AbXAKKf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 05:35:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so418848uga
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 02:35:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=e5+woPeOJVf00W6UdW63wuLBAKnfUD61AhjioUdADSBA3l66DU3TeyEzCJKyM0hThiLgJB9G46F3RQV6EUQ2BcHXPOpHZGagl+BD+yp3s/6WQDpfv20ofyMxj64MOLCmBbvQM2TOEVLgHy9evDQGZk9OqpmICeJaqidX/AxRhas=
Received: by 10.78.181.13 with SMTP id d13mr371418huf.1168511757770;
        Thu, 11 Jan 2007 02:35:57 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 11 Jan 2007 02:35:57 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36577>

...because it makes assumptions about X-bit. Which are wrong there.

Have no time to fix it, just noticed it failing.
