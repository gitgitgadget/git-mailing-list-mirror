From: "Theodore Ts'o" <tytso@mit.edu>
Subject: I just pulled and built 'next'...
Date: Mon, 08 Jan 2007 08:32:30 -0500
Message-ID: <E1H3uc2-0004m1-Ua@think.thunk.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 14:32:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3uc9-0004oS-Gv
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 14:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161287AbXAHNce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 08:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161290AbXAHNce
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 08:32:34 -0500
Received: from thunk.org ([69.25.196.29]:36130 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161287AbXAHNcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 08:32:33 -0500
Received: from root (helo=think.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H3ugY-0003he-3U; Mon, 08 Jan 2007 08:37:10 -0500
Received: from tytso by think.thunk.org with local (Exim 4.65)
	(envelope-from <tytso@thunk.org>)
	id 1H3uc2-0004m1-Ua; Mon, 08 Jan 2007 08:32:30 -0500
To: git@vger.kernel.org
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36257>

I just pulled and built 'next' and it reported a version number of
1.4.4.4.g71bb6 -- and not one v1.5.0-rc0.g71bb6.  I can understand why,
since it found the changes pulled in from the maint branch before it
found the v1.5.0-rc0 tag --- but it could be more than a little
misleading.  Is this something that can be fixed in any way, short of
finding all of the tags reachable from HEAD and then doing a sort?  That
seems like a gross kludge, but I can't think of any other way of fixing
it.

						- Ted
