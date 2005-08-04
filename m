From: Olof Johansson <olof@lixom.net>
Subject: gitweb: not all files listed in commit list
Date: Wed, 3 Aug 2005 20:49:16 -0500
Message-ID: <20050804014916.GB10556@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 04 03:52:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0UtZ-0000IH-PR
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 03:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVHDBv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 21:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVHDBv0
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 21:51:26 -0400
Received: from lixom.net ([66.141.50.11]:3231 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S261667AbVHDBvY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 21:51:24 -0400
Received: from olof by mail.lixom.net with local (Exim 3.36 #1 (Debian))
	id 1E0LDM-00011s-00
	for <git@vger.kernel.org>; Wed, 03 Aug 2005 10:31:28 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

My apologies if this has already been found and reported; I'm not
tracking the list closely.

It seems that newly introduced files are not shown in gitweb.
For example, see the following commit:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fce0d5740322b98b863f9e609f5a9bd4c06703af

"13 files changed:", but only 11 listed. The two newly added files
(arch/ppc64/kernel/machine_kexec.c and include/asm-ppc64/kexec.h) are
not shown.


-Olof
