From: Aghiles <aghilesk@gmail.com>
Subject: git commit --amend --author troubles.
Date: Tue, 20 Apr 2010 15:18:10 -0400
Message-ID: <j2n3abd05a91004201218k73256ecaj8921f3bd7e9cc20d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 21:18:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Iy5-0008P9-Ty
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 21:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab0DTTSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 15:18:33 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34610 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab0DTTSc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 15:18:32 -0400
Received: by wwb24 with SMTP id 24so3551837wwb.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=dAEC+1H1qABvPv4X0UpEKPvEqo+kqBcWK9pYZyBCGaM=;
        b=ELs/g8T4pVS+eyNjMseMdCOTsluaqqXngnUBdDYzb2K5/pMVKrihleREfvnjE+akpz
         aQiQPu2uBSZQwCEMH0ail0k88xPkwpflQxcQz2Na91KeY+WSzAEmwBwvvNjO3qQeCkuI
         c1gQ0vPdqfuUZbYIpXYwD28HjhmOFB2fBDLUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ptA/WWYqzTtnkvcpvBRB6OYTyVwrphYzIC5f+ust692K8dq04FIU6DTS/8agLNjXw+
         LEu+Xt9LVLtmz1XcmzxHZkSlXMfkcNMK5Buh6LrfcFifjB0THDMbu7iMo7b1xw7N4E9c
         dYg2+/1qr05UkeUk2TzBO0hllmx3QUA2Xss4c=
Received: by 10.216.157.212 with HTTP; Tue, 20 Apr 2010 12:18:10 -0700 (PDT)
Received: by 10.216.176.212 with SMTP id b62mr668440wem.179.1271791110345; 
	Tue, 20 Apr 2010 12:18:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145393>

Hello,

Just did a 'git init .' and then committed some files. git rightfully
told me to check my user name and suggested the '--amend'
and '--author' flags to change the author of my first commit.
I tried it immediately but 'git log' shows the initial user as if
nothing has changed. The amended commit message also
shows the original name (in the comment).

git version 1.7.0.3

  -- aghiles
