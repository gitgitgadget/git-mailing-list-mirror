From: Erez Zilber <erezzi.list@gmail.com>
Subject: git log and cherry-picks
Date: Mon, 28 Jun 2010 19:02:57 +0300
Message-ID: <AANLkTil6-rd5y9xcTVz4kJ4O2jL9ZdXYo1JrgYA3sM6N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 18:03:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTGna-0005VI-J1
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 18:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab0F1QDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 12:03:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61110 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab0F1QC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 12:02:59 -0400
Received: by bwz1 with SMTP id 1so270266bwz.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=2lPle8Cap6PjqEMATtJp4tDtzlUdPq615keznMx1nnQ=;
        b=tLEpIUt2g36hiJ25LRlu7lPkdMIhI5PHEwn44RrjqulGkCBIuIPdKjbquDwcjmoEPy
         tVh0xFWGcL9yODY4INKqjdrnNxIvU94Yw1kF7iWaFTkNsjbYSM/KdRaYcNkjZw1DUIgn
         u6nr1dkhZX7lXhoW64cCxuUmhY8eyU5s+lA6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WdElxV7UlUgErxbxHxb0uxs/b0Whaz0ZI/5Cqmu0yEoJ1f8zH4v/pk8/+cpFF2qDwN
         qJX7cWSAv60o2+72CIAD1R2H9sqA8uGzcadJuw3KrXCClNEHp7/Opv3a1F85JdJoTMI/
         CSa5XbktjkC/8ZJkY3nxZEpiMnYSvkDT6tsik=
Received: by 10.204.83.15 with SMTP id d15mr3754530bkl.41.1277740977938; Mon, 
	28 Jun 2010 09:02:57 -0700 (PDT)
Received: by 10.204.68.4 with HTTP; Mon, 28 Jun 2010 09:02:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149834>

Hi,

I saw that I can run git log with '--cherry-pick'. With this, if I run
"git log --cherry-pick branch_a..branch_b", it doesn't show
differences that are caused by cherry picks.

My question is: sometimes, cherry picking from branch_a to branch_b is
not immediate, and I need to adapt the patch that was committed on
branch_a to apply on branch_b. In other cases, git is able to apply
the patch on branch_b automatically (e.g. if there's only a line
offset). In such cases, will "git log --cherry-pick" ignore these
cherry-picks like it ignores cherry-picks that were applied without
any problem?

Thanks,
Erez
