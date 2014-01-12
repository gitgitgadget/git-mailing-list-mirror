From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Synchronize git-credential-wincred from msysgit
Date: Sun, 12 Jan 2014 19:59:50 +0800
Message-ID: <CAHtLG6RzQEazvvGhzo6B+v15ROdcs42W6-aReTqMsOH8UO4V7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 12 13:00:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2Jhx-0007oM-12
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 13:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbaALL7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jan 2014 06:59:53 -0500
Received: from mail-we0-f172.google.com ([74.125.82.172]:55173 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaALL7v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 06:59:51 -0500
Received: by mail-we0-f172.google.com with SMTP id q58so1306295wes.31
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 03:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=OZInF9ZOwtTLRDqp2flvlxO8yUZknbchb5k3wB2+0Yc=;
        b=Pdd5dAUl7wteCgjgB3/iyy+BHlhJD8VBY71fCfOvmUtA2eVeR01gF+AII/nCjrB6h3
         oUE2pwGwW882x1nCZAIiczDOxVFDmIBkR7ZO91nzDSgFT2w6DJu7gCXkb/UVQWnLb4a1
         1tFBRl6OKcoTdkEzwX75mfEPgh8AS3TiI2TgryiXykuTs7geL9MPE3cJHPtPzNQVsb3a
         UlQfMHAwRa6Q0/+HQ8W+Il4FFiAYFQDv9gGOubHI6x06fd2Y3eH/1ArnwajIg1rpc1oX
         GSJObaLGmfShqWDaV0d36glYpBZAtbIt4lNuQulnnmhtQEbr8X9xeerD8QYn/Yyn+TsL
         HdlQ==
X-Received: by 10.194.71.239 with SMTP id y15mr13022wju.96.1389527990311; Sun,
 12 Jan 2014 03:59:50 -0800 (PST)
Received: by 10.216.53.137 with HTTP; Sun, 12 Jan 2014 03:59:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240347>

Hi,

Please cherry pick from msysgit/git
commit 3c8cbb4edc8f577940c52115c992d17575587f99

to synchronize git-credential-wincred

This was the change they made half year ago.
