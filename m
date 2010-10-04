From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: Move tags to branch
Date: Mon, 4 Oct 2010 21:16:21 +0200
Message-ID: <AANLkTinzGy62ETZdry5y1qTi0djkt9d72_3soCP6K_Qn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 21:16:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qWm-000553-BA
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655Ab0JDTQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:16:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39458 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543Ab0JDTQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:16:42 -0400
Received: by iwn5 with SMTP id 5so7268228iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Hj98v6nP844YTkF1mvIkC3vwzdjDNbPuT4RQ9dDRqgg=;
        b=nnAz0/XZstq5LBsm3cgEG2fsYhwNP1oavtwuhcxKTG4d1T/hBx1DAFF1t1zPLQjH9T
         yQnBcThVQlO4b4hy8jNDnwlhLoD2LSBfH/W2s/EdqIC4NJBrfANuf54vqdSCoi7lZKxb
         MWMg0dt3ZiGdyKYa6nMOXdgOxKyPoIuqDJ8qE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=wKj8Sd1Qd28kdqC5UGoVGPdWgTMBT7mCFCNmpczHeZQ5/pLUgx4BJ1o8UaXokWFnex
         0C16b/zsb3V9LaZL1oFQm2890NjYoAHWLhODi6J5KK0fl+DNUCJhkl1OvFutvaZ+M4fI
         JIIKA98qPzf8ar3oRXZ23qw90k2t2AZBu8V+k=
Received: by 10.231.183.10 with SMTP id ce10mr10704418ibb.96.1286219801886;
 Mon, 04 Oct 2010 12:16:41 -0700 (PDT)
Received: by 10.231.141.131 with HTTP; Mon, 4 Oct 2010 12:16:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158099>

Hi,

  I have been using svn2git to start using git. However svn2git
creates tags from HEAD instead of the branch. Is there a way to move
tags back to the branch ?

I have now:

$ git for-each-ref --format='%(refname)' refs/tags/ | xargs git log
--graph --simplify-by-decoration origin/release origin/master
| * commit 5fd43e4a662b1a7d43d2e10de3dec40c58dcb6a4
|/  Author:
|   Date:   Wed Aug 18 10:23:12 2010 +0000
|
|       ENH: Tagging the  release
|
| * commit 8d16cdc21ea84158eba57d0bc8d9ae96427fd24a
|/  Author:
|   Date:   Mon Jul 12 09:42:49 2010 +0000
|
|       obfuscate niels emails
|

I would like:

| * commit 5fd43e4a662b1a7d43d2e10de3dec40c58dcb6a4
| | Author:
| | Date:   Wed Aug 18 10:23:12 2010 +0000
| |
| |     ENH: Tagging the  release
| |
| * commit 8d16cdc21ea84158eba57d0bc8d9ae96427fd24a
| | Author:
| | Date:   Mon Jul 12 09:42:49 2010 +0000
| |
| |     obfuscate niels emails
| |

Thanks !
-- 
Mathieu
