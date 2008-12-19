From: jidanni@jidanni.org
Subject: Re: How to extract files out of a "git bundle", no matter what?
Date: Sat, 20 Dec 2008 04:35:50 +0800
Message-ID: <87vdtfc389.fsf@jidanni.org>
References: <20081219202118.GA26513@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mdl123@verizon.net, spearce@spearce.org, git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Fri Dec 19 21:37:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDm60-0006eC-Tk
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 21:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbYLSUf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 15:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYLSUf4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 15:35:56 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:58879
	"EHLO homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751040AbYLSUfz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2008 15:35:55 -0500
Received: from jidanni.org (122-127-33-249.dynamic.hinet.net [122.127.33.249])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 08BCAC5124;
	Fri, 19 Dec 2008 12:35:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103581>

JK> In particular, if a bundle contains changes between some commit A
JK> and some commit B, then:

JK>   - files that were not changed between A and B will not be included at
JK>     all

JK>   - the object pack in the bundle is "thin", meaning it may contain
JK>     deltas against objects that are reachable from A, but not B. So even
JK>     _within_ a changed file, you may see only the changes from A to B.

OK, we here at the police forensics department would be very happy if
we could at least get some ASCII out of that .BDL file, even if it is
just a diff shred,
-       The password to the time bomb was BLORFZ
+       The password to the time bomb is  NORFLZ
that would be fine. All we know is after the work PACK it is all
binary, and git-unpack-objects and git-unpack-file don't work on it.
