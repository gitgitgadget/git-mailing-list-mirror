From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bring description of git diff --cc up to date
Date: Wed, 23 Jul 2008 16:15:21 -0700
Message-ID: <7v3am09oqe.fsf@gitster.siamese.dyndns.org>
References: <20080722111947.BIW29914@m4500-01.uchicago.edu>
 <7v63qxn8w2.fsf@gitster.siamese.dyndns.org>
 <7vd4l5lio1.fsf@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0807221812470.25746@harper.uchicago.edu>
 <7vfxq1igh0.fsf@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0807222210540.3408@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLnZQ-0001kN-5z
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbYGWXPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbYGWXPc
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:15:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbYGWXPb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:15:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 399D23881B;
	Wed, 23 Jul 2008 19:15:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 745573881A; Wed, 23 Jul 2008 19:15:23 -0400 (EDT)
In-Reply-To: <Pine.GSO.4.62.0807222210540.3408@harper.uchicago.edu> (Jonathan
 Nieder's message of "Tue, 22 Jul 2008 22:55:06 -0500 (CDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3E14A608-590D-11DD-B7E1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89803>

Jonathan Nieder <jrnieder@uchicago.edu> writes:

> On Tue, 22 Jul 2008, Junio C Hamano wrote:
>
> Here's another attempt.  I grimace at the sound of it, but it might be
> more clear.

Let's just do this.  I think it is clear enough.

 Documentation/git-diff-tree.txt    |   10 +++++-----
 Documentation/rev-list-options.txt |    6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 0e45b58..8c8f35b 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -93,11 +93,11 @@ include::pretty-options.txt[]
 	This flag changes the way a merge commit patch is displayed,
 	in a similar way to the '-c' option. It implies the '-c'
 	and '-p' options and further compresses the patch output
-	by omitting hunks that show differences from only one
-	parent, or show the same change from all but one parent
-	for an Octopus merge.  When this optimization makes all
-	hunks disappear, the commit itself and the commit log
-	message is not shown, just like in any other "empty diff" case.
+	by omitting uninteresting hunks whose the contents in the parents
+	have only two variants and the merge result picks one of them
+	without modification.  When all hunks are uninteresting, the commit
+	itself and the commit log message is not shown, just like in any other
+	"empty diff" case.
 
 --always::
 	Show the commit itself and the commit log message even
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b6f5d87..3aa3809 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -112,9 +112,9 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 --cc::
 
 	This flag implies the '-c' options and further compresses the
-	patch output by omitting hunks that show differences from only
-	one parent, or show the same change from all but one parent for
-	an Octopus merge.
+	patch output by omitting uninteresting hunks whose contents in
+	the parents have only two variants and the merge result picks
+	one of them without modification.
 
 -r::
 
