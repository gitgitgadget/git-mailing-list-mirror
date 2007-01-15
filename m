From: Andy Parkins <andyparkins@gmail.com>
Subject: git-fetch while on "(no branch)"
Date: Mon, 15 Jan 2007 10:09:50 +0000
Message-ID: <200701151009.51868.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 15 20:05:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2N-0000RF-Uc
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:27 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9W-0003eK-G1
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbXAOKJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbXAOKJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:09:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:14732 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbXAOKJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:09:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1306708uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 02:09:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jn57SrlYCQUESb4pyJdlXboHczMCwsrEGeFSFSJfW5XjvByMK8QnxSSWF+4r9e3tUelAcGYMqsyYVFQQ//UVtfe0fDvID1Qezkv78iPjqzOYiGw+Zqb6rAVOwACluf2IQOoMiOzYDx6G1xhiDOIyvKTg6eeBUJ4M/vlAnOKYzYI=
Received: by 10.66.219.11 with SMTP id r11mr5144612ugg.1168855795799;
        Mon, 15 Jan 2007 02:09:55 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id e33sm6615252ugd.2007.01.15.02.09.54;
        Mon, 15 Jan 2007 02:09:54 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36859>

Hello,

Just ran this while on a detached HEAD.

$ git fetch
fatal: ref HEAD is not a symbolic ref
fatal: ref HEAD is not a symbolic ref
fatal: ref HEAD is not a symbolic ref
remote: Generating pack...
...etc...

The fetch appears to have succeeded anyway, but it's a scary message that 
tells a user something is "fatal".  Has this done any damage?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
