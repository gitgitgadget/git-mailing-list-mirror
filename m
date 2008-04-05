From: "Chuck Ritter" <cfr100@psu.edu>
Subject: git clone error
Date: Sat, 5 Apr 2008 13:20:25 -0400
Message-ID: <a00d3c7f0804051020u366e978ei7252c904c48461f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 19:21:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiC4m-0004tD-Ah
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 19:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbYDERU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 13:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbYDERU3
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 13:20:29 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:25381 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbYDERU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 13:20:28 -0400
Received: by el-out-1112.google.com with SMTP id v27so427365ele.17
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=rc6KK9MwQbLO6UIIDZpriKsjJ4eRzJCHNNE+JsGZ/Ps=;
        b=T71/QCGt3r5MDsoOgcej23NTx2/CZV4iuXUUFMJOJSrs7e7oDDY3PprItsYW3sB+j3Wuwcu4xfd+BKTVctgJOLzUq2+aROHng0OqoUPlEE3eYx7P75GqXpg3AVkP6d489oQwkVi7FZ8o017tRjixFeGBuDPOg/xDF/92JDDRP0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Etr9s2hbxCiffETumAW4AtAACMnjisAQXR91JmOdQ87ex8FkHMYdQFkCMMyhjp5WgVMR9qPXkDq+LXRmY529o6Sz9uvnm+J/gq1Rdb1WFFJ5prUFFYDIcUnAb8QRwoSWQae1BJ8/GQF6m0BPwxC5fv8Rl6GIuWwUERnAcneHLPM=
Received: by 10.114.195.19 with SMTP id s19mr3952457waf.58.1207416025504;
        Sat, 05 Apr 2008 10:20:25 -0700 (PDT)
Received: by 10.114.192.13 with HTTP; Sat, 5 Apr 2008 10:20:25 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 08b2b53ad950a5c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78854>

Hello,

I'm getting an error when I try to clone a git repo:

$ git clone ~dab143/src/OVER-REL/SOURCE-GIT-TEST OVER-REL
Initialized empty Git repository in /home/cfr100/OVER-REL/.git/
cpio: objects/pack/pack-80a0460fc07be5e0628b02549fdaa186b792d3f3.keep:
Permission denied
888 blocks

# cat pack-80a0460fc07be5e0628b02549fdaa186b792d3f3.keep
fetch-pack 31620 on githost.arl.psu.edu

Permission on the keep file are 600. Of course this looks like a stale
lock of some sort.

We are using git version 1.5.4.1. The owner of the repository had
pushed changes to it from msysgit under Windows. I am not sure of the
version. It worked fine before that.

Is this an issue I should take up with the msysgit developers?

Once in this state what is the best way to resolve it and verify the
integrity of the repository?

Thanks
Chuck
