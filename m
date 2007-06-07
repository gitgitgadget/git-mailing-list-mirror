From: kurt_p_lloyd <kplloyd@alcatel-lucent.com>
Subject: pull/merge --no-commit
Date: Thu, 07 Jun 2007 00:26:49 -0400
Message-ID: <46678909.10608@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 06:32:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw9fd-0003ZL-1R
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 06:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXFGEcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 00:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbXFGEcP
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 00:32:15 -0400
Received: from ihemail3.lucent.com ([135.245.0.37]:52928 "EHLO
	ihemail3.lucent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbXFGEcO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 00:32:14 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2007 00:32:14 EDT
Received: from homail.ho.lucent.com (h135-17-192-10.lucent.com [135.17.192.10])
	by ihemail3.lucent.com (8.13.8/IER-o) with ESMTP id l574QoHF006381
	for <git@vger.kernel.org>; Wed, 6 Jun 2007 23:26:50 -0500 (CDT)
Received: from cde1806.inse.lucent.com (cde1806.inse.lucent.com [152.148.202.141])
	by homail.ho.lucent.com (8.11.7p1+Sun/8.12.11) with ESMTP id l574QoI07288;
	Thu, 7 Jun 2007 00:26:50 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070425)
X-Scanned-By: MIMEDefang 2.57 on 135.245.2.37
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49348>

Hello,
I'm new to git, thought I'd take it for a spin.
Found what seems to me to be a problem,
hoping someone can shed light on it.

I /really/ want --no-commit to work, bit it doesn't seem to:

I run:      git pull --no-commit ssh://<blah blah blah>

then I run: git status

it says:    nothing to commit (working directory clean)

then I run: git log

it shows the commit message from the other user below a
commit sha1, and the change I pulled was indeed merged to
my file.

Does this seem to be a bug, or am I doing something wrong?
BTW, merge --no-commit gives me the same problem.  It merges
fine but does the commit.

I put a 'set -x' in the git-merge shell script (which gets
called by pull) from one of my 'pull' runs, I have the output
if anyone wants it.

-Kurt
