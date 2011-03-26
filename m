From: Kacper Kornet <kornet@camk.edu.pl>
Subject: GIT_WORK_TREE and GIT_DIR with git clone
Date: Sat, 26 Mar 2011 13:58:18 +0100
Message-ID: <20110326125818.GA2621@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 14:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3TNk-0007dw-4S
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 14:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab1CZNSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 09:18:14 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:58846 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab1CZNSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 09:18:13 -0400
X-Greylist: delayed 1185 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Mar 2011 09:18:13 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 832325F0047
	for <git@vger.kernel.org>; Sat, 26 Mar 2011 13:58:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DONY+dzN+je0 for <git@vger.kernel.org>;
	Sat, 26 Mar 2011 13:58:18 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 85BCA5F0046
	for <git@vger.kernel.org>; Sat, 26 Mar 2011 13:58:18 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 72BED80F32; Sat, 26 Mar 2011 13:58:18 +0100 (CET)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170051>

Is there a reason why git clone does not respect GIT_DIR
variable. I have found it confusing that:

GIT_WORK_TREE=repo GIT_DIR=repo/.git git clone <path>/repo.git

is not equivalent to

git clone <path>/repo.git

-- 
  Kacper
