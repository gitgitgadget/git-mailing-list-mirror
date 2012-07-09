From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git-svn fetch shows merge-base help
Date: Mon, 9 Jul 2012 10:32:22 +0200
Message-ID: <CAA01CsqhbO1eMrs60aCxTFjA3RN_=pHd1HiwVMNKM7AtK-AYPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 10:32:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So9OQ-0007O7-3G
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 10:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab2GIIcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 04:32:24 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:42830 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab2GIIcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 04:32:23 -0400
Received: by gglu4 with SMTP id u4so9816200ggl.19
        for <git@vger.kernel.org>; Mon, 09 Jul 2012 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=FWxm7JRixlTBcwAs13NY/8Qz59sRYlXO5y7n+HKw6uc=;
        b=yce+IFVwTq+2z5uzigLE3nceebrlpFcrubbFG5xE6fCYMyJCFbcOXpe3SwK+AQZGWH
         nLxObwQdbEpb2+w9NTFUm4ppBXlSZQKxQdtA0sC6LOjfEF6IvkZwgS9JR6/RJ97H+7Om
         BShFqIsdPqD2KT/Vrq9iUECA0ZJAAdx7jIKlBRzsNZGGi/sP/aGM4jjZIcud6o+6tQci
         M+PRNaOsI7Ygdaz6VScDeVqQzQnTWf9xFzdmBU8lmAynZO2D30Ve2JFrvCyWh6ZcLmAD
         ZlIkEga04H1hRAi8craxDBLM0PH2F15N/JUw1fZyDImWl/env7po+x1pjaYD918hVsW7
         owvg==
Received: by 10.50.219.197 with SMTP id pq5mr7663524igc.21.1341822742455; Mon,
 09 Jul 2012 01:32:22 -0700 (PDT)
Received: by 10.50.140.42 with HTTP; Mon, 9 Jul 2012 01:32:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201196>

Hi,

sometimes when I do git-svn fetch I get following:

usage: git merge-base [-a|--all] <commit> <commit>...
   or: git merge-base [-a|--all] --octopus <commit>...
   or: git merge-base --independent <commit>...

    -a, --all             output all common ancestors
    --octopus             find ancestors for a single n-way merge
    --independent         list revs not reachable from others

W: Cannot find common ancestor between  and
e928383b6c16ef5a562f8c6f29d5568330c6b307. Ignoring merge info.
usage: git merge-base [-a|--all] <commit> <commit>...
   or: git merge-base [-a|--all] --octopus <commit>...
   or: git merge-base --independent <commit>...

    -a, --all             output all common ancestors
    --octopus             find ancestors for a single n-way merge
    --independent         list revs not reachable from others

W: Cannot find common ancestor between  and
6112c8ea3e8352d8c7511064faf013116e8a383e. Ignoring merge info.

[repeated several times]

r228807 = c70f12894de2e3278a8cf534f565cbf11533c170
(refs/remotes/tags/<TAG_NAME>)

$ git --version
git version 1.7.11.1.104.ge7b44f1

-- 
Piotr Krukowiecki
