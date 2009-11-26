From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Merge priority
Date: Thu, 26 Nov 2009 12:44:16 +0000
Message-ID: <26ae428a0911260444j45437a92r47d7f2e8b292829e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 13:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDdhx-0003Sy-1I
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 13:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbZKZMoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 07:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbZKZMoN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 07:44:13 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:36368 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbZKZMoL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 07:44:11 -0500
Received: by ewy19 with SMTP id 19so392866ewy.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 04:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=DxbRQRGJX59WAATSxJhopfJj76Rt/bBrczfZGX9FVxg=;
        b=cxPfI/EzAQIPNQnD1oiax0nEmneInAU9xVuBi53IncyT6dW/OfB/9ncQJsNE11COJm
         842XdqHCexJB+YXNdmcr6nV1/9ZdenvYXWhbBJ05YWOfRJvPbzsFyQribedlP9h6z+zz
         +RhjOzR9FZewKWQyZfofMXUHK5edWagKcvyzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=HJ0BqDzXw1/iUNsgj1ovz4YRTYk6YTtxCiFsCEiKOT3gLC4J4sWiHuE++R6YH0ELlu
         ckcHqGaJl30Be0VvqRHyvcOh8A0qiDjHrNMaatKJu7nBKhhpl5Qdl3aSrh+n7hVXPyUs
         f1jmsBHT3LhjbanpEWOk6RQvFo6qIgxP+K3Rw=
Received: by 10.213.0.198 with SMTP id 6mr8067915ebc.84.1259239457090; Thu, 26 
	Nov 2009 04:44:17 -0800 (PST)
X-Google-Sender-Auth: 64bf9d86f78c7946
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133789>

I'm not sure this is even a sensible question....

I have a whole bunch of customer branches with all manner of local
tweaks and modifications. I also have a stable branch with all my
security patches and bug fixes. They do share common ancestry.

I now want to update all my customer branches with the latest fixes
and patches. Naively, I would just check out each branch and merge the
stable branch - job done. However, is it sensible to ask if there is a
way to say that the stable branch is more important if there are
conflicts. Or should I be using rebase instead (which I still don't
really understand). I'm trying to reduce my workload as there are
loads of branches to do.

Cheers :-)
