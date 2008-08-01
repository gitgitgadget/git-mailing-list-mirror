From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: extracting to/cc addresses for stg mail
Date: Fri, 1 Aug 2008 16:50:45 -0600
Message-ID: <200808011650.45915.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 00:52:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP3Tk-0005PT-5T
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbYHAWvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbYHAWvE
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:51:04 -0400
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:38945 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbYHAWvD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 18:51:03 -0400
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id D72F1142C1
	for <git@vger.kernel.org>; Fri,  1 Aug 2008 22:51:02 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 9EC0F24044;
	Fri,  1 Aug 2008 22:51:02 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 54E5F134021;
	Fri,  1 Aug 2008 16:51:02 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at ldl.fc.hp.com
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ihpakFvBKz3; Fri,  1 Aug 2008 16:51:01 -0600 (MDT)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
	by ldl.fc.hp.com (Postfix) with ESMTP id 108A713401C;
	Fri,  1 Aug 2008 16:51:00 -0600 (MDT)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Content-Disposition: inline
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91119>

I'm new to stg, so maybe I'm missing the easy way to do this.
That said, I'd like to maintain "To:" fields in the patch
description, like this:

  Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
  To: Andi Kleen <andi@firstfloor.org>
  Cc: Andrew Morton <akpm@linux-foundation.org>

"stg mail --auto" takes care of adding Andrew to the Cc list,
but I have to manually deal with Andi.

I've been doing that by using "stg mail --auto -E" and manually
moving the To: line to the top, but that's a hassle.  I don't
really want to use "stg mail --to=", because then I have to dig
out the To: line contents first.  I don't really want to use
different template files, because I often have one-off self-
contained patches that go different places.

Is there a way to make stg pay attention to my "To:" lines in
the patch description?  Or another way to accomplish this?

Bjorn
