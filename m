From: Scott Chacon <schacon@gmail.com>
Subject: git log --follow
Date: Wed, 3 Nov 2010 20:00:23 -0700
Message-ID: <AANLkTinEEtfxu=NbaGn=A88MrU7JCFztMzB-x3--FCdB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 04:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDq3z-0006Gx-41
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 04:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab0KDDA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 23:00:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59817 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0KDDAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 23:00:25 -0400
Received: by eye27 with SMTP id 27so740953eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 20:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=n9Mh7rg7zh8PyhMADhMC7XtLG2Y9RA3hygBrAcwAWzc=;
        b=ozQH40yL8xmAuH1Qhf/dZwQ983VHI0TBqqKN13i5DRMJCxiIBX/F2UFufHayRoEwN1
         7UcAaKIeOdFsdYF2kH3vgse4X8taB2cwqCEtbdc7aGTyWo3LP1y2xGYCm9FRnSQItmQH
         t9ZNGAXZWjU1nb6MxmiCI8aWwxWfRnBxLjWDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=YASUe6rSv//gcPP7rKo9srlDuTnwoeAyVCC8UMVxb+AISXL5RYYBbE5dohDb+B7u9i
         Nzl5jCuxtk5ptU4JtR2HQSI/LTrhqNLNKpfVvGkfhRO9HspnsTc6QnDxdHeEmkbqsxNX
         Vln2bPlJ4hrNAV0v4QQyfFRqe08Y7bhJVFNus=
Received: by 10.14.48.78 with SMTP id u54mr83815eeb.27.1288839623868; Wed, 03
 Nov 2010 20:00:23 -0700 (PDT)
Received: by 10.14.29.66 with HTTP; Wed, 3 Nov 2010 20:00:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160681>

Is there any way to get 'git log --follow' to respect the -M[num]
option?  If I want to lower the boundary for rename detection when
printing file history, is there any way to do that?  It doesn't seem
to work if I just list them both.

Thanks,
Scott
