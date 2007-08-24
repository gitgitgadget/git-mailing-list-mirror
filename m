From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 21:33:26 +0200
Message-ID: <200708242133.27324.robin.rosenberg.lists@dewire.com>
References: <1187716461.5986.71.camel@beauty> <alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org> <1187979317.6357.155.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Fri Aug 24 21:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOetF-00064o-Ud
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 21:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbXHXTcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbXHXTcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 15:32:09 -0400
Received: from [83.140.172.130] ([83.140.172.130]:22063 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbXHXTcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 15:32:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C547880264D;
	Fri, 24 Aug 2007 21:24:22 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18085-01; Fri, 24 Aug 2007 21:24:22 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 6D3B080264B;
	Fri, 24 Aug 2007 21:24:22 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <1187979317.6357.155.camel@beauty>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56594>

fredag 24 augusti 2007 skrev Josh England:
> punt  :)   Simple unix ownership and perms are a good first cut.  ACL's
> could probably be handled in much the same way, but converting between
> unix perms and ACLs might have to be a separate attribute/filter
> entirely.

You cannot convert between traditional unix permissisons and ACL:s. Either you
manage ACL:s or not. The traditional form is fortunately just a special case of posix
ACL:s. Here is a getfacl example. Just feed it to setfacl to set permissions according
to the dump.

$ getfacl README
# file: README
# owner: me
# group: me
user::rw-
group::r--
group:apache:rwx
mask::rwx
other::r--

Windows ACL.s are different though. 

-- robin
