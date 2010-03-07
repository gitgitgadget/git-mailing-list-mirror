From: Thomas Anderson <zelnaga@gmail.com>
Subject: error: failed to push some refs
Date: Sat, 6 Mar 2010 20:15:47 -0600
Message-ID: <15b345f1003061815y52a4e842u9373731cecd8ec60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 03:16:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No62F-0006Xv-Td
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219Ab0CGCPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 21:15:49 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59952 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123Ab0CGCPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 21:15:48 -0500
Received: by pvb32 with SMTP id 32so1100053pvb.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 18:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=GC+cnQr1Ri6JsUPgAMDPZlyhnxml6YFv4UVI/z1ZjBI=;
        b=EwY28fjCLaWUG5dr6uMgKcTL7MIP5yznxU2REmuNZ/MHywgu5jLSFzmbrsKUd7oI6i
         TMscGrZybqieLN6JA7dCcUlAIzsqNpt2SlO2KtPjueS8IH3OiCghSH0rZLTLm1DRo1B7
         8FJk7WNHpZEGE5bs/ZDuB0v2w0t+dyPxePVmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=yBF5Rm0xabg+9qba5ETyxXTCYX5tyCYSd2BtC9kB0UsrRUgg+ZUPyrjJUomv6blHtt
         Xrt0bZ/75B6s6N0s8p43vMpJHTwkl+mF8gRdOHaiSAdMKCkpNkJ5e8EdY14PPcitaxDv
         5MPB0HoyJPgT7vc4vQDndWcDaiDhIUS1xGZAw=
Received: by 10.142.119.9 with SMTP id r9mr1977958wfc.201.1267928147650; Sat, 
	06 Mar 2010 18:15:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141632>

I cloned git://github.com/symfony/symfony.git to C:/git/test-root and
then cloned C:/git/test-root twice to C:/git/test-clone and
C:/git/test-clone2.  I modify the README file in C:/git/test-clone,
stage it, commit it and then try to push it to C:/git/test-root and
get this message:

To prevent you from losing history, non-fast-forward updates were rejected
Merge the remote changes before pushing again.  See the 'non-fast forward'
section of 'git push --help' for details.
Pushing to C:/git/test-root
To C:/git/test-root
 ! [rejected]        master -> master (non-fast forward)
error: failed to push some refs to 'C:/git/test-root'

What does that even mean?
