From: "=?ISO-8859-2?Q?=A3ukasz_Lew?=" <lukasz.lew@gmail.com>
Subject: How to maintain private/secret/confidential branch.
Date: Sun, 14 Dec 2008 14:49:50 +0100
Message-ID: <c55009e70812140549t6547c1d6jf7780f91b5074e73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 14:51:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBrNG-00086E-LK
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 14:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbYLNNtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 08:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYLNNtw
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 08:49:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:14211 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbYLNNtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 08:49:52 -0500
Received: by fg-out-1718.google.com with SMTP id 19so990417fgg.17
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 05:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=BbeJkeq/gmNbQVgHP/jkqW1XrK7Bo9qXUab4pyJVMnA=;
        b=KNRKXRW/RiBs2d7GNtZpi1wgzLwSJg8DPx/r1HnSROTq04xYpRslq2mLWlHg+mQ/UL
         HHGGa91rolpvV6wGE0FfkF6H02w17yfR0kd0srdwU3s8A4Wcrl3ZWlMWIDpw1EX+D/MX
         /I3w9/lBXF9H6ICONN/jY3n5lh9jfUNtHNKcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=hAxEFTFeoF5/FhIE3J/ypAtOB/PIf7zn17+cynKuzm2bASHlp34XrweYmiDULw5xKr
         Om/PAYP5s0BBHab/8RqegujOWJ1riYAyjoBh0Lju6VsPRBDVfhMXe15A0YJs4IBYzuz9
         iI8xkPpHR23bl/GLbfosJIFCaShYzc9G3M8h0=
Received: by 10.86.4.14 with SMTP id 14mr3176580fgd.76.1229262590531;
        Sun, 14 Dec 2008 05:49:50 -0800 (PST)
Received: by 10.86.93.2 with HTTP; Sun, 14 Dec 2008 05:49:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103084>

Hi,

I don't know how to make such a scenario work:
- two repositories: pub, priv
- priv is clone/branch of pub
- there is some constant developement both in pub and priv
- there are regular syncs with pub in priv

Problem:
Occasionally I want to push some changes from priv to pub.
Then after syncing with pub I want to get as few conflicts as possible.

Is it possible to do with git?

Thanks
Lukasz
