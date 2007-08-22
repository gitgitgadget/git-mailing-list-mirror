From: Junio C Hamano <gitster@pobox.com>
Subject: Re: a475e8095aeb898c1ca60673b82df97d2300cc95 broken for docs
Date: Wed, 22 Aug 2007 12:45:28 -0700
Message-ID: <7vveb7ic9z.fsf@gitster.siamese.dyndns.org>
References: <86odh0ojx4.fsf@blue.stonehenge.com>
	<7vir78j8ak.fsf@gitster.siamese.dyndns.org>
	<86odgzmx2z.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Wed Aug 22 21:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INw93-0007Qf-Kz
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 21:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758312AbXHVTpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 15:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757890AbXHVTpe
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 15:45:34 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890AbXHVTpd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 15:45:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 14A6E1265A8;
	Wed, 22 Aug 2007 15:45:51 -0400 (EDT)
In-Reply-To: <86odgzmx2z.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Wed, 22 Aug 2007 08:02:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56413>

Thanks.  One difference we overlooked was the differences in
versions of AsciiDoc; Quy sees problem with 8 while I do not
with 7 (both my private machine and k.org machine -- the latter
of which is where preformatted documentation pages in html and
man branches come from).  I think Shawn was correct to pinpoint
that exact change as the culprit and Quy Tonthat is on the right
track, with this patch...



diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index cbbc234..a0c611e 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -298,8 +298,8 @@ used in the output.  When the starting commit is specified as
 'commit@{now}', output also uses 'commit@\{timestamp}' notation
 instead.  Under '\--pretty=oneline', the commit message is
 prefixed with this information on the same line.
-+
-Cannot be combined with --reverse.
+
+Cannot be combined with '\--reverse'.
 
 --merge::
 
@@ -375,7 +375,7 @@ By default, the commits are shown in reverse chronological order.
 --reverse::
 
 	Output the commits in reverse order.
-	Cannot be combined with --walk-reflogs.
+	Cannot be combined with '\--walk-reflogs'.
 
 Object Traversal
 ~~~~~~~~~~~~~~~~
