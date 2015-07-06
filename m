From: Andrey Hsiao <andreyhsiao@gmail.com>
Subject: Git merge commit message issue
Date: Mon, 6 Jul 2015 23:45:51 +0800
Message-ID: <CAArk4YMzN_dY3SOKEjtpykunMjS5bWXYazcLxXb4TGTGP_zArw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 17:46:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8ao-0000Fe-34
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 17:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbbGFPpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 11:45:55 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34724 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbbGFPpw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 11:45:52 -0400
Received: by qkeo142 with SMTP id o142so119959476qke.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=UnIyU39s6RWIaGAennG7C+LDKqzCA1SbypOtIPrO+3g=;
        b=qLsq4pU1ig/Eqe6MODR6Din8kXMu4OZWJmI4q+UcpBHxhDg0XYnyr5LndYB9ZrPeDk
         O8e/aF92gwK6iVqPtLAUv5bybzIi8kTjn8WfKKjIo7jbHrnL5wimJHbTh33/Phe889dS
         U6CxktsAJxCMDBD5i7XXxksEAqO2zWNZS5smajtNkyxTiH1q4hOHYTDro8UlQ8Toottw
         EsJwEUN9gjfzB6HvTHRD768wpAmpCILnP2UrFcCGJ2r4hQOgzejjDfYOqzWi3yglDzJA
         nf0Ei9opPs1oVa6hP5Tu8kIwRDG9TULh6xAB7opqWfaaKBtHyJNNlOZqGgFvf/9sLYIj
         IUFQ==
X-Received: by 10.55.40.202 with SMTP id o71mr60528297qko.108.1436197551889;
 Mon, 06 Jul 2015 08:45:51 -0700 (PDT)
Received: by 10.140.82.81 with HTTP; Mon, 6 Jul 2015 08:45:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273391>

Dear list:

In the past, when we do the merge in git, if conflicts occurred, when
we commit, the conflict list will be appended to the default commit
message automatically.

eg:
Conflicts:
....a.java
....b.java

Today, after using Git 2.3.0 for a merge, it seems now the conflict
list was commented out by default.

I just searched a bit in the release notes, don't know whether below
item has to do with this change.

----
"git interpret-trailers" learned to properly handle the "Conflicts:"
block at the end.
----

We quite rely on the default generated conflict list to reminder us
about the "history".

Is this the default behavior now (conflict list commented out)?

Thanks
Best Regards
