From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/9] fprintf(stderr, "warning: ") -> warning() patches
Date: Tue, 24 Mar 2009 02:09:08 +0100
Message-ID: <cover.1237856682.git.vmiklos@frugalware.org>
References: <7v3ad5dxt5.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:10:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llv9c-0006Vh-TM
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbZCXBIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbZCXBI1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:27 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57048 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbZCXBIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:24 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 0EFF929406C;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 30B0C186221; Tue, 24 Mar 2009 02:09:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <7v3ad5dxt5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114376>

On Sun, Mar 22, 2009 at 02:58:46PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Should I rebase the series against current master and resend?
>
> Yes, please, if the overlap with "diff master next" is small enough.

Okay, here it is, applies on top of master. All, except the http-push
one, applies cleanly on top of next as well here.

Miklos Vajna (9):
  http-push: using error() and warning() as appropriate
  builtin-apply: use warning() instead of fprintf(stderr, "warning: ")
  builtin-checkout: use warning() instead of fprintf(stderr, "warning:
    ")
  builtin-fetch-pack: use warning() instead of fprintf(stderr,
    "warning: ")
  builtin-init-db: use warning() instead of fprintf(stderr, "warning:
    ")
  builtin-rm: use warning() instead of fprintf(stderr, "warning: ")
  builtin-show-branch: use warning() instead of fprintf(stderr,
    "warning: ")
  builtin-show-ref: use warning() instead of fprintf(stderr, "warning:
    ")
  refs: use warning() instead of fprintf(stderr, "warning: ")

 builtin-apply.c       |   15 +++++++--------
 builtin-checkout.c    |    4 ++--
 builtin-fetch-pack.c  |    2 +-
 builtin-init-db.c     |    7 +++----
 builtin-rm.c          |    3 +--
 builtin-show-branch.c |    3 +--
 builtin-show-ref.c    |    2 +-
 http-push.c           |    6 +++---
 refs.c                |    8 +++-----
 9 files changed, 22 insertions(+), 28 deletions(-)
