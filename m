From: Francis Moreau <francis.moro@gmail.com>
Subject: git-cherry and fork-point
Date: Wed, 16 Feb 2011 16:13:37 +0100
Message-ID: <AANLkTimNqzQc9vJmW_oKOgkGdM0bbff1SB9ZZBoXx--E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 16:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppj4b-0007mG-8H
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 16:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755Ab1BPPNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 10:13:40 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47397 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab1BPPNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 10:13:38 -0500
Received: by pwj3 with SMTP id 3so260262pwj.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 07:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=8KMHhUwLd3tvlJKHHCOYX6xGb5LWNmAzKidRbXhUlqw=;
        b=ozwuKAASGDndxbzGpG4SjNVTnL90llN+hHYa/Zu/RxmAIWbFs0SgOQ0aZo4otl3B+e
         1EaDDIwvIJV08zG/m94ka0EX/ZljsS+SMAYf1BkuM7s2hY/1Y92/vj0iJW/RugcfVDFz
         7PVEGwa4G6jhjW/j8B8x0zQKvAuLE0ncz6hm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wD3GLoM5V0RFqLn10Nk+LIFsdsVk7JgyUg+Go/7zVAbGtq0z9f9eRNI/WrvMb29LFZ
         4RNRqxmh11cP38tzkmORG9q0kqH80uWudjlPzvBetmgtz/jc79qbZd7pN/iysH5SI6DA
         hF07hz1ETf+k6zJwgkIkq6TQ0YS6WNGv1tcJM=
Received: by 10.142.185.17 with SMTP id i17mr561382wff.353.1297869217816; Wed,
 16 Feb 2011 07:13:37 -0800 (PST)
Received: by 10.142.44.3 with HTTP; Wed, 16 Feb 2011 07:13:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166970>

Hello

I'd like to understand what's the 'fork-point' in the git-cherry documentation.

For example, if I have this configuration:


                                 __*__*__*__*__> <upstream>
                                /
                 *__A__*__*__*__B__*
                     \
                      \__+__+__-__+__+__-__+__> <head>


what's the 'fork-point' for respectively those two commands:

       $ git cherry upstream head B
       $ git cherry head upstream A

I would say A and B, but I'm not sure and the documentation doesn't help.

Could anybody clarify this point ?

Thanks
-- 
Francis
