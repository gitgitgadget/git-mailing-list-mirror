From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: etckeeper, metastore and mr
Date: Wed, 2 Jan 2008 11:56:22 +1300
Message-ID: <46a038f90801011456l7d6b8c43k3349e9b908bf9e8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:57:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9q2f-00029f-Va
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 23:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbYAAW4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 17:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbYAAW4Z
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 17:56:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:15354 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbYAAW4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 17:56:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2453538ugc.16
        for <git@vger.kernel.org>; Tue, 01 Jan 2008 14:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=RLaLWkA+uMFCD1bQq6T5+iSI3Rp5wXNvd4Tgez5LDcY=;
        b=cr4lnbGwrl6SeXE9lFHxoHIiHq8ZNW67241X2t2OW7qvDGOPt8LuYHPM7iyF+c2Xrcl0pM4kscbU+S/G9y5ldN2RGUEhviQG06iJ+7o03yfwaKKt28ltRZwpKEhxDtSkGAC1f+WSp1COTSqjIKa/mC6CH/IRb3tJVUE9XJysPWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dfB+YeWmE3yZWbwJsj7LxcoMvrLZga/tpGGPAHInk4Fuymu2J9brxiF+/N2NJrK2mZ4DuWzcNNG9WcPGT0hHr3T/Rjrl2UB+HbfNUhnQ4hkQ3F1CHu2M4CHozxLVq8ywookpx543r4sxFOilip1f6VFORCEcYjLlSE6q5pHdDM4=
Received: by 10.67.29.20 with SMTP id g20mr12578378ugj.54.1199228182584;
        Tue, 01 Jan 2008 14:56:22 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Tue, 1 Jan 2008 14:56:22 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69447>

reading planet debian, I found that Joey Hess has written a couple of
git-based tools, and one of them seems to address the "how to keep my
etc with git" fairly well. The readme is educational too. Thought it'd
be worth mentioning them

  etckeeper
  http://kitenet.net/~joey/code/etckeeper/

  etckeeper uses metastore, which sounds useful too
  as a pre-commit-hook
  http://david.hardeman.nu/software.php

  mr - for your cross-SCM projects
  http://kitenet.net/~joey/code/mr/

adding them to the git wiki too ;-) -- with a bit of luck, this will
kill the next "how do I store etc with git" flamefest...

happy new year!



m
