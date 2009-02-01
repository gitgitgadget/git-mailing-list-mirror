From: jidanni@jidanni.org
Subject: Linus and whitespace
Date: Mon, 02 Feb 2009 06:36:28 +0800
Message-ID: <87fxix3hub.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Sun Feb 01 23:38:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTkwv-00074m-Q6
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZBAWgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbZBAWgc
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:36:32 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:39282 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751911AbZBAWgc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Feb 2009 17:36:32 -0500
Received: from jidanni.org (122-127-32-160.dynamic.hinet.net [122.127.32.160])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 5D477C5892;
	Sun,  1 Feb 2009 14:36:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108016>

Gentlemen, I couldn't help but notice a certain Linus B. Torvalds is
producing mail with trailing whitespace.

I recall one should (linux-doc-*/Documentation/CodingStyle*:)
"Get a decent editor and don't leave whitespace at the end of lines."

Indeed, with my GNU Emacs show-trailing-whitespace X-ray
eyespecs on all day, whitespace becomes screaming purple space, so you
can't blame me for noticing.

Anyway, I have analyzed his messages,
(User-Agent: Alpine 2.00 (LFD 1167 2008-08-23))
and discovered that the whitespace phenomenon almost always occurs if
the lines are more than 60 characters long, the "danger zone", we might say.

$ perl -nwle 'print length if / $/' recent_linus_postings|
sort|uniq -c|sort -k 2nr
      1 77
      1 76
     17 75
     17 74
     11 73
     18 72
     12 71
      6 70
      8 69
      6 68
      2 67
      1 66
      2 64
      1 63
      1 40
      9 2
