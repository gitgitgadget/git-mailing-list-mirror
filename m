From: Samuel Tardieu <sam@rfc1149.net>
Subject: Remotes order in "git remote update"
Date: Sun, 09 Mar 2008 11:22:33 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-09-11-22-34+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 11:23:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYIgY-000786-AM
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 11:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbYCIKWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 06:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbYCIKWi
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 06:22:38 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:52569 "EHLO
	mail2.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbYCIKWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 06:22:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 576CDC408D;
	Sun,  9 Mar 2008 11:22:34 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pyjYwtI1fGWR; Sun,  9 Mar 2008 11:22:34 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 31299C40B8; Sun,  9 Mar 2008 11:22:34 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76645>

It looks like remote repositories are ordered alphabetically by their
local names when doing a "git remote update". In a project I follow,
it has an unfortunate consequence: a dumb remote repository using
"http://" is fetched first, while many commits are shared between all
the upstreams I follow.

If remotes were fetched using their order in .git/config, it would
fetch from a "git://" remote repository first, limiting transfers from
the dumb remote repository. Is there a way to force the update order
short of changing the local names or issuing multiple fetch commands?

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

