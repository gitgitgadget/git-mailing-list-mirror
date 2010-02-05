From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 0/3]
Date: Fri,  5 Feb 2010 15:49:38 -0500
Message-ID: <cover.1265402797.git.larry@elder-gods.org>
References: <7v1vgz5ta7.fsf@alter.siamese.dyndns.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 21:50:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdV7u-0004sM-Rj
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 21:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab0BEUtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 15:49:45 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:54174 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab0BEUtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 15:49:43 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id CDAB0822180; Fri,  5 Feb 2010 15:49:42 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <7v1vgz5ta7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139083>

I've fixed his series according to Jeff' and Junio's comments.

Larry D'Anna (3):
  fix an error message in git-push so it goes to stderr
  clean up some of the output from git push --porcelain
  make git push --dry-run --porcelain exit with status 0 even if
    updates will be rejected

 builtin-push.c      |    8 ++++----
 builtin-send-pack.c |    4 ++++
 send-pack.h         |    1 +
 transport.c         |   11 +++++++----
 4 files changed, 16 insertions(+), 8 deletions(-)
