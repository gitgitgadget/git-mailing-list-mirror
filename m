From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [PATCH 0/5] misc. submodule related changes
Date: Mon, 11 Jun 2007 01:59:24 +0200
Message-ID: <op.ttqcxap09pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXHO-000087-J6
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760535AbXFJX47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760564AbXFJX46
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:56:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:18080 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760535AbXFJX46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:56:58 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1357255ugf
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 16:56:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=ejUbXeAzAyKd/GmytMclC2dqYY+HAsljHju20+786aN8ylexq73dzvKBHgfQqZtACa3BxOSmkawk7AS8mGVVeQUq8ETNda2//cyePAIWNSt0l7ylnGDkOptFU95tXDBzR+apaVg4v7Xb7o0aBArQsgMSJT4ycWqJWf/hFZiQLO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=B/Un3XWBoTxRg/b34JgK+xf8liU1TbY0OXItPi5+ZsIo4l0q3+ak8UdDJpmG7Gi9pbfOCDEiCspbJfoyeVP65Df77MnjzkhPpi4X+X2C4qoUNKhSaK7V5xKbMh2CpDhaE1KO8TxovspgX92NTvx7M7qJK0gDletAgvaq/QYCceg=
Received: by 10.66.249.16 with SMTP id w16mr4695147ugh.1181519816050;
        Sun, 10 Jun 2007 16:56:56 -0700 (PDT)
Received: from localhost ( [88.88.169.227])
        by mx.google.com with ESMTP id z34sm12456854ikz.2007.06.10.16.56.54
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2007 16:56:55 -0700 (PDT)
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49795>

Here is a reworked patch-series for git-submodule, trying to cater for
the issues with the previous series.

Shortlog:
  [1/5] t7400: barf if git-submodule removes or replaces a file
  [2/5] git-submodule: remember to checkout after clone
  [3/5] Rename sections from "module" to "submodule" in .gitmodules
  [4/5] git-submodule: give submodules proper names
  [5/5] Add gitmodules(5)

Diffstat:
Documentation/Makefile       |    2 +-
Documentation/gitmodules.txt |   63 ++++++++++++++++++++++++++++++++++++++++++
git-submodule.sh             |   52 +++++++++++++++++++++++-----------
t/t7400-submodule-basic.sh   |   22 +++++++++++---
4 files changed, 116 insertions(+), 23 deletions(-)
