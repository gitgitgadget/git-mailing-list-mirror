From: Martin Atukunda <matlads@dsmagic.com>
Subject: Error cloning cogito.git (rsync: link_stat failed)
Date: Tue, 20 Sep 2005 19:52:18 +0300
Message-ID: <20050920165218.GA6956@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 18:55:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHlOf-0002s8-SN
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 18:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVITQzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 12:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbVITQzG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 12:55:06 -0400
Received: from mail1.starcom.co.ug ([217.113.72.31]:45575 "EHLO
	mail1.infocom.co.ug") by vger.kernel.org with ESMTP id S932671AbVITQzF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 12:55:05 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Tue, 20 Sep 2005 19:54:43 +0300
  id 000E5DCB.43303ED3.00005BDC
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 3C6E54D78
	for <git@vger.kernel.org>; Tue, 20 Sep 2005 19:56:11 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.52)
	id 1EHlLu-0002Gs-4X
	for git@vger.kernel.org; Tue, 20 Sep 2005 19:52:18 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9009>

Hi I get the following when trying to clone cogito.git.

matlads@igloo:~/src$ git clone rsync://rsync.kernel.org/pub/scm/git/cogito.git/ cogito
defaulting to local storage area

receiving file list ... rsync: link_stat "/scm/git/cogito.git//objects/." (in pub) failed: No such file or directory (2)
done

sent 14 bytes  received 17 bytes  4.77 bytes/sec
total size is 0  speedup is 0.00
rsync error: some files could not be transferred (code 23) at main.c(1173)
matlads@igloo:~/src$ git --version
git version 0.99.7
matlads@igloo:~/src$ du -sh cogito
1.1M    cogito
matlads@igloo:~/src$ rm -fr cogito
matlads@igloo:~/src$ git clone http://www.kernel.org/pub/scm/git/cogito.git/ cogito
defaulting to local storage area
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?
matlads@igloo:~/src$ git --version
git version 0.99.7
matlads@igloo:~/src$ 

-- 
Your entire blood supply is filtered through your kidneys in four minutes.
