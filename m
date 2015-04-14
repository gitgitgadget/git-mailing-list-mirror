From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: git fsck: unreachable vs. dangling
Date: Tue, 14 Apr 2015 09:16:59 +0200
Message-ID: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 09:17:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhv5r-00072b-CW
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 09:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbbDNHRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 03:17:01 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38353 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbDNHRA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 03:17:00 -0400
Received: by igbqf9 with SMTP id qf9so7817134igb.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=rtUWvh1k0jT+R2HH/zhn8M7DTVekIC3CyKDXnSm54Ug=;
        b=ozH5PZ6W7dnu4ZXgdKerNABlctOh/F/9J9C+uniOz1FKcfOJ3zRpsxiyACf3GfKlco
         c3IBvUybeAwp05TXrgdtUatt8SKplK1vrrojDS0qDTZGoKUTwfYtF/SrQFxR7o1sayZf
         t8ACixOjYVxYKevuE3dVa7vBS7q1oc6FrSyAZpX6F2E2RMCQmS421ki5Z+MjzwLNEbIY
         QHlEKdPSIGZzCzy4DnGxJ3hpk2VU2x5A1WkFbl18N2iSd3VOELtiRUV6aKarTssfbmYI
         rfWC2gOh55+p1Y2EcLrepeF6gxjP5xokamI8Z4P3IFqoqyr4YJAXbZ4nhV6vQIravkzn
         v/vg==
X-Received: by 10.50.79.202 with SMTP id l10mr22235628igx.7.1428995819374;
 Tue, 14 Apr 2015 00:16:59 -0700 (PDT)
Received: by 10.107.159.82 with HTTP; Tue, 14 Apr 2015 00:16:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267119>

Hi,

reading through the fsck docs [1] I'm having a hard time understanding
what the difference between "unreachable" and "dangling" objects are.

By example, suppose I have a commit A that is the tip of exactly one
branch (and no tag or other ref points to A). If I delete that branch,
is A now dangling, or unreachable, or both?

[1] http://git-scm.com/docs/git-fsck.html

-- 
Sebastian Schuberth
