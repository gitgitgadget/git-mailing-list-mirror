From: Stefanus Du Toit <sjdutoit@gmail.com>
Subject: git-subtree manpage missing from git-manpages tarballs
Date: Sun, 8 Dec 2013 11:14:39 -0500
Message-ID: <CABGRy0o3AJLMhmVJL8XAjrnQJd=yuV+1Q=cLToetnhmB0V=hfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 17:15:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vph0W-00072O-CH
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 17:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759371Ab3LHQOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 11:14:41 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:61983 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab3LHQOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 11:14:40 -0500
Received: by mail-wi0-f171.google.com with SMTP id bz8so2657207wib.4
        for <git@vger.kernel.org>; Sun, 08 Dec 2013 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=b1k9Bwh8Dw3LJJu4ZxF68iEHX3zL1ScZsIgSZUYgNEI=;
        b=fLZJMmphjbGDsoq4Y2UwQ+ZP+6M5O0XCSyZf9AI69hjzK4+aErKNlzlBHb5uOIw7c4
         SaCiVAwBeCbC11IoSV1hEMeiUxcAQ0Ijk4GT62RgbDVPah6LnKIEgotGphd9xvi4fb2L
         H7dIGMWqkga3/ON9Sjjsq35jTRRaIusi1uF7eplQ89LCeaHBc44euTDY+V0GxEDMhasl
         DMA6bOb884GXxOto1z2J0UjVNQN5T9rSgFVxmrjIcMEvNweNa+Y9HArgKQHdAlZIVQa7
         ZRN28meoXhidblNi4fcMxbNKbMmEWCXXsqUoaEZ1nHR1uk8sMuELUtWbV3y9oXQthitL
         hrkw==
X-Received: by 10.194.174.36 with SMTP id bp4mr11920330wjc.7.1386519279564;
 Sun, 08 Dec 2013 08:14:39 -0800 (PST)
Received: by 10.195.9.5 with HTTP; Sun, 8 Dec 2013 08:14:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239046>

The git-subtree manpage is currently missing from the git-manpages
tarballs at https://code.google.com/p/git-core/.

For example, https://code.google.com/p/git-core/downloads/detail?name=git-manpages-1.8.5.1.tar.gz
does not include it.

A side effect of this is that "git help subtree" fails when using git
installed from homebrew, because the homebrew recipe uses those
tarballs as its source of documentation.

Is it possible to include the manpage starting with an upcoming
release, or is there a good reason it's excluded?

Thanks,

Stefanus
