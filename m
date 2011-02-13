From: Matthieu Imbert <matthieu.imbert@inria.fr>
Subject: remote branches
Date: Sun, 13 Feb 2011 08:42:37 +0100
Message-ID: <4D578B6D.9090803@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 08:53:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoWlN-00056b-SL
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 08:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab1BMHwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 02:52:39 -0500
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:39535
	"EHLO mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752672Ab1BMHwi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Feb 2011 02:52:38 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Feb 2011 02:52:38 EST
X-IronPort-AV: E=Sophos;i="4.60,464,1291590000"; 
   d="scan'208";a="87933614"
Received: from sso69-1-88-163-193-142.fbx.proxad.net (HELO [192.168.1.4]) ([88.163.193.142])
  by mail4-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-CAMELLIA256-SHA; 13 Feb 2011 08:42:38 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166641>

hi.

I have troubles (probably due to my misunderstanding) with git remote 
tracking branches. It seems to me that reality and documentation are 
different:

- i clone the linux git repo:

$ git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
linux-2.6.git

- then i add a remote tracking branch:

$ git remote add --tags drm-intel 
git://git.kernel.org/pub/scm/linux/kernel/git/ickle/drm-intel.git

- Then i do git fetch or git fetch drm-intel, but nothing happens, and 
git branch -r still only show me origin/HEAD and origin/master, no 
drm-intel branches, though these branches do exist since i can see them 
with git remote -v show drm-intel

what am i doing wrong here, any idea?
cheers,

-- 
Matthieu
