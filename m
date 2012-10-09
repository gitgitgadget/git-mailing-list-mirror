From: Johannes Sixt <j.sixt@viscovery.net>
Subject: 'git grep needle rev' attempts to access 'rev:.../.gitattributes'
 in the worktree
Date: Tue, 09 Oct 2012 11:03:57 +0200
Message-ID: <5073E87D.9020100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 11:04:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLVjr-0006u9-0O
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 11:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab2JIJED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 05:04:03 -0400
Received: from so.liwest.at ([212.33.55.24]:23303 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab2JIJEC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 05:04:02 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TLVjK-0003JE-Ah
	for git@vger.kernel.org; Tue, 09 Oct 2012 11:03:58 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 16F6A1660F
	for <git@vger.kernel.org>; Tue,  9 Oct 2012 11:03:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207310>

Running 'git grep needle origin/master' on Windows gives numerous warnings
of the kind

warning: unable to access 'origin/master:Documentation/.gitattributes':
Invalid argument

It is worrysome that it is attempted to access a file whose name is
prefixed by a revision.

-- Hannes
