From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Subversion integration with git
Date: Sun, 28 Mar 2010 23:03:28 +1100
Message-ID: <4F70255B-6FCC-4020-B993-A15E6DC0E774@cordelta.com>
References: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com> <4BABAA30.3080806@obry.net>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Sun Mar 28 14:13:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvrN0-0002MA-KW
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 14:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab0C1MN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 08:13:29 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:34216
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754227Ab0C1MN2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 08:13:28 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Mar 2010 08:13:28 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiIGABbirkvLWHsF/2dsb2JhbACPQYtncbMsiEWFAQQ
X-IronPort-AV: E=Sophos;i="4.51,322,1267362000"; 
   d="scan'208";a="158948782"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 28 Mar 2010 23:03:30 +1100
Received: (qmail 2190 invoked from network); 28 Mar 2010 23:03:30 +1100
Received: from d122-109-106-179.mit3.act.optusnet.com.au (HELO ?192.168.1.8?) (122.109.106.179)
  by node2.alpha.aussiehq.net.au with SMTP; 28 Mar 2010 23:03:29 +1100
In-Reply-To: <4BABAA30.3080806@obry.net>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143388>

Pascal,

>> My project is still in the preview phase but has enough to import 
>> commit-tree structure bar symlinks and executable flags. It imports 
>> my 22000+ commit 2.8GB dump in 4 minutes. It is currently 840 
>> non-comment lines of C. I aim to produce output that git-svn can
>> take over from.
> 
> Impressive numbers! I've converted many projects using git-svn and yes
> it is slow. Just curious, does it handles branches? Can it handles not
> standard layout (trunk/branch/tags)? When you have a git-svn compatible
> output I would be willing to test it on a project.

My initial design target is a one-to-one translation of the subversion history to a single linear git branch. I'm working under the assumption that something like git filter-branch can be used to transform the history to a more logical representation. This should allow any subversion layout to be handled.

When I have git-svn compatible output, I'll proudly announce the first release.
