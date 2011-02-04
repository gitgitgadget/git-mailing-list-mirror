From: "Kaizer H. Sogiawala" <kaizers@gmail.com>
Subject: git-p4 - workflow suggestions
Date: Thu, 3 Feb 2011 16:23:26 -0800
Message-ID: <AANLkTik3iFXZE6KSvSSgka3rJyCQbPXpUrTWRGyonfT=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 04 01:50:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl9sU-0006Vv-DS
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 01:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab1BDAuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 19:50:15 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61028 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab1BDAuP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 19:50:15 -0500
Received: by ywo7 with SMTP id 7so466359ywo.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 16:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=iu91+AbBbqbaZ1mYBDZtu+YsC7H6OjqOuBhS9hHi5FY=;
        b=u/l8p0OomVGrqVHK/5P+EYsxI2iMKqMN6vObG5djErzSW4ryhSSnBYdDeQR47dLa24
         Lo6dYTUmLs6iYSw+dUHZfke9w6OnjtUxLSd53ZDM5nVeXMVw1qcq8NPO0PtOquDbv+pd
         SVrYKbgl8aoAQFjhj3KfiOwmMKVC+uXM3sMB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=P7ozOep9ZzF7RMWY651x/6PyPGUvNXU7Im2OFdAoEnbr1Bnp+pIYe85wwNl6kdUot3
         4iKDClbGC3TXDREZqd9VBI/ucdRvAD8Ng3sqtBGhCtcoMJU5o0DJmiI1TSW6Xe4+GG2X
         sZrlcODkfinFiVDFoWFVUjp6vO94nc5ITQle4=
Received: by 10.150.146.1 with SMTP id t1mr14028192ybd.236.1296780613960; Thu,
 03 Feb 2011 16:50:13 -0800 (PST)
Received: by 10.147.169.8 with HTTP; Thu, 3 Feb 2011 16:23:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166014>

Hi,

We are primarily a Perforce shop. I am looking for a git-p4 workflow
that will alllow a sub-team (2-20 developers) to use git as their
primary source control repository. This sub-team is tasked with
refactoring and will need heavy-duty branch/merge support. The
main/central source code repository (and branch) is in Perforce.

I am looking at approaches that will allow me to "git-p4 clone" from
Perforce (a branch in perforce, say trunk) into a bare/shared git
repository. This repository is then cloned by each developer of the
git-sub-team to perform regular development/push/pull/merge/rebase
activities.

Periodically, a gatekeeper would pull changes from Perforce to git and
push changes from git to Perforce. Can this be done?

So far, I have looked at the:
- git-p4 documentation
- Version Control with Git book By: Jon Loeliger (particularly the
git-svn section)
- Mailing list (particularly following thread answered by Tor Arvid Lund)
- googl'n around this topic

Most discussion is around how to use git-p4 as a sync mechanism for a
single user. When I attempt to git-p4 clone (import) and then create a
shared/bare repository out of it and emulating multiple user, the
git-p4 sync mechanism breaks down after couple of merges. The git-p4
sync/rebase/submit will try to reapply duplicate changes and trip
pretty early in the cycle.

If you have a working model of making available a p4 branch for a
sub-team using git-p4, I would really appreciate a writeup or blog.
Thanks in advance.

-- 
Kaizer
