From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: sha1 of the repo excluding history ?
Date: Fri, 13 Apr 2007 02:26:40 +0300
Message-ID: <f36b08ee0704121626i6a27dcecp8b0b10e0f7db2ef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc8gg-0000AI-Rx
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 01:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbXDLX0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 19:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbXDLX0n
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 19:26:43 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:37894 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbXDLX0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 19:26:42 -0400
Received: by wx-out-0506.google.com with SMTP id h31so710530wxd
        for <git@vger.kernel.org>; Thu, 12 Apr 2007 16:26:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TZC8U8leoAS7vQpWWGT/rih0RrZgd5PcKHwaHtpMRNNR0DlNR56o5cLdjWvMI3YH6m0aLvnbXJcIrXrM2Db6QMZzOqgyAS70iTSARSVaXGIIsujtUtoDrjPol4dC6jmaEkeGr+t3YtBd3CqBheSjrMbNfiTJiK0eGcfGbyQR/fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eZD1caCPLqpDwKKYGSHyOOSveIc34yBq4T4DxJlHBBopZUDZWSNM6dduby0wNdT9IBvn1dqoAa16UYvuMcXtl1khDfWkF43t0gJezW0NVjq90/MXoco3iJRvJWd4ux9wyrm6bmYzwoqX/so6JALWAsryNFFKAULbDJl17di+0fA=
Received: by 10.90.84.17 with SMTP id h17mr2598291agb.1176420401271;
        Thu, 12 Apr 2007 16:26:41 -0700 (PDT)
Received: by 10.90.83.13 with HTTP; Thu, 12 Apr 2007 16:26:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44367>

    Can I obtain from git the sha1 of the total last state of the
repo excluding history ? This is a state that covers contents and
names of all files and dirs, and x perm of files;
but excludes history, timestamps, ownerhisp, and inode numbers.

That would be approximately like the slow method:
          'find | egrep -v '/\.git(/|$)' | sort | Xcpio -o | sha1sum -'
(imagining Xcpio that does not archive any ownership, timestamps,
and inode numbers). Can I obtain this result immediately from git ?

Yakov
