From: Andrew Morton <akpm@linux-foundation.org>
Subject: email address handling
Date: Thu, 31 Jul 2008 19:40:42 -0700
Message-ID: <20080731194042.a1534b4d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 04:41:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOkaQ-000771-8A
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 04:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbYHACkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 22:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYHACkp
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 22:40:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34947 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752793AbYHACko (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 22:40:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m712ehlI020294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 31 Jul 2008 19:40:44 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m712egFG024983
	for <git@vger.kernel.org>; Thu, 31 Jul 2008 19:40:42 -0700
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.823 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91020>


A minor thing.

Commit 76ecb4f2d7ea5c3aac8970b9529775316507c6d2 is displayed thusly:

  commit 76ecb4f2d7ea5c3aac8970b9529775316507c6d2
  Author: Zhang, Rui <rui.zhang@intel.com>
  Date:   Thu Apr 10 16:20:23 2008 +0800

      ACPI: update thermal temperature

but that isn't a valid email address.  Because it contains a comma it
must be quoted:  "Zhang, Rui".

I assume that something in the git toolchain removed his quotes, and
that was arguably incorrect.
