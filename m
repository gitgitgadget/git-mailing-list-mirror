From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH 0/3] Rework git-diff algorithm selection
Date: Sat, 12 Jan 2013 17:02:12 +0100
Message-ID: <cover.1358006339.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: peff@peff.net, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 17:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu3vd-0003kK-30
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 17:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab3ALQ1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 11:27:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633Ab3ALQ1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 11:27:00 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0CGQoE2000476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 12 Jan 2013 11:26:52 -0500
Received: from bart.redhat.com (vpn-225-209.phx2.redhat.com [10.3.225.209])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r0CG2MMB005316;
	Sat, 12 Jan 2013 11:02:24 -0500
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213294>

It's been a while I was trying to get this in. Recently, I realized how
important this is.

Please keep me CC'ed as I am not subscribed to the list.

Michal Privoznik (3):
  git-completion.bash: Autocomplete --minimal and --histogram for
    git-diff
  config: Introduce diff.algorithm variable
  diff: Introduce --diff-algorithm command line option

 Documentation/diff-config.txt          | 17 +++++++++++++++++
 Documentation/diff-options.txt         | 22 ++++++++++++++++++++++
 contrib/completion/git-completion.bash | 14 +++++++++++++-
 diff.c                                 | 33 +++++++++++++++++++++++++++++++++
 diff.h                                 |  2 ++
 merge-recursive.c                      |  6 ++++++
 6 files changed, 93 insertions(+), 1 deletion(-)

-- 
1.8.0.2
