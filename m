From: Daniel Corbe <corbe@corbe.net>
Subject: Location of git config on Windows
Date: Sun, 17 Aug 2014 16:18:23 -0400
Message-ID: <ygfvbpqooog.fsf@corbe.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:26:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ71z-0006wP-4Z
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 22:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbaHQU0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 16:26:16 -0400
Received: from a0i313.smtpcorp.com ([216.22.15.145]:56901 "EHLO
	a0i313.smtpcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbaHQU0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 16:26:15 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Aug 2014 16:26:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=smtpcorp.com; s=a0_1;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From; bh=jDNKI99Z2qHpDSud9KjbrnhdrJ2owINLzODa2sA6HA4=;
	b=g7x9NfLgxgJLzdUp9ECYndJNXL5IKj8HHdQ+cD5exUR9sKEJwj1iLqkmjmnIIRUuGaOKTQUz7cz8qYbZH/Wil2EUf2UWYE+VZRWB4l/y1V8/RKEdzO5bAyaYEd+lrnq0dtnafdmstv5zGYJ3fxaRJ7VBzwS8P9VYj4yJB/aavIU=;
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (berkeley-unix)
X-Smtpcorp-Track: 1bJ6IG4gfFQf3I.8Q4RbwUxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255375>


I installed git on my Windows machine while it was connected to my
corporate network.  It picked up on that fact and used a mapped drive to
store its configuration file.  

As a result, I cannot currently use git when disconnected from my
network.  It throws the following error message: fatal: unable to access
'Z:\/.config/git/config': Invalid argument

Obviously this value is stored in the registry somewhere because I made
an attempt to uninstall and reinstall git with the same results.  

Can someone give me some guidance here?

Best,
Daniel

P.S. A screenshot for reference: http://i.imgur.com/i9lm0Da.png
