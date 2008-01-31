From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch docs: remove brackets so not to imply revision arg is optional
Date: Thu, 31 Jan 2008 13:53:14 -0800
Message-ID: <7vmyqlbr1x.fsf@gitster.siamese.dyndns.org>
References: <47A109A7.1070502@nrlssc.navy.mil>
	<47A11935.6000707@nrlssc.navy.mil>
	<7v7ihqhjq9.fsf@gitster.siamese.dyndns.org>
	<47A1F784.3080202@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 31 22:54:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKhMG-0004O3-8t
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 22:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758734AbYAaVxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 16:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759078AbYAaVxh
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 16:53:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758292AbYAaVxg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 16:53:36 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 577932C18;
	Thu, 31 Jan 2008 16:53:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C3CF82C14;
	Thu, 31 Jan 2008 16:53:31 -0500 (EST)
In-Reply-To: <47A1F784.3080202@nrlssc.navy.mil> (Brandon Casey's message of
	"Thu, 31 Jan 2008 10:29:56 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72138>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> The latter patch _does_ make the revision arg optional, so this
> "filter-branch docs" patch is unnecessary.

You are of course right.  I changed my mind and forgot to revert
that one.

Here is what I'll do.

[PATCH] Revert "filter-branch docs: remove brackets so not to imply revision arg is optional"

This reverts commit c41b439244c51b30c60953192816afc91e552578, as
we decided to default to HEAD when revision parameters are missing
and they are no longer mandatory.

 Documentation/git-filter-branch.txt |    2 +-
 git-filter-branch.sh                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
-- 
1.5.4.rc5.16.gc0279
