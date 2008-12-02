From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: [man bug?] git rebase --preserve-merges
Date: Tue, 2 Dec 2008 19:45:17 +0300
Message-ID: <85647ef50812020845g7de701bbye4a43a4e992a264b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 17:46:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7YOU-0000ok-F0
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 17:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbYLBQpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 11:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbYLBQpV
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 11:45:21 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:25456 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbYLBQpU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 11:45:20 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2502471fkq.5
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=La26qy9yeJC0ddRuWkT08lsvybl54RHTko6zw5mR4e0=;
        b=qYFloKyrzmnogjLbDgGNHzF+JEk5MU9yqT/SInqk4iBrDbCGA2e/p16ETb5qqXfBRA
         TR8GousLV+trWtMYkvAD91tvx+zl/CjxAL3cKyitETA0dSldV8Ml17N5F2FIpSyjfZjE
         X568dNFTN8W8toyqKIDJuMYgPQq6ydErn8+hA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RqcYFrj3Udmlkf6ps/gdRbj0osNXAooIO5goMeGXAPhXzpy6NOPxlf843dfYkF6K9k
         T8SZ056yvf3sggcUAMK9B9jRKqLkD/KarcHm/1FO4mXzQ7Q99lN7MzCsxOvVm3o7YM+k
         jtXox4SzORZNGWOxDaf9Jk+Cp9HnPFoGKuybM=
Received: by 10.181.61.2 with SMTP id o2mr4311473bkk.101.1228236318024;
        Tue, 02 Dec 2008 08:45:18 -0800 (PST)
Received: by 10.181.143.16 with HTTP; Tue, 2 Dec 2008 08:45:17 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102158>

The man page for git rebase mentions "--preserve-merges" command line
option but this option does not seems to be available.

Also if this option is specified, the following usage statement is printed:

Usage: git rebase [--interactive | -i] [-v] [--onto <newbase>]
<upstream> [<branch>]

And this usage statement does not mention -m and -s options that seems
to be available. I assume that the problem is the obsolete
documentation.

Regards,
Constantine
