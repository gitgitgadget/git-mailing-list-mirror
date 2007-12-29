From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-sh-setup: document git_editor() and get_author_ident_from_commit()
Date: Fri, 28 Dec 2007 16:37:07 -0800
Message-ID: <7vlk7ecp58.fsf@gitster.siamese.dyndns.org>
References: <1198880739-8480-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 01:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8Phz-0003iO-62
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 01:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbXL2AhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 19:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbXL2AhU
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 19:37:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbXL2AhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 19:37:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E3C03FD2;
	Fri, 28 Dec 2007 19:37:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DC23A3FD0;
	Fri, 28 Dec 2007 19:37:13 -0500 (EST)
In-Reply-To: <1198880739-8480-1-git-send-email-vmiklos@frugalware.org> (Miklos
	Vajna's message of "Fri, 28 Dec 2007 23:25:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69304>

Thanks.

"proper editor" felt a bit funny, and also it needs to be
documented that it refuses to proceed when the default editor is
unusable, so I'd reword it like this:

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 1ea1faa..505b4c9 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -44,6 +44,11 @@ set_reflog_action::
 	end-user action in the reflog, when the script updates a
 	ref.
 
+git_editor::
+	runs an editor of user's choice (GIT_EDITOR, core.editor, VISUAL or
+	EDITOR) on a given file, but error out if no editor is specified
+	and the terminal is dumb.
+
 is_bare_repository::
 	outputs `true` or `false` to the standard output stream
 	to indicate if the repository is a bare repository
