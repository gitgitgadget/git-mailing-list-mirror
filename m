From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Moving a directory into another fails
Date: Wed, 26 Jul 2006 11:00:48 -0400
Message-ID: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 26 17:03:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5ku5-0004P2-1m
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 17:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWGZPAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 11:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWGZPAu
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 11:00:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:17768 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750906AbWGZPAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 11:00:49 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3203645ugc
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 08:00:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hMhSQB5/GegVZkIx6T1mZQ2i2O8GFHRS4V79w+rQoI8mtigKyLbppVleqRezRf6Qz2IvfBqd+IQ+zKF9rT25U1yoC/2Wuo8VNTC+8LHPiDdJBfh/oXQvGrHuXaFBpEvEhqykjX7sv97JdDl4oiLbNcb43FZW43+xkdu+aAEI17c=
Received: by 10.78.164.13 with SMTP id m13mr3153382hue;
        Wed, 26 Jul 2006 08:00:48 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Wed, 26 Jul 2006 08:00:48 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24220>

I cloned a git project. Then in the original I did mkdir for a new
directory and use git mv to move an existing directory into it. I then
used cg diff to generate a patch for the move.

When I use cg patch to apply this patch to the cloned tree it fails.
This seems to be a problem in the git code, not cg.  It is not picking
up the creation of the new intervening subdirectory correctly.

I just synced and this does not work in the current code.

-- 
Jon Smirl
jonsmirl@gmail.com
