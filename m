From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Tiny fix in git-config manual
Date: Fri, 14 Sep 2007 14:48:01 -0700
Message-ID: <7vbqc4apgu.fsf@gitster.siamese.dyndns.org>
References: <200709102307.02468.bramschoenmakers@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bram Schoenmakers <bramschoenmakers@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Sep 14 23:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJ1I-0007eR-F7
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 23:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbXINVsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 17:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756554AbXINVsH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 17:48:07 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbXINVsG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 17:48:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F0B313504E;
	Fri, 14 Sep 2007 17:48:25 -0400 (EDT)
In-Reply-To: <200709102307.02468.bramschoenmakers@xs4all.nl> (Bram
	Schoenmakers's message of "Mon, 10 Sep 2007 23:07:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58187>

Bram Schoenmakers <bramschoenmakers@xs4all.nl> writes:

> A little problem is shown in the git-config manual, where the possible
> locations for the configuration files is to be found. The dot is a special
> character and hence not visible in the resulting documents. This patch
> fixes this by adding an additional whitespace.

Thanks, but depending on the docbook stylesheet version this
does not seem to do anything or does not seem to fix the issue.

As we usually refer the repository metadata directory $GIT_DIR,
I am inclined to do this instead.

---

 Documentation/git-config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 5b794f4..a592b61 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -142,7 +142,7 @@ FILES
 If not set explicitly with '--file', there are three files where
 git-config will search for configuration options:
 
-.git/config::
+$GIT_DIR/config::
 	Repository specific configuration file. (The filename is
 	of course relative to the repository root, not the working
 	directory.)
