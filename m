From: jidanni@jidanni.org
Subject: How to extract files out of a "git bundle", no matter what?
Date: Sat, 20 Dec 2008 03:29:00 +0800
Message-ID: <87iqpgc6bn.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mdl123@verizon.net
X-From: git-owner@vger.kernel.org Fri Dec 19 20:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDl3P-00067W-0m
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 20:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbYLST3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 14:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYLST3F
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 14:29:05 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:37714
	"EHLO homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751217AbYLST3E (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2008 14:29:04 -0500
Received: from jidanni.org (122-127-33-249.dynamic.hinet.net [122.127.33.249])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id A199FD26EE;
	Fri, 19 Dec 2008 11:29:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103575>

Someone has handed you a "git bundle".
How do you get the files out of it?
If it were cpio, you would use -i, if it were tar, you would use -x...
You read the git-bundle man page.
You only get as far as
# git-bundle verify bundle.bdl
The bundle contains 1 ref
d01... /heads/master
The bundle requires these 0 ref
bundle.bdl is okay

The rest is mish-mosh. There should be an emergency example for non
git club members, even starting from apt-get install git-core, of the
all the real steps needed _to get the files out of the bundle_.

Assume the user _just wants to get the files out of the bundle_ and
not learn about or participate in some project.
