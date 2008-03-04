From: Andrew Morton <akpm@linux-foundation.org>
Subject: tracking renames
Date: Tue, 4 Mar 2008 13:57:34 -0800
Message-ID: <20080304135734.b2c2f473.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 22:58:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWf9q-0005qR-D7
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 22:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbYCDV6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 16:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbYCDV6I
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 16:58:08 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57153 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752696AbYCDV6G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2008 16:58:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m24LvlC3003351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 4 Mar 2008 13:57:50 -0800
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m24LvYok031146
	for <git@vger.kernel.org>; Tue, 4 Mar 2008 13:57:34 -0800
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.75 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76144>


When I do

	git-whatchanged drivers/watchdog/iTCO_wdt.c

it ends at "mv watchdog tree under drivers".  I'd have expected it to
tell me things about that file when it was in its original home at
drivers/char/watchdog/iTCO_wdt.c
