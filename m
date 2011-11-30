From: Peter Williams <peter_ono@users.sourceforge.net>
Subject: [HELP] Adding git awareness to the darning patch management system.
Date: Wed, 30 Nov 2011 12:17:22 +1000
Message-ID: <4ED59232.3000807@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 08:03:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVeCi-0000ez-D3
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 08:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab1K3HDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 02:03:35 -0500
Received: from nschwqsrv01p.mx.bigpond.com ([61.9.189.231]:64723 "EHLO
	nschwqsrv01p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753406Ab1K3HDf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2011 02:03:35 -0500
Received: from nschwotgx04p.mx.bigpond.com ([60.231.88.110])
          by nschwmtas02p.mx.bigpond.com with ESMTP
          id <20111130021723.VKAY391.nschwmtas02p.mx.bigpond.com@nschwotgx04p.mx.bigpond.com>
          for <git@vger.kernel.org>; Wed, 30 Nov 2011 02:17:23 +0000
Received: from mudlark.pw.nest ([60.231.88.110])
          by nschwotgx04p.mx.bigpond.com with ESMTP
          id <20111130021723.QVFH1687.nschwotgx04p.mx.bigpond.com@mudlark.pw.nest>
          for <git@vger.kernel.org>; Wed, 30 Nov 2011 02:17:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at nschwotgx04p.mx.bigpond.com from [60.231.88.110] using ID pwil3058@bigpond.net.au at Wed, 30 Nov 2011 02:17:23 +0000
X-SIH-MSG-ID: rBo3FNL4TECznTh522DtQVUtlUy7/yU1v8pWRYIhuRwYUkTAuN/WS9SicqNRptuyxEATcAqGPnEgYablWoXTscmyIb1QYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186111>

I'm the author of the darning patch management system 
<http://darning.sourceforge.net/> and would like some help adding git 
awareness to the system.  At this stage of the development, "awareness" 
is fairly simple concept with two broad aims:

1. presenting the file tree of the sources being patched in a way that 
makes sense to the user including the current status of files from the 
point of view of the underlying SCM (in this case, git), and

2. detecting files with uncommitted changes (from the SCM's point of 
view) when the user adds them to a patch (or pushes a patch that 
contains them) so that they may be alerted to the fact and offered the 
choice of absorbing the uncommitted changes into the patch (or not).

I've already implemented this interface for Mercurial (with which I am 
familiar) and looked at doing the same with git but had difficulty 
discovering the definitive mechanisms for obtaining the necessary data. 
  So I'm soliciting your help in overcoming these problems.

Darning's source is managed by Mercurial and can be perused at:

<http://darning.hg.sourceforge.net/hgweb/darning/darning>

The interface to be implemented is defined in the file 
darning/scm_ifce.py and the implementation for Mercurial is in the file 
scm_ifce_hg.py.

Any help or pointers would be appreciated.

Thanks
Peter
