From: "Vitaly R. Tskhovrebov" <tskhovrebov@vitalyk.ru>
Subject: git-svn --set-tree question
Date: Sun, 4 Apr 2010 17:27:23 +0400
Message-ID: <71104242.20100404172723@vitalyk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 04 15:27:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyPrS-0000Ji-T1
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 15:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab0DDN1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 09:27:30 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:50569 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab0DDN13 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 09:27:29 -0400
Received: by ewy20 with SMTP id 20so880630ewy.1
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 06:27:27 -0700 (PDT)
Received: by 10.213.62.142 with SMTP id x14mr855664ebh.71.1270387647543;
        Sun, 04 Apr 2010 06:27:27 -0700 (PDT)
Received: from vetal-laptop (95-28-4-6.broadband.corbina.ru [95.28.4.6])
        by mx.google.com with ESMTPS id 14sm5904794ewy.10.2010.04.04.06.27.25
        (version=SSLv3 cipher=OTHER);
        Sun, 04 Apr 2010 06:27:26 -0700 (PDT)
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143925>

Hello, guys.

I have some unusual situation here.

We  need  to  move  git  repo  to  svn with commit history. After some
research I found a way with creating an empty svn, and then making
git svn --set-tree [git_revision_number_here]

Commit  history  imports  well,  but  i  loose  commiters'  names  and
comments. How to move them too?


Thanks a lot, Vitaly.
