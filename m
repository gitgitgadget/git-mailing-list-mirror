From: Rustom Mody <rustompmody@gmail.com>
Subject: vc in emacs problem with git
Date: Thu, 27 Aug 2009 20:58:43 +0530
Message-ID: <f46c52560908270828o574c0de6s17189a7326a1376d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: help-gnu-emacs@gnu.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 17:28:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgguC-0005kq-HE
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 17:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbZH0P2m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 11:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbZH0P2l
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 11:28:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:16294 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZH0P2l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 11:28:41 -0400
Received: by wa-out-1112.google.com with SMTP id j5so268243wah.21
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=xvzx90NG4G+PokkOBkKySBMwmMdhh5RCfDNk2tqO1fA=;
        b=Solp9gGu/KpdQeWJGfS8gIqjQvGE9NqlzaM9X1ee42PLLaWnykV91hcPcmQfnsXXII
         tnoEnk7fX8QJGbbW2jNSbnRPcAise9MdneSnuHYLrT5Z8UC6R7Xiz/HS5PnJhSJmo85W
         F+3HNILXHoKlqK3rfUUHJXCP9hrZN/uQbWEu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ne0TdiU2M3R+G1/5INUHzbpGHLwGpCIxZTtRguG0wu8mGQdwGZf1cBFHPKUH9U/QJY
         nebFdAea9VvWjD8TqTcWCzjVYcAAlENrIVyhVcdVXV2WXbOiZG5sZxK0ZhaWGlNEZojh
         Y1vwWpbTOi8EHTEFtXzIvxvjjaEiWZL76PoaU=
Received: by 10.114.243.8 with SMTP id q8mr851471wah.211.1251386923416; Thu, 
	27 Aug 2009 08:28:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127162>

This is emacs 23 using the new 'updated-for-modern-dvcs' vc
I see a mode line saying (note the colon)
Git:master

In the info on vc (Version control and the mode line) the emacs manual =
says:

=A0 The character between the back-end name and the revision ID
indicates the version control status of the file.=A0 `-' means that the
work file is not locked (if locking is in use), or not modified (if
locking is not in use).=A0 `:' indicates that the file is locked, or th=
at
it is modified.

However at the shell a git status says
# On branch master
nothing to commit (working directory clean)

If I close and reopen the file the colon becomes a -
But I get a message:

`working-revision' not found: using the old `workfile-version' instead.
