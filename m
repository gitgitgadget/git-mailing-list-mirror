From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v3 0/3] Rework git-diff algorithm selection
Date: Wed, 16 Jan 2013 08:51:55 +0100
Message-ID: <cover.1358322212.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 08:52:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvNnh-0006Yx-C3
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 08:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758668Ab3APHwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 02:52:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758400Ab3APHwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 02:52:14 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0G7q2U6008512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 16 Jan 2013 02:52:02 -0500
Received: from bart.brq.redhat.com (dhcp-27-249.brq.redhat.com [10.34.27.249])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0G7pxJV019996;
	Wed, 16 Jan 2013 02:52:00 -0500
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213736>

It's been a while I was trying to get this in. Recently, I realized how
important this is.

Please keep me CC'ed as I am not subscribed to the list.

diff to v1:
-Junio's suggestions worked in

diff to v2:
-yet more Junio's suggestions included

Michal Privoznik (3):
  git-completion.bash: Autocomplete --minimal and --histogram for
    git-diff
  config: Introduce diff.algorithm variable
  diff: Introduce --diff-algorithm command line option

 Documentation/diff-config.txt          | 18 ++++++++++++++++++
 Documentation/diff-options.txt         | 21 +++++++++++++++++++++
 contrib/completion/git-completion.bash | 14 +++++++++++++-
 diff.c                                 | 34 ++++++++++++++++++++++++++++++++++
 diff.h                                 |  2 ++
 merge-recursive.c                      |  9 +++++++++
 6 files changed, 97 insertions(+), 1 deletion(-)

-- 
1.8.0.2
