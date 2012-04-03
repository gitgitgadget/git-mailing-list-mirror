From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: How to add folder NON RECURSIVELY ?
Date: Tue, 3 Apr 2012 17:31:11 +0530
Message-ID: <20120403173111.5329d7ed@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 14:01:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF2QS-0004Jh-EU
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 14:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab2DCMBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 08:01:24 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:39964
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330Ab2DCMBX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 08:01:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id E6F86DA0E8F
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 14:01:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4x6b-Hu24BCt for <git@vger.kernel.org>;
	Tue,  3 Apr 2012 14:01:22 +0200 (CEST)
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id 52655DA0E35
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 14:01:21 +0200 (CEST)
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194614>

Hello,

Please consider the following folder structure

` `  `  `
foo/

foo/dir1/file1

foo/dir2/file2
foo/dir2/file3

` ` ` ` ` ` ` 

I like to add the folder structure in a way that only foo/dir1/file1 is added to
the git. foo/dir2 and foo/dir3 should be added to the git also to show the directory
structure and not the contents of those folder.

It is easy in SVN by --non-recursive switch, but how can I do this in git with .gitignore ?

Thanks

BTW: Please CC to me
