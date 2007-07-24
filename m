From: Steven Grimm <koreth@midwinter.com>
Subject: StGIT (or guilt) + git-svn?
Date: Tue, 24 Jul 2007 18:20:41 +0800
Message-ID: <46A5D279.7060601@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: 'git' <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 12:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHVY-0002Ig-3i
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677AbXGXKUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763830AbXGXKUp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:20:45 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:39055
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1755639AbXGXKUo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:20:44 -0400
Received: (qmail 12166 invoked from network); 24 Jul 2007 10:20:44 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=LEcCbZXTLBL4ybnwjq4pPbPDdyRG6LfhqGiQpsZ/dc5POHGWN+G1w5kaPZtUfHDO  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 24 Jul 2007 10:20:43 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53556>

Anyone have experience mixing git-svn with either StGIT or guilt? A 
coworker of mine was asking if he could do local versioning of files he 
has no intention of committing to svn. He wanted a ".git-svnignore" kind 
of scheme but I think his use case sounds like the sort of thing StGIT 
and guilt are designed for. What I'm not sure about is whether git-svn 
will confuse those tools or vice versa. I don't think I've ever seen 
that combo discussed on the list.

-Steve
