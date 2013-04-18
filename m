From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Bug with rev-list --reverse?
Date: Thu, 18 Apr 2013 05:17:14 -0500
Message-ID: <CAMP44s25mUA1M+K+YKaC=bz3Dr7kSDyXK5g2ot8i+1EPy8zRhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 12:17:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USlu8-0001yg-IQ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276Ab3DRKRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:17:18 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:54491 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967187Ab3DRKRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:17:16 -0400
Received: by mail-la0-f41.google.com with SMTP id er20so2398009lab.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=CKf6UA0DYzTGl4rdBq/T2X5SpgmAWo3mlprXVargGhg=;
        b=RyLXqjzV4X9rJh6w9SpATYIicxQFTqQw6uirLdcK6u49vHEI5b7Ls9dx892Dn3EA3b
         j0OGZakWHYT9UsDya2y9Ctw5YMkPs1BIg0oyZLco5g9rKsgOLOo0QpAWgQSIUPYboyyO
         bypfB69JizXxvihxfPqFb4dDT/CZQkYd2lkigJGQz61lZVHIgO1wv0B6BrtVIVXqG/z4
         RLE8QiRwzG6oAVd6itVPIRwTkeaFEShKU5Lqs2OL782MHC8Q/2cGhFOEO4ONV/mgXOOA
         VX1P5WTYZUkvQIHiGAfmPMn02zpsqP2nLHdN0DurpEYmCvsGu+J+Gj8IRaB4ovdm9FAJ
         RAyQ==
X-Received: by 10.152.3.137 with SMTP id c9mr5514926lac.5.1366280234890; Thu,
 18 Apr 2013 03:17:14 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 03:17:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221642>

Hi,

If I do these:

% git log --oneline -1 v1.8.1.5^..v1.8.1.6
% git log --oneline --reverse -1 v1.8.1.5^..v1.8.1.6

I expect to get a different output, and not both showing v1.8.1.6.
Wouldn't you agree?

Cheers.

-- 
Felipe Contreras
