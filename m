From: Daniel Wagner <wagi@monom.org>
Subject: 'git log' numbering commits?
Date: Thu, 12 Apr 2012 09:54:12 +0200
Message-ID: <4F868A24.9090004@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 10:03:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIF07-0000gJ-8o
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 10:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762151Ab2DLIDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 04:03:24 -0400
Received: from hotel311.server4you.de ([85.25.146.15]:37420 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab2DLIDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 04:03:21 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2012 04:03:21 EDT
Received: from candlejack.bmw-carit.intra (mail.bmw-carit.de [62.245.222.98])
	(Authenticated sender: wagi)
	by hotel311.server4you.de (Postfix) with ESMTPSA id 13C9BCBE0A8
	for <git@vger.kernel.org>; Thu, 12 Apr 2012 09:54:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20120131 Thunderbird/10.0
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a stupid question I could not answer myself when reading the
excellent documentation.

My workflow involves a lot of "git rebase -i". For figuring out which
commit id to use I do first a 'git log --oneline'. Then I do copy past
the id to the 'git rebase -i'. The reason why I don't use relative
id such as HEAD~4, because I keep miscounting the commits.

So my question is there a magic option to have git log to enumerate the
commits, e.g.

1: 2fcd2b3 network: Remove unused function
2: b376b2a session: Fix introspection for Change()
3: 15c9cd0 wifi: Refactor desctruction of network object
4: a9c699f network: Remove device pointer in network_remove()
[...]

cheers,
daniel
