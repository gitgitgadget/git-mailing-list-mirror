From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/2] Re: [PATCH] shortlog: Fix wrapping lines of wraplen
Date: Tue, 11 Dec 2012 06:59:20 +0100
Message-ID: <1355205562-23459-1-git-send-email-prohaska@zib.de>
References: <7v8v97efdv.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, "Jan H. Schoenherr" <schnhrr@cs.tu-berlin.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:00:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiItT-0000ov-06
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 07:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab2LKGAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 01:00:20 -0500
Received: from mailer.zib.de ([130.73.108.11]:61153 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab2LKGAR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 01:00:17 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id qBB5xb7e024493;
	Tue, 11 Dec 2012 06:59:42 +0100 (CET)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id qBB5xabN025369;
	Tue, 11 Dec 2012 06:59:36 +0100 (MET)
X-Mailer: git-send-email 1.7.12.1.429.gf87fa45
In-Reply-To: <7v8v97efdv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211280>

On Dec 9, 2012, at 10:36 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> > A recent commit [1] fixed a off-by-one wrapping error.  As
> > a side-effect, add_wrapped_shortlog_msg() needs to be changed to always
> > append a newline.
> 
> Could you clarify "As a side effect" a bit more?  Do you mean
> something like this?

See updated patches below.

    Steffen

Steffen Prohaska (2):
  shortlog: Fix wrapping lines of wraplen (was broken since recent
    off-by-one fix)
  strbuf_add_wrapped*(): Remove unused return value

 builtin/shortlog.c  |  5 ++---
 t/t4201-shortlog.sh | 24 ++++++++++++++++++++++++
 utf8.c              | 13 ++++++-------
 utf8.h              |  4 ++--
 4 files changed, 34 insertions(+), 12 deletions(-)

-- 
1.8.1.rc1.2.gfb98a3a
