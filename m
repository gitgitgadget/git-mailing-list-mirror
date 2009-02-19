From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] Documentation: Note file formats send-email accepts
Date: Wed, 18 Feb 2009 22:51:06 -0500
Message-ID: <20090219035106.GG4505@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:53:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZzz1-0004se-7j
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbZBSDvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 22:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbZBSDvM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:51:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbZBSDvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:51:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EB069ACE5;
	Wed, 18 Feb 2009 22:51:09 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [71.173.205.56]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E70789ACE3; Wed,
 18 Feb 2009 22:51:07 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 8B04A118-FE38-11DD-A24E-0433C92D7133-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110618>


Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

These formats are noted in the git-send-email.perl script, but not
mentioned in the documentation anywhere.  I debated adding a note that
the mbox format was generally preferred, but I wasn't sure if that was
important or appropriate.  I felt that I had bloated the Description
section enough already. :)

I hope that I got the aciidoc punctuation correct.  When to use ''
versus `` wasn't entirely clear.  So I made like a chamealeon and
tried to emulate what was nearby.

This was spurred by a bug report against the Fedora git packages:

    https://bugzilla.redhat.com/486103

 Documentation/git-send-email.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ff4aeff..66bf3b2 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -19,6 +19,19 @@ The header of the email is configurable by command line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
 enabled interface to provide the necessary information.

+There are two formats accepted for patch files:
+
+1. mbox format files
++
+This is what linkgit:git-format-patch[1] generates.  Most headers and MIME
+formatting are ignored.
+
+2. The original format used by Greg Kroah-Hartman's 'send_lots_of_email.pl'
+script
++
+This format expects the first line of the file to contain the "Cc:" value
+and the "Subject:" of the message as the second line.
+

 OPTIONS
 -------
-- 
1.6.1.3

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Most people would sooner die than think; in fact, they do so.
    -- Bertrand Russell (1872-1970)
