From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: --username wrong or ignored for git-svn
Date: Tue, 15 Jul 2008 11:37:43 -0400
Message-ID: <9b3e2dc20807150837j56e6baf8j6dc03c7a8352ccf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:38:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImbz-0007B9-Mb
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbYGOPho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYGOPho
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:37:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:15488 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYGOPhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:37:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6060696rvb.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=pLG8ohJpRBOMH2Db5GJElhnI74h6Qdsj5vMBl5mY+7Q=;
        b=VSERfmiR3+rmNj8UA8L3Pz/GiIyUBN21wqoKaxHmh3VYvSO/MU+Ar/RYu2Ln6Exhzs
         pP51vYP9UqPAfeovHK6bMOHaHrLm3AXtXGc0ZYf6LTFWNQLHlvhhsLYzYWmHa3wF7QZp
         6OBtkYPz2xdd/SDDJVO/eLI5IFYIhozaDSgNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=A4O/IOTsfTlih76msNJoNj453s8hd31Cthh94D7uuqxc0U4uflzXuA8NjE3Jg+4Boa
         FXvxGjOrb3IFzfP9YfMHyj38zKTb3zulLtqRZh/D5dv6Ezxx7WAaOcH6cqkXSjEdrF0Z
         7xxcvIna0H2vxRo3JVD1Wuv0v3ifwbIvRXBus=
Received: by 10.141.115.20 with SMTP id s20mr3964304rvm.226.1216136263167;
        Tue, 15 Jul 2008 08:37:43 -0700 (PDT)
Received: by 10.141.66.3 with HTTP; Tue, 15 Jul 2008 08:37:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88572>

Hello,

Just now I attempted to commit some changes that a coworker had made
to our subversion repository using git-svn.  Since it was his work, we
attempted to commit it using his username, though it was done in a git
repository that I'd previously used with my username.  So I did:

git-svn dcommit --username <name>

But it ignored --username and the commit is now attributed to me.
Is it because I'd previously done dcommit in my own username?
There was no warning that it wouldn't do what I expected.

Admittedly it's was a weird thing to have him make a change in my
local repository but we didn't think it would be a problem if we
carefully used --username.

thanks,
Steve
