From: Thiago Farina <tfransosi@gmail.com>
Subject: reverting changes
Date: Thu, 4 Apr 2013 19:03:57 -0300
Message-ID: <CACnwZYe45poRihJToDY5yrLeY-wc=6HSjZBanjGvtiopbuAAFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 00:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNsGj-0001oq-JM
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 00:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764471Ab3DDWD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 18:03:59 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:57940 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763085Ab3DDWD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 18:03:58 -0400
Received: by mail-vc0-f169.google.com with SMTP id hx10so102360vcb.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=ZBvvWaCB/mdj6xEYDgqc3C9lSCb7IZO7q6v0NYLSkdM=;
        b=e1B8E2isS1i3cBW2xlo0fO7EwYLAXLdzaIpLiupZAsAAHtP/vKWCuLeHJfL+ajVxqT
         /PHOt0Z9tqPMoTBfbB2GZYN9rXn7da8S41/n9vvBZaIbJ7iMDkRXhJZwh8YG5uJEh/DD
         C7MDTQ/FwJuBauNyVq/Xw8/oPq5StfUYCiz2DrrDR968ElLuD0ve2EA+SAnk/ZetlKMY
         vG1xGJnYQkWelXQPsagzNhWIyCOoDsv6dwOLCrV8LHN5cnP1StzNi4irx8pfeFgXYIT1
         NNFGPapfJE2CR/Lj1IW13zMAWF+uydiLB1rc1VYRtGM4EcMP4BqC1Cp02oRLHFPm2NP/
         oW2Q==
X-Received: by 10.58.90.5 with SMTP id bs5mr6127620veb.60.1365113037682; Thu,
 04 Apr 2013 15:03:57 -0700 (PDT)
Received: by 10.58.132.143 with HTTP; Thu, 4 Apr 2013 15:03:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220112>

Hi,

When I want to revert a change to a file that is already committed
what is the best way?

The way I found was:

$ git checkout HEAD /path/to/my/file
$ git reset HEAD /path/to/my/file

Is this the canonical/best way or there other (easier-faster) ways?

Thanks,
