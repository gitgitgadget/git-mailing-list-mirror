From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/13] remote-hg: general updates
Date: Tue,  2 Apr 2013 13:02:49 -0600
Message-ID: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6VN-0006iQ-8d
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762100Ab3DBTD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:03:56 -0400
Received: from mail-ye0-f173.google.com ([209.85.213.173]:57708 "EHLO
	mail-ye0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761823Ab3DBTD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:03:56 -0400
Received: by mail-ye0-f173.google.com with SMTP id q5so112159yen.18
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=9e46KrhaD9KooiZZOaao8PugCw+csQdsNuAV7kksbIo=;
        b=s95nHERrlxLTcPmFyEKATRU1iRMP88VBfwgX4PU+DBQtuYpRelJHo7XFM1sB4lxNsJ
         436qla7vrMaa/jOymD78uw51ALdkfzuS80KnVX4oVDb3YS4eewg+3aGD0H9iSzMhV1Ts
         zO4HGg/DZ15/DulunMh1rVzKxM9PqoutrlCMQaztD/WtVqv1Pt01zTdOA9rxgLXAY5dh
         xfOD5CJTzranoQc9w3959vaheLYr8+3uV6vRHc92kO2iXniDwIrsxSVcQMEQCcMGnZBE
         wYzoZihAPJhJI+geK9zOovm8kqoVonf1TbdYL+VyFWeu7IcWg8kxAa6NU18ISO1rv3WS
         nGNA==
X-Received: by 10.236.201.68 with SMTP id a44mr16213530yho.100.1364929435659;
        Tue, 02 Apr 2013 12:03:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id w69sm4910427yhe.4.2013.04.02.12.03.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:03:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219831>

Hi,

Here is the next round of patches for remote-hg, some which have been
contributed through github.

Fortunately it seems to be working for the most part, but there are some
considerable issues while pushing branches and tags.

Dusty Phillips (1):
  remote-hg: add missing config variable in doc

Felipe Contreras (11):
  remote-hg: trivial cleanups
  remote-hg: properly report errors on bookmark pushes
  remote-hg: make sure fake bookmarks are updated
  remote-hg: trivial test cleanups
  remote-hg: redirect buggy mercurial output
  remote-hg: split bookmark handling
  remote-hg: refactor export
  remote-hg: update remote bookmarks
  remote-hg: force remote push
  remote-hg: don't update bookmarks unnecessarily
  remote-hg: update tags globally

Peter van Zetten (1):
  remote-hg: fix for files with spaces

 contrib/remote-helpers/git-remote-hg     | 73 ++++++++++++++++++++++++--------
 contrib/remote-helpers/test-hg-bidi.sh   |  6 +--
 contrib/remote-helpers/test-hg-hg-git.sh |  4 +-
 3 files changed, 61 insertions(+), 22 deletions(-)

-- 
1.8.2
