From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 00/23] contrib/subtree: Collected updates
Date: Sun, 10 Mar 2013 23:41:08 +0000
Message-ID: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Paul Campbell <pcampbell@kemitix.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:42:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEptG-0002ic-TL
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab3CJXm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:42:26 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:62930 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:42:19 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so606636wib.9
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=U+DWUM6HI5MxvSvx3mhJTRhuNHnC4oIv0VR1bKfKIYM=;
        b=h4Q0IV5MxOwdaoTtj4n5QwTrD7a6mVtlkoH4qDMgq3NxiBkN64jWjYymwVEafrLvlF
         w6eXpjFFkzcWRiRCkDR+QL/wtv0hDhxBf5GUdEbAXG0AQEnuYruxntyIKTr47Dg9nQwW
         Wz6HO3n0ewyj6RxnhAFgzPMLcR29XBMTfUj56yCFUIdeqwDsPqM7iJHyEEQZv8Pmc/5n
         8WFI3UCwgEOSBR17qe0u/KT6kn+tghqw/FdSDguhMUyTYgJcGMxnVE0UeigTLv0MyYQG
         +Sw6JzcUWkOu4neVMiRcvBlEmrFlEUvxsxXU84fzaROiGpvWx7AZuAgPn2Ol1f384GO5
         dORw==
X-Received: by 10.194.83.105 with SMTP id p9mr15573644wjy.56.1362958938347;
        Sun, 10 Mar 2013 16:42:18 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.42.13
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:42:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
X-Gm-Message-State: ALoCoQmwQbD/QcaMZi6JsYwOPKzUhuKDLzf6sFXzn1hbPkaIOrl1YyvkmGanHcj7Sb0D17RtXxgW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217820>

A selection of updates to git-subtree were offered to the list in May of 
last year ($gmane/196667) by Herman van Rink.

At the time the commits were available as either a single commit or a 
large collection of commits and merges to the git-subtree prior to it's
inclusion in contrib/subtree.

The following patches take a selection of these commits and rebase them 
against the tip of master.

The git-subtree tests work (make test), but they don't cover any of
the new commands added nor the use of the .gittrees file for storing
the subtree metadata.

If I could ask the original contributors to add their Signed-off-by, I
would appreciate it.

However I don't have current email addresses for four of them: Peter 
Jaros, Michael Hart, Paul Cartwright and James Roper. If anyone has 
current email address for any of these, please either forward the 
relevant patch(es) to them or let me know so I can do so.

Herman van Rink (8):
  contrib/subtree: Add prune command to OPTS_SPEC
  contrib/subtree: Remove trailing slash from prefix parameter
  contrib/subtree: Teach from-submodule to add new subtree to .gittrees
  contrib/subtree: Document pull-all and push-all
  contrib/subtree: Document from-submodule and prune commands
  contrib/subtree: Add missing commands to SYNOPSIS
  contrib/subtree: Document list command
  contrib/subtree: Convert spaces to tabs and remove some trailing
    whitespace

James Roper (1):
  contrib/subtree: Teach push to use --force option

Matt Hoffman (6):
  contrib/subtree: Teach add to store repository & branch in .gittrees
  contrib/subtree: Rename commands push_all/pull_all to
    push-all/pull-all
  contrib/subtree: Teach push and pull to use .gittrees if needed
  contrib/subtree: Replace invisible carriage return with a visible \r
  contrib/subtree: Add command diff
  contrib/subtree: Add command list

Michael Hart (1):
  contrib/subtree: Teach push to abort if split fails

Nate Jones (1):
  contrib/subtree: Add command prune

Paul Campbell (2):
  contrib/subtree: Parameters repository/branch for push/pull are
    optional
  contrib/subtree: Fix order of case switches so default case is last

Paul Cartwright (1):
  contrib/subtree: Fix typo (s/incldued/included/)

Peter Jaros (1):
  contrib/subtree: Add command from-submodule

bibendi (2):
  contrib/subtree: Teach push and pull to use .gittrees for defaults
  contrib/subtree: Add commands pull_all and push_all

 contrib/subtree/git-subtree.sh  | 203 ++++++++++++++++++++++++++++++++++++----
 contrib/subtree/git-subtree.txt |  46 +++++++--
 2 files changed, 222 insertions(+), 27 deletions(-)

-- 
1.8.2.rc1
