From: Thomas Manson <dev.mansonthomas@gmail.com>
Subject: Selectively commit/publish files to GIT
Date: Fri, 8 Nov 2013 11:52:38 +0100
Message-ID: <CA+PenvEDY6mc+DyjXy4ebZKdK4R=ucM28MDXGC42XKxvJ=a-pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 08 11:53:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VejgY-0004ng-9j
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 11:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826Ab3KHKxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 05:53:01 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:63705 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab3KHKxA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 05:53:00 -0500
Received: by mail-wg0-f48.google.com with SMTP id b13so1775736wgh.27
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 02:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=BVJchrcnvUcb3HCJVzCVHR5He8bDwHhRuNerecdNlSQ=;
        b=bCg+98st2ihvHQjfWjxEKcOsZZOviiEqCAlovO8234OIKpU5vPXGHOq8futgwlhX7w
         C/4gPFqAarZs7yv9aqELZX254n4JhaWbQ4NJX+16aFpg9C4TcQ29JJVgBmY/qQBWKNX7
         BmfNvf14U+l4GBxRYeFhssoDc0oE+44TLgbM5sAoFhe/T0eUIAAiY0tya1vINy7/g/II
         /6Iqk0hBPY8WCRR8crYU3q8FwL6Vo7f2x4ghd41Wo9BCpKbrv6jflczU8qe/YKpVb1fP
         DRcOnJ5gK65NL8+WPUadkcrG6bTGhenTX3Hw5tNFkieoHesdZ5sSRien6XxkXveMNNnI
         crsQ==
X-Received: by 10.180.37.162 with SMTP id z2mr1827005wij.58.1383907978918;
 Fri, 08 Nov 2013 02:52:58 -0800 (PST)
Received: by 10.180.21.162 with HTTP; Fri, 8 Nov 2013 02:52:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237452>

Hi,

  I've converting my Bazaar repository to GIT.

 I've successfully done this conversion and I now want to publish my
source code to github.

  The problem is that in Bazaar, I've commited some big files (63MB &
173MB), but this files are no longer in my project, only in the
revisions files of Bazaar and now Git.

  I don't need this files to be pushed on Github.

  How can I search git history for big files and remove them, or mark
them to be not published ?

I've tryed this solution found on the link in the error:

git filter-branch --force --index-filter   'git rm --cached
--ignore-unmatch giant_file'   --prune-empty --tag-name-filter cat --
--all
git commit --amend -CHEAD

Then I've tryed to Commit & Push from Github mac  application and I
had several network error, and finally get the same error on giant
files (maybe my multiple commit & push did override something, but I
understood that the git rm command would remove things once for
good...

can anybody help me ?
I'm blocked in my dev because of this, I can't share my project with a friend.
I'm publishing here : https://github.com/dev-mansonthomas/crf-rdp.git
(paying for storage is an option as I'm quite fed up loosing time for
filesize...)

Regards,
Thomas.

here is the error I have using the GitHub application on Mac :
(after that I intend to use Eclipse)

File Ressources/dwr/dwr-3.0.0.110.dev-src.zip is 67.69 MB; this is
larger than GitHub's recommended maximum file size of 50 MB
GH001: Large files detected.
Trace: 8f0259b29260f0c4d7ae4d4ae70e0306
See http://git.io/iEPt8g for more information.
File .bzr/repository/packs/a7bcd6ba235114ab88c80fe8a97adcfa.pack is
178.76 MB; this exceeds GitHub's file size limit of 100 MB
