From: Alex Bennee <kernel-hacker@bennee.com>
Subject: How can I easily verify my diffs are in parent branch?
Date: Wed, 04 Apr 2007 12:36:23 +0100
Message-ID: <1175686583.19898.68.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 14:01:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ4Ar-0008QW-7K
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 14:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992869AbXDDMBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 08:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbXDDMBH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 08:01:07 -0400
Received: from mx.transitive.com ([217.207.128.220]:38006 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753149AbXDDMBG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2007 08:01:06 -0400
X-Greylist: delayed 1481 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Apr 2007 08:01:06 EDT
Received: from [192.168.1.82] (helo=[192.168.1.82])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1HZ3cy-0002bG-Re
	for git@vger.kernel.org; Wed, 04 Apr 2007 11:26:13 +0000
X-Mailer: Evolution 2.8.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43729>

Hi,

This is not the case of looking through the logs for my commit as I'm
exporting my changes from my tree into the company system through CVS.
This means all the usual commit tracking benefits are lost.

So I have a master branch which tracks this master baseline from CVS and
each release I import a big change set which includes all the fixes that
went into that baseline.

What I need to do is check that my commits that I submitted for the
baseline have been correctly merged. Of course if I do "git-diff
master..mywork" I'll see all the other code that has been added in (or
more usually is missing from my branch).

Is there an invocation of git-diff or another tool that can tell me all
my diffs are present in the big uber-commit of my master branch baseline
release?

-- 
Alex, homepage: http://www.bennee.com/~alex/
Any excuse will serve a tyrant. -- Aesop
