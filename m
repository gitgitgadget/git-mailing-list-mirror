From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: running git-update-cache --refresh on different machines on a NFS share always ends up in a lot of io/cpu/time waste
Date: Sun, 22 May 2005 14:28:49 +0200
Message-ID: <20050522122849.GJ15178@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 14:28:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZpYS-0008EK-EJ
	for gcvg-git@gmane.org; Sun, 22 May 2005 14:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVEVM2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 08:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVEVM2w
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 08:28:52 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:11930 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261795AbVEVM2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 08:28:51 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MCSnS8000217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 May 2005 12:28:49 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MCSnqG000216
	for git@vger.kernel.org; Sun, 22 May 2005 14:28:49 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I wonder why 'git-update-cache --refresh' running in the same directory
shared via NFS ends up in reindexing the whole files when running on
different machines on a NFS share.

Is there a reason for this or can it easily be fixes. I also wonder if
the locking which is used to lock the cache is 'nfs safe'.

	Thomas
