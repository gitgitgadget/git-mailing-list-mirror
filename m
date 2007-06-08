From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: p4 + svn + git
Date: Thu, 7 Jun 2007 21:45:27 -0700
Message-ID: <1621f9fa0706072145s3ea6d5cdt3c3e6a2eaaffa14c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 06:45:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwWM1-0002gK-N5
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 06:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbXFHEpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 00:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754908AbXFHEpa
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 00:45:30 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:33567 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbXFHEpa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 00:45:30 -0400
Received: by ik-out-1112.google.com with SMTP id b32so638540ika
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 21:45:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gmF7tzTk/BPeViYZNciUpXNbZ5dwUcMyyYdtwz907yuJGYuBVOZ5XsPQVWyUqUtuQwJRtTKZBjeRemLCfHrAXlrXv6+cBQQ4x5bSaIO/zBg11zsaVNiFb71oPkqiUZo2de0BbDcerIX/3zwAWeRdf1tMqmsF0pXcxQsrwbyUUAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AbLewFuJAWHyjd5iL7ABfJywL6tte89qPqk3nGWVPIFuqIKnUVwtFcJCiziKZWE0tM6c+8CBOfR3V1etTUIVXmkLz9o2OaQTpnSkff/NmPk6KoN8Gx4FVT865en1lj4iZCbXCarmJswyxAWSc/bqBrMNywKjYyHY+km5NsiwoNI=
Received: by 10.143.35.1 with SMTP id n1mr130038wfj.1181277927748;
        Thu, 07 Jun 2007 21:45:27 -0700 (PDT)
Received: by 10.143.43.1 with HTTP; Thu, 7 Jun 2007 21:45:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49429>

That might be too much, but let's ask anyway...

My company uses perforce.
I took a snapshot of some code checked out from perforce (a single
branch), that I imported into subversion, a while ago, and started
working with svn only. I have different Unix machines checking in /
out code code from the subversion server (with svn), and I'd like to
keep it this way (if possible).

I'm wondering if I could use git as a gateway between both systems, to
merge code in both direction (svn <-> perforce).

Is this possible, with the help of git-p4import, git-svn, and using
several branches ?

Thanks,
Benjamin.
