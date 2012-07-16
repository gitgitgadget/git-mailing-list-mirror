From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] refname format cleanup
Date: Mon, 16 Jul 2012 14:12:59 +0200
Message-ID: <1342440781-18816-1-git-send-email-mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 14:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqkDL-0006TF-JC
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab2GPMPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:15:43 -0400
Received: from schu.io ([178.77.73.177]:57112 "EHLO
	lvps178-77-73-177.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab2GPMPm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 08:15:42 -0400
Received: from myhost.elego.de (i59F7870A.versanet.de [89.247.135.10])
	by lvps178-77-73-177.dedicated.hosteurope.de (Postfix) with ESMTPSA id 6851914954001
	for <git@vger.kernel.org>; Mon, 16 Jul 2012 14:15:41 +0200 (CEST)
X-Mailer: git-send-email 1.7.11.2.196.ga22866b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201513>

Previous discussion:

 http://thread.gmane.org/gmane.comp.version-control.git/200129/focus=200146

I'm not sure if I've drawn the right conclusions from the previous
thread, so please let me know in case that's the wrong way to go..

 * refs: disallow ref components starting with hyphen
 * symbolic-ref: check format of given refname

 builtin/symbolic-ref.c  |  4 +++-
 builtin/tag.c           |  3 ---
 refs.c                  |  2 ++
 sha1_name.c             |  2 --
 t/t1401-symbolic-ref.sh | 10 ++++++++++
 5 files changed, 15 insertions(+), 6 deletions(-)
