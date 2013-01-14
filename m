From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v2 0/3] Rework git-diff algorithm selection
Date: Mon, 14 Jan 2013 20:58:08 +0100
Message-ID: <cover.1358193364.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, peff@peff.net, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 20:58:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuqBK-00037x-T9
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758540Ab3ANT6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:58:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51890 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757663Ab3ANT6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:58:31 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0EJwFJh009990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 14 Jan 2013 14:58:16 -0500
Received: from bart.brq.redhat.com (dhcp-27-249.brq.redhat.com [10.34.27.249])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0EJwDVl009934;
	Mon, 14 Jan 2013 14:58:13 -0500
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213526>

It's been a while I was trying to get this in. Recently, I realized how
important this is.

Please keep me CC'ed as I am not subscribed to the list.

diff to v1:
-Junio's suggestions worked in

Michal Privoznik (3):
  git-completion.bash: Autocomplete --minimal and --histogram for
    git-diff
  config: Introduce diff.algorithm variable
  diff: Introduce --diff-algorithm command line option

 Documentation/diff-config.txt          | 17 +++++++++++++++++
 Documentation/diff-options.txt         | 23 +++++++++++++++++++++++
 contrib/completion/git-completion.bash | 14 +++++++++++++-
 diff.c                                 | 33 +++++++++++++++++++++++++++++++++
 diff.h                                 |  2 ++
 merge-recursive.c                      |  9 +++++++++
 6 files changed, 97 insertions(+), 1 deletion(-)

-- 
1.8.0.2
