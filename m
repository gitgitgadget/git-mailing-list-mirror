From: barrymac <barrymac@gmail.com>
Subject: cvsimport in cron
Date: Mon, 26 May 2008 11:00:39 -0700 (PDT)
Message-ID: <17476529.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 20:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0h0j-0002Zt-TR
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 20:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbYEZSAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 14:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbYEZSAl
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 14:00:41 -0400
Received: from kuber.nabble.com ([216.139.236.158]:50577 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbYEZSAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 14:00:40 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1K0gzv-0003y4-GZ
	for git@vger.kernel.org; Mon, 26 May 2008 11:00:39 -0700
X-Nabble-From: barrymac@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82944>


Hi All,

Apologies if this is a standard mistake, I'm not very experienced with cron. 
I'm trying to run cvsimport commands from within a cron job but it always
returns:
cvs: Connection refused
Use of uninitialized value in scalar chomp at /usr/bin/git-cvsimport line
349.
Use of uninitialized value in substitution (s///) at /usr/bin/git-cvsimport
line 350.
Expected Valid-requests from server, but got: <unknown>

I use ssh keys and have tested that they work  by using scp within the
script. The script goes as follows:

keychain /var/spool/gitosis/.ssh/id_rsa
. /var/spool/gitosis/.keychain/`uname -n`-sh

git-cvsimport -d :ext:barrym@cvs:/cvsroot -vio master CVSMODULE 

It would also be nice if someone could tell me also how to log the output. 

Thanks in advance,
Barry.

-- 
View this message in context: http://www.nabble.com/cvsimport-in-cron-tp17476529p17476529.html
Sent from the git mailing list archive at Nabble.com.
