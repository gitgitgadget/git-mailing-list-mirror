From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Git and cogito uses different exclude files
Date: Fri, 16 Sep 2005 09:49:22 +0200
Message-ID: <432A7902.20603@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 16 09:49:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGAyN-0005tL-7r
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 09:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbVIPHtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 03:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbVIPHtY
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 03:49:24 -0400
Received: from [85.8.12.41] ([85.8.12.41]:40322 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1161118AbVIPHtX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 03:49:23 -0400
Received: from [192.168.128.82] (alcatraz.cendio.se [::ffff:193.12.253.67])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Fri, 16 Sep 2005 09:49:22 +0200
  id 00062716.432A7902.00002D08
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8670>

This has probably been pointed out previously, but I couldn't seem to
find it in the archives.

'git status' and 'cg-status'/'stg status' uses different locations for
the exclude files. git expects .git/info/exclude and cogito and stgit
expects .git/exclude. This is easily solved by a symlink but it could be
nice if common files have a single correct location. :)

Rgds
Pierre
