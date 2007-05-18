From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: git-rebase (1.5.0.6) errors
Date: Fri, 18 May 2007 11:47:18 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 10:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hoy7T-0004Z4-D2
	for gcvg-git@gmane.org; Fri, 18 May 2007 10:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbXERIrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 04:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754488AbXERIrW
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 04:47:22 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:58262 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbXERIrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 04:47:21 -0400
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi [128.214.9.42])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Fri, 18 May 2007 11:47:20 +0300
  id 0007FFFB.464D6818.0000794D
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795)
	id F3653EBAE4; Fri, 18 May 2007 11:47:19 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id E34B6EAE3F
	for <git@vger.kernel.org>; Fri, 18 May 2007 11:47:19 +0300 (EEST)
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47580>

Hi,


ijjarvin@kivilampi-30:~/work/src/submit$ git-rebase net-2.6.22-origin
First, rewinding head to replay your work on top of it...
HEAD is now at d739437... [IPV4]: Correct rp_filter help text.
fatal: cannot convert from utf-8 to utf-8

ijjarvin@kivilampi-30:~/work/src/submit$ git-log -n 1 | cat
commit d739437207064cdcea8f9c81442284106cbcb67f
Author: Dave Jones <davej@redhat.com>
Date:   Thu May 17 15:02:21 2007 -0700

    [IPV4]: Correct rp_filter help text.
    
    As mentioned in http://bugzilla.kernel.org/show_bug.cgi?id=5015
    The helptext implies that this is on by default.
    This may be true on some distros (Fedora/RHEL have it enabled
    in /etc/sysctl.conf), but the kernel defaults to it off.
    
    Signed-off-by: Dave Jones <davej@redhat.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
ijjarvin@kivilampi-30:~/work/src/submit$ git-rebase --abort
HEAD is now at e413863... [TCP] FRTO: Add missing ECN CWR sending to one of the responses
ijjarvin@kivilampi-30:~/work/src/submit$ git --version
git version 1.5.0.6


I find at least two problems in it...
  - Non-sense error message: "convert from utf-8 to utf-8" ?!?
  - It fails to rebase the e413863 changeset



-- 
 i.
