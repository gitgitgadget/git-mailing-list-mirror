From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Comparing commits on two different branches
Date: Mon, 5 Mar 2012 16:18:51 +0000
Message-ID: <CAHVO_92V3rRBngrZMLeq17ekKKB41kTmok39uUeZ6aOzxB65dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 17:19:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4acr-0003xr-Bc
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 17:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab2CEQSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 11:18:54 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47043 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139Ab2CEQSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 11:18:52 -0500
Received: by qcqw6 with SMTP id w6so1745797qcq.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 08:18:51 -0800 (PST)
Received-SPF: pass (google.com: domain of howardsmiller@gmail.com designates 10.224.195.201 as permitted sender) client-ip=10.224.195.201;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of howardsmiller@gmail.com designates 10.224.195.201 as permitted sender) smtp.mail=howardsmiller@gmail.com; dkim=pass header.i=howardsmiller@gmail.com
Received: from mr.google.com ([10.224.195.201])
        by 10.224.195.201 with SMTP id ed9mr6064478qab.65.1330964331689 (num_hops = 1);
        Mon, 05 Mar 2012 08:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=teYmfyAJgnE5ztPfVihfbhVdFJ3BUXplJjp7TRX7yhU=;
        b=CzgxBInPMfue5a/LSnV9ih3b/2wswPnNkCMjxvlVaMAJBMCZdLjYqF1O/nau/fRjhH
         akkwYTge/r7eKdP2MtVUEDSNY/i8QNIR81ccY9KBF3rYrMJn/GWWcJtfNtZGuWtMGsTi
         kmpUEF4La0k4krR1R7AKu9jL0SUUW+aeFUFObkOxLt3pk/q2H4LQUhe/gg2dDCP9UypF
         CaWt//hWhVpmwLCkBXIfMIIvM81kLN4rEzQqCY6wrDMBB9UbCWTot9R9O/PB0SOMSCt8
         AqG7dP2LKm4+xGOQzTOFIiLfSWg6lMMQgZyyymWohUtL0eX7k2lfK4BaSz8wGYra+EaH
         KzLA==
Received: by 10.224.195.201 with SMTP id ed9mr5240687qab.65.1330964331636;
 Mon, 05 Mar 2012 08:18:51 -0800 (PST)
Received: by 10.229.154.17 with HTTP; Mon, 5 Mar 2012 08:18:51 -0800 (PST)
X-Google-Sender-Auth: 3MU6VGJTNUnpG8h6pOUOt9piv8Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192251>

Hi,

I have two branches - I know that one differs from the other entirely
by a (large) number of commits that I have made over some time.
Unfortunately, these are now all mixed up with a load of other commits
that have been merged into both from the upstream project.

Is there any way that I can get the list of commits that represent the
difference between the two branches? Even better is there some way
that I can apply all those commits to a third branch (a newer version
of the project) without having to do hundreds of cherry-picks?

Thanks!
