From: David Abrahams <dave@boostpro.com>
Subject: git diff bug?
Date: Fri, 03 Apr 2009 21:10:42 -0400
Message-ID: <m2ocvdkyul.fsf@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 03:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpuR9-0006Tg-Rh
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 03:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763972AbZDDBLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 21:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763471AbZDDBLG
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 21:11:06 -0400
Received: from main.gmane.org ([80.91.229.2]:41485 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763289AbZDDBLF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 21:11:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LpuPP-0003R9-5w
	for git@vger.kernel.org; Sat, 04 Apr 2009 01:10:55 +0000
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 01:10:55 +0000
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 01:10:55 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.91 (darwin)
Cancel-Lock: sha1:RRX7hR6sZwOoO04uzUnvE00Gqqg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115566>


Please see
http://github.com/techarcana/elisp/commit/63d672c296316c85690085930b05c642b88a9978#diff-2

Note how the @@ ... @@ clauses are followed by text from the previous
line's comment.  Not sure, but this strikes me as a line-ending issue.
custom.el was originally built on a linux machine; now I'm using a Mac.

Thanks!

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
