From: Martin Svensson <martin.k.svensson@netinsight.se>
Subject: cherry-pick -x formats the message incorrectly
Date: Tue, 16 Nov 2010 09:14:15 +0000 (UTC)
Message-ID: <loom.20101116T100730-967@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 16 10:35:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIHwa-0000gu-TC
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 10:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934084Ab0KPJfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 04:35:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:44741 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934022Ab0KPJfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 04:35:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PIHwO-0000Za-LG
	for git@vger.kernel.org; Tue, 16 Nov 2010 10:35:04 +0100
Received: from ns1-2.netinsight.se ([194.16.221.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 10:35:04 +0100
Received: from martin.k.svensson by ns1-2.netinsight.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 10:35:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.16.221.18 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161552>

Hello,

I have a problem with the commit message format for "cherry-pick -x":
Given a commit with the message:

  foo

, i.e. with only a summary part, I do "git cherry-pick -x the_commit". The
result is a new commit with message

  foo
  (cherry picked from commit eb42a6475d2c2e4fff7a1b626ce6e27eec21e886)

Now that's not good, because it is a two-line summary. In my opinion, the
parentheses should _always_ end up in the detailed part.
It should be:

  foo
  
  (cherry picked from commit eb42a6475d2c2e4fff7a1b626ce6e27eec21e886)

Am I right?

/Martin Svensson, SW Developer
