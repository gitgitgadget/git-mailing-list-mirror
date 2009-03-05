From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: git push bash completion
Date: Thu, 5 Mar 2009 23:30:29 +0100
Message-ID: <fabb9a1e0903051430k5628fe26v4749360e026ac7d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfM6k-0006Ef-2I
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 23:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbZCEWad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 17:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbZCEWad
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 17:30:33 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:61406 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbZCEWac (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 17:30:32 -0500
Received: by fxm24 with SMTP id 24so148548fxm.37
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 14:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=BXIDWgaHa8/mRdl0h44kI0oMx9DUvGtWq9l4V6y5LDg=;
        b=CUYPhsoR9b+V6NSAYPcaBWQbSfHxDtYIgiY/vgTsM9dECAK/5RRdLnLjvRAN+r7pp+
         wBJooXvGTU4bEm4vehobI9Cu7bRg30izH3aPc/Wj1q4oUNvONHBwIG1T+S0twZA0WTtA
         AA1VfkOy/Z48SlLuJr13jHQYbEHmp/u5EzHz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=dmgq1bk/HLfqMlwhg+lnl3DUHEM4smNWlBdvzz84IrDxtTi67JIdY/CRkoQXGnyD9a
         7cQ19TtY5Ac8F8FYkGd0OOyg7N11BOGJIIHAkcWByCzsOEmgOEamOSo1I4qkas5NOeLc
         t3Ceqxc4bFy+nTPA+X59F8iV/5yYY08QkPQ8A=
Received: by 10.103.214.8 with SMTP id r8mr770440muq.92.1236292229860; Thu, 05 
	Mar 2009 14:30:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112355>

Heya,

Observe:
$ git push ori<tab>
  git push origin

$ git push -f ori<tab>
  git push -f origin/

Something weird going on there, or is this intentional and am I
missing something?

-- 
Cheers,

Sverre Rabbelier
