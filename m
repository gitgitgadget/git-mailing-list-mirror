From: jidanni@jidanni.org
Subject: read-only mode
Date: Thu, 04 Dec 2008 06:44:24 +0800
Message-ID: <8763m0swtz.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 23:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L80Tg-0001Yk-0Z
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 23:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbYLCWo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 17:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYLCWo1
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 17:44:27 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:53900 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752478AbYLCWo1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 17:44:27 -0500
Received: from jidanni2.jidanni.org (122-127-33-131.dynamic.hinet.net [122.127.33.131])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 86F08D265C
	for <git@vger.kernel.org>; Wed,  3 Dec 2008 14:44:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102296>

Here's a documentation stub. Please fix and finish it and place in some manual.

==Using git in read-only mode==
Let's say you just want to examine things. There is a fine line
between commands and options that just examine things vs. those that
change things. One might worry that they can't remember that fine line.

Therefore the safest way to ensure you are using git in 'read-only mode' is to
* su nobody, or
* chmod -R u-w . (and remember to chmod -R u+w when you are finished), or
* ???
