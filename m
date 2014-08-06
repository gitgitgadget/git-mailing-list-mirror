From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Subtree with submodule inside?
Date: Wed, 6 Aug 2014 12:20:26 -0500
Message-ID: <CAHd499CaCeHYGZSQeY8MRVnnjXBTgDy=OUqBYqNd1e5GiKre_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 19:20:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF4t7-0001AB-3D
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 19:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446AbaHFRU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 13:20:28 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:52251 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbaHFRU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 13:20:27 -0400
Received: by mail-vc0-f180.google.com with SMTP id ij19so4492855vcb.11
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=QZu7FfEHO5CVR2/ODn1VTYElDDyp/gWs1EwvUQorSMQ=;
        b=lP3fe7XcL/lhqUq1qU/dz4tSVEu69mu710klTDs4K5XlbuSTn7E9J6/gOYRJhdXkAe
         XOm17Bw0O+t9UD0M/Hg8Tg37zjBddRy3a1X5Sw4PVFYHKOK+WO3w2smicIRZjjsfu5TN
         YKlSLs2P//4k3UUC3v1T1iSsPC53mke2QHDzdRKwJQSjUkkWz/LFVosTHfF5HX8cQ7Hg
         2QFeYHslpNStAeHsBByeMXKKxFUWJyJYtE0iP3TYJDhqJVVL2toV6GdHQB8ZItqup++T
         DQ+Y4Rv+hDw6sGDnVG7LAJTPimmSk0FG1nNKKv4Ed958HOv5iDYCYnv1/5+BAGuMZBnc
         rWkQ==
X-Received: by 10.220.74.195 with SMTP id v3mr12032678vcj.23.1407345626858;
 Wed, 06 Aug 2014 10:20:26 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Wed, 6 Aug 2014 10:20:26 -0700 (PDT)
X-Google-Sender-Auth: FdLyN8L6Bpp0H7QLbUwT-8JjI7E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254878>

Is this even possible? The .gitmodule file has to be at the root of
the repository, AFAIK. So if the subtree is inherently not at the
root, how does it manage its own submodules?

Basically I have a common library that also keeps a submodule of third
party dependencies (binaries). Each super project that depends on this
common library (each super project has its own repository) will add it
as a subtree. So what happens to the submodule with this setup?

Thanks.
