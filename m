From: Philippe De Muyter <phdm@macqel.be>
Subject: git fast-export and lightweight tags
Date: Tue, 7 Jun 2011 13:02:13 +0200
Message-ID: <20110607110213.GA2698@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTu3K-0001CS-Tj
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 13:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab1FGLCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 07:02:18 -0400
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:62642 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751693Ab1FGLCR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 07:02:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjgHAOED7k3CTtAn/2dsb2JhbABTl3SOKHeqTp9NhiEEkQqPRw
Received: from smtp2.macqel.be ([194.78.208.39])
  by relay.skynet.be with ESMTP; 07 Jun 2011 13:02:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id 7BA62130DE1
	for <git@vger.kernel.org>; Tue,  7 Jun 2011 13:02:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dCXfY9iJ-4RK for <git@vger.kernel.org>;
	Tue,  7 Jun 2011 13:02:14 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id E938C130A5E
	for <git@vger.kernel.org>; Tue,  7 Jun 2011 13:02:13 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id C80EBDF0477; Tue,  7 Jun 2011 13:02:13 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175194>

Hello list,

I have a git project with plenty of tags created by

	git tag MYTAG

When I clone my git repo, I find my tags again using

	git tag

When I display it using gitweb or the git plugin for trac, I see them also.

But when I use

	git fast-export master

which is invoked by git2svn, my tags are not exported.  I checked that
using the following :

	git fast-export master > /tmp/repo.dump
	mkdir /tmp/repo.fast-imported
	cd /tmp/repo.fast-imported
	git init
	git fast-import < /tmp/repo.dump

How can I convince fast-export to export my tags ?

Philippe
