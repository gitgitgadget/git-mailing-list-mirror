From: Nicolas Bock <nbock@lanl.gov>
Subject: error: cannot lock ref 'refs/remotes/origin/*'
Date: Mon, 16 Jun 2008 10:53:47 -0600
Message-ID: <1213635227.17814.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:54:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Hyd-0006nD-8T
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbYFPQxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbYFPQxs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:53:48 -0400
Received: from proofpoint3.lanl.gov ([204.121.3.28]:38966 "EHLO
	proofpoint3.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbYFPQxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:53:48 -0400
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
	by proofpoint3.lanl.gov (8.13.8/8.13.8) with ESMTP id m5GGrlha007503
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 10:53:47 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailrelay2.lanl.gov (Postfix) with ESMTP id DC9931A8C448
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 10:53:47 -0600 (MDT)
X-CTN-5-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from [128.165.45.12] (dasboot.lanl.gov [128.165.45.12])
	by mailrelay2.lanl.gov (Postfix) with ESMTP id A98F71A8C444
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 10:53:47 -0600 (MDT)
X-Mailer: Evolution 2.12.3 
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.7161:2.4.4,1.2.40,4.0.164 definitions=2008-06-16_09:2008-06-16,2008-06-16,2008-06-16 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85212>

Hello list,

when running "git gc" I get the following error message as of late:

$ git gc
error: cannot lock ref 'refs/remotes/origin/*'
error: failed to run reflog

When I rsync the directory tree to another machine, I can run "git gc"
without any error messages. What exactly does this error mean? Why would
locking fail?

Thanks already,

nick
