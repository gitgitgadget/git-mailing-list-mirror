From: gerhard.oettl.ml@ogersoft.at
Subject: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 12:11:36 +0100
Message-ID: <47416F68.9070908@ogersoft.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 12:24:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu4jc-0004Bk-W6
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 12:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXKSLX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 06:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbXKSLX4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 06:23:56 -0500
Received: from h082218134240.host.wavenet.at ([82.218.134.240]:53989 "EHLO
	h082218134240.host.wavenet.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751910AbXKSLX4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2007 06:23:56 -0500
X-Greylist: delayed 852 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2007 06:23:55 EST
Received: from [192.168.1.101] (85-124-70-106.work.xdsl-line.inode.at [85.124.70.106])
	(authenticated bits=0)
	by h082218134240.host.wavenet.at (8.13.8/8.13.8/SuSE Linux 0.8) with ESMTP id lAJB9TBS000993
	for <git@vger.kernel.org>; Mon, 19 Nov 2007 12:09:42 +0100
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65430>

I hope this is the correct mailing list. If not please point me in the 
right direction.


I played a little with git (1.5.3.4 / debian) and had the following 
observation:
Doing a "svn cp" (for example for a tag) results in a large traffic when 
doing a "git-svn fetch" afterwards.

To verify I did:
git-svn clone -s svn://www.ogersoft.at/ogerlit
git-svn fetch
svn cp svn://... svn://... (one file ca 3mb)
svk checkout (a tcpflow output of about 3k - plaintext commands, I think 
a svn checkout would be the same)
git-svn fetch (a tcpflow output of 700k - containing a textdelta of 
nearly 700k)


So the question remains:
Does svn-git dont know about lightweight svn copies?
or can svn-git not handle them correct by now?
or did I something wrong?


thanks
gerhard
