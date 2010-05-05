From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation/config.txt: Move GIT_NOTES_REWRITE_REF to notes.rewriteRef
Date: Wed, 5 May 2010 16:00:03 +0200
Message-ID: <201005051600.03446.trast@student.ethz.ch>
References: <1273066516-24469-1-git-send-email-lstorset@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Leif Arne Storset <lstorset@opera.com>
X-From: git-owner@vger.kernel.org Wed May 05 16:00:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9f9M-0007np-Vt
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 16:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719Ab0EEOA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 10:00:27 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:14076 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257Ab0EEOA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 10:00:26 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 5 May
 2010 16:00:24 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.1; Wed, 5 May
 2010 16:00:03 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <1273066516-24469-1-git-send-email-lstorset@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146394>

Leif Arne Storset wrote:
> Was notes.rewrite. The environment variable refers to globs and refs, which are only mentioned by notes.rewriteRef; notes.rewrite is boolean.
> 
> Signed-off-by: Leif Arne Storset <lstorset@opera.com>
> ---
> This should be a trivial fix.

ACK and thanks for spotting this.  Putting it in the wrong place was
my fault.

I found the commit message confusing, though (my first thought was "we
have a notes.rewrite configuration variable?"), and you also have a
way too long line there.  How about

  Documentation/config.txt: GIT_NOTES_REWRITE_REF overrides notes.rewriteRef

  The documentation erroneously mentions the GIT_NOTES_REWRITE_REF
  override in the description of notes.rewrite.<command>.  Move it
  under notes.rewriteRef where it belongs.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
