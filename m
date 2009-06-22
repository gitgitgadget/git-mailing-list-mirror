From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Problem packing repository
Date: Sun, 21 Jun 2009 22:24:57 -0500
Message-ID: <4A3EF989.4070101@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 05:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIaEZ-0004yG-0S
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 05:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbZFVD3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 23:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbZFVD3w
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 23:29:52 -0400
Received: from fmailhost04.isp.att.net ([204.127.217.104]:55192 "EHLO
	fmailhost04.isp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZFVD3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 23:29:51 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2009 23:29:51 EDT
DKIM-Signature: v=1; q=dns/txt; d=att.net; s=dkim01;
      i=larry.finger@att.net; a=rsa-sha256; c=relaxed/relaxed;
      t=1245641395; h=Content-Transfer-Encoding:Content-Type:Subject:To:
     MIME-Version:From:Date:Message-ID; bh=3mOOB9hGMWgf6njK5Gv9g28OstQVC
     1rm6Ig3hbtj8lw=; b=mA1aPNpbZjiD+oI4fHQJV6ph6U3ruQzfHaJocEgKMkbPlFKh
     Y4lWUpve4sNdXsx0vM+BS5aUgk0tzlkRUONzAA==
Received: from [192.168.1.103] (cpe-65-28-94-183.kc.res.rr.com?[65.28.94.183])
          by worldnet.att.net (frfwmhc04) with ESMTP
          id <20090622032452H0400i5c9ve>; Mon, 22 Jun 2009 03:24:53 +0000
X-Originating-IP: [65.28.94.183]
User-Agent: Thunderbird 2.0.0.19 (X11/20081227)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122005>

For the past 2 weeks, every pull from the mainline kernel repository
has included the following message about "Auto packing" that fails to
complete.

git --version yields "git version 1.6.3.2.198.g6096d"

================================================

Auto packing your repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
usage: git-pack-objects [{ -q | --progress | --all-progress }]
        [--max-pack-size=N] [--local] [--incremental]
        [--window=N] [--window-memory=N] [--depth=N]
        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]
        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*]
[--reflog]
        [--stdout | base-name] [--include-tag]
        [--keep-unreachable | --unpack-unreachable]
        [<ref-list | <object-list]
error: failed to run repack
