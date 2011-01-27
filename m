From: Eugene Sajine <euguess@gmail.com>
Subject: help understanding git diff output
Date: Thu, 27 Jan 2011 17:11:57 -0500
Message-ID: <AANLkTi=H1LuGfQC8+u83So+6XyOqJxHJ3zsdgs4JTdkc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 27 23:12:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pia4R-0007AS-UN
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 23:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab1A0WL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 17:11:59 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57469 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1A0WL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 17:11:58 -0500
Received: by gwj20 with SMTP id 20so831486gwj.19
        for <git@vger.kernel.org>; Thu, 27 Jan 2011 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=opfCbGxd+w/Ry5CNN8qvTCgUwEyg5WR+SE3cdAbFBnY=;
        b=pq0lL9HXGnejIctRJlx8Im5rhRKxzvnaR254gSpGWyUAjuQ7CT8wvPkxLxgx5UmQ2K
         kLVYP5K3f8K1JSzm8ZBk4sLh2QvrZp/gwIPO1WLSp8CX5EbmbCb7vYrmAaR2nqfr6Vez
         ld66uZxTqnwWeHmnb9gkxeP5Tju0lLcz0obUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rruuREwVdMcYDLwbMpcWkGU7V+G2RG2CcWZhVmKAR59UQucf7D0DwBZNk+30ghRU9S
         I1w8iWO8xiT8dz2wD6yOiCMN1c5gq6btZjbd3rwukoQ8Z525fg+nm88fRnAW2AjwdKhe
         8W9P/JfNVS7Hc9gDQO0rzycT2KHGYY5b/igjI=
Received: by 10.236.108.131 with SMTP id q3mr3265891yhg.85.1296166317234; Thu,
 27 Jan 2011 14:11:57 -0800 (PST)
Received: by 10.146.168.5 with HTTP; Thu, 27 Jan 2011 14:11:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165592>

Hi,

Could you please  help understanding the output of git diff.

I have two branches with this type or relationship:

0-a-b-c-d-e-f-g (branch1)
\a1-a2-a3-b-c-d1-d2-e-f1-f2-g (branch2)

Where commits a1,a2 and a3 as well as other numbered commits in
branch2 are the split version of their counterparts in branch1.
The the branch2 was created by creating the branch2 from branch one
and rebased on 0 with few commits being cplit up during the rebase.

I.e. the resulting state is the same for both branches.

I get empty diff when i execute:

$git diff branch1..branch2

and i also get empty diff when running

$git diff branch2..branch1

What i cannot wrap my mind around is why the command below with
symmetric difference range gives me non-empty diff

$git diff branch1...branch2

Please, advise

Thanks a lot,
Eugene
