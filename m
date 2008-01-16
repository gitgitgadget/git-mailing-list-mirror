From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Remove repo-config
Date: Tue, 15 Jan 2008 20:23:39 -0800
Message-ID: <7vtzles8j8.fsf@gitster.siamese.dyndns.org>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:24:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzp1-0003sz-9g
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbYAPEXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755520AbYAPEXr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:23:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYAPEXq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:23:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 98AF07B9F;
	Tue, 15 Jan 2008 23:23:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F36B7B9C;
	Tue, 15 Jan 2008 23:23:41 -0500 (EST)
In-Reply-To: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> (Dan
	McGee's message of "Tue, 15 Jan 2008 21:19:14 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70624>

I do not think it is unreasonable to add repo-config to feature
removal schedule in 1.5.4 release notes.  Perhaps something like...

diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes-1.5.4.txt
index 7d2a973..97a9bd9 100644
--- a/Documentation/RelNotes-1.5.4.txt
+++ b/Documentation/RelNotes-1.5.4.txt
@@ -46,6 +46,10 @@ Deprecation notices
    and works for all transports; "git peek-remote" will be removed in
    the future.
 
+ * "git repo-config", which was an old name for "git config" command,
+   has been supported without being advertised for a long time.  The
+   next feature release will remove it.
+
  * From v1.6.0, the repack.usedeltabaseoffset config option will default
    to true, which will give denser packfiles (i.e. more efficient storage).
    The downside is that git older than version 1.4.4 will not be able
