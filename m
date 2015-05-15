From: Ed Avis <eda@waniasset.com>
Subject: git log --raw abbreviates SHA1s, despite what manual says
Date: Fri, 15 May 2015 14:46:14 +0000 (UTC)
Message-ID: <loom.20150515T164345-901@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 16:46:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtGsg-0007ch-QN
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 16:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbbEOOq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 10:46:26 -0400
Received: from plane.gmane.org ([80.91.229.3]:36498 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638AbbEOOqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 10:46:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YtGsa-0007Yy-A3
	for git@vger.kernel.org; Fri, 15 May 2015 16:46:24 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 16:46:24 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 16:46:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269148>

The manual page for git-log says:

           The raw format shows the entire commit exactly as stored in the
           commit object. Notably, the SHA-1s are displayed in full,
           regardless of whether --abbrev or --no-abbrev are used,

But this is not quite true.  Here is an example line from 'git log --raw':

    :100644 100644 9a203c9... daa08a7... M  myfilename

If I instead run 'git log --raw --no-abbrev', it prints full SHA-1s instead.

I think it would be more useful for the behaviour to match the documentation,
and for --raw to imply --no-abbrev in all cases.

-- 
Ed Avis <eda@waniasset.com>
