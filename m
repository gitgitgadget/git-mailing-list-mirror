From: Lucio Crusca <lucio@sulweb.org>
Subject: git: 'daemon' is not a git command. See 'git --help'.
Date: Mon, 30 May 2011 12:58:08 +0200
Organization: Virtual Bit di Lucio Crusca
Message-ID: <201105301258.08178.lucio@sulweb.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 13:08:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR0Kk-0002vU-0f
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 13:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836Ab1E3LIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 07:08:24 -0400
Received: from 47-67.174.81.serverdedicati.seflow.net ([81.174.67.47]:51804
	"EHLO vps.virtual-bit.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751336Ab1E3LIY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 07:08:24 -0400
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 May 2011 07:08:24 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by vps.virtual-bit.com (Postfix) with ESMTP id 4AEFF13B0012
	for <git@vger.kernel.org>; Mon, 30 May 2011 12:58:09 +0200 (CEST)
Received: from vps.virtual-bit.com ([127.0.0.1])
	by localhost (vps.virtual-bit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VC+YkrOboQF1 for <git@vger.kernel.org>;
	Mon, 30 May 2011 12:58:09 +0200 (CEST)
Received: from precision.localnet (83-103-61-191.ip.fastwebnet.it [83.103.61.191])
	by vps.virtual-bit.com (Postfix) with ESMTPA id F3A6C13B000E
	for <git@vger.kernel.org>; Mon, 30 May 2011 12:58:08 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174737>

Hi *,

I'm very new to git and I'm trying to share a git repo on a Centos 5.6 server. 
I've installaed git 1.7.4.1 with yum (I already had the epel repo setup).
git init, add, commit work as expected, but when I 

# touch .git/git-daemon-export-ok

and

# git daemon

I get:

git: 'daemon' is not a git command. See 'git --help'.

And no git-daemon file can be found in /usr (find /usr -name git-daemon). Google 
seems to be aware of this problem only about msysGit (windows).

What am I doing wrong?

Please CC me as I'm not subscribed, thanks.

Lucio.
