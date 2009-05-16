From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [buglet] misleading error message from git checkout
Date: Sat, 16 May 2009 19:25:31 +0900
Message-ID: <20090516192531.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 16 12:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5H5r-0000g7-Np
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 12:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbZEPK0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 06:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755391AbZEPK0K
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 06:26:10 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44908 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204AbZEPK0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 06:26:08 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 595F611B7F8
	for <git@vger.kernel.org>; Sat, 16 May 2009 05:26:09 -0500 (CDT)
Received: from 2205.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id M9N4V1ULFG7X
	for <git@vger.kernel.org>; Sat, 16 May 2009 05:26:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=pNO5sqzBH4l3qamX6gQMthUEggUolF0YuvQYxgTGjEEnrQH8Kp65TfIW+T/zGoVnkjhmoYuUnL1Rp2zdasgwGBDt1tLPvWwrfDMp1WjdiVIFNuAJkYvEM1X6zH1UNhX59g0dubjMU7qRVkzMOYqq5vfSUIRQYIX/OooGwuILJdY=;
  h=From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119353>

When you aren't on any branch, have changes in your working files, and try to switch to another branch, you get an error message like this:

 % git checkout another
 Previous HEAD position was 0beee4c... git-add--interactive: remove hunk coalescing
 error: You have local changes to 'git-add--interactive.perl'; cannot switch branches.

Because the first line says "Previous ... was", I was mislead to believe that I sucsessfully switched branches, but I was mistaken.

If git-checkout were still a shell script probably I would have looked into fixing this myself, but now it is rewritten in C... Can somebody fix this please?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
