From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: /usr/lib/git-core/git-rebase: 590: cannot open /home/mathieu/dummy/.git/rebase-merge/rewritten:
 No such file
Date: Tue, 22 Mar 2011 16:04:12 +0100
Message-ID: <AANLkTinx1bDaChNwrn6pQjxbyZ-rH6TZ_5JuWszY1LTE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 16:04:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q238R-0001bV-5K
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 16:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab1CVPEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 11:04:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44298 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab1CVPEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 11:04:34 -0400
Received: by gwaa18 with SMTP id a18so2893945gwa.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=/aah80wy5hFHlit5LFe9RFvrzDOYkN2AxECbbYmFrlk=;
        b=SjCg5O9N5rVqbF2bNcUHFAjEE21znSeF4YgxnKNgSo0J4qt7xht/bbrIQ/SYZmF/oS
         iYEGWND/OI9GBdPZgpyweqALM3SDL0oyIZk0QaFb6/Ib9TXFaVTOslaXU1yHnCvRx1eB
         9b3eInOSJOgD2TAC+6J/kTHv2+XWzej5fwzQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=N83whjG/d1xee6htc8G7RY7QHz0cDaPXvfQcjlHrkC1R206EbCvoBJCX91tsNhW71c
         0G/F/NP03SMhn0pPHBE6Skw/nyjbnjik2gGm17L8wAvhLaE8cr4YYY7VMN8BnvnF4iZd
         v1QMJuuDhZPi7K7veaNM7BYYbCOB31a6Vjego=
Received: by 10.91.151.9 with SMTP id d9mr5175022ago.176.1300806273400; Tue,
 22 Mar 2011 08:04:33 -0700 (PDT)
Received: by 10.90.51.11 with HTTP; Tue, 22 Mar 2011 08:04:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169743>

Dear all,

  I tried a rebase of my local branch (say 'local') against master.
Here is what I did:

$ git checkout local
$ git rebase -s ours master
...
Already applied: 0017 smore more work
/usr/lib/git-core/git-rebase: 590: cannot open
/home/mathieu/dummy/.git/rebase-merge/rewritten: No such file
All done.

I have no idea on how to get back to the initial state. Where did my
'local' branch go ? Using git 1.7.2.3

Thanks
-- 
Mathieu
