From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Howto update a 'dirty' entry in the cache from the object database
Date: Wed, 4 May 2005 16:23:51 +0200
Message-ID: <20050504142351.GL18380@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 04 16:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTKiB-0007U6-Eg
	for gcvg-git@gmane.org; Wed, 04 May 2005 16:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVEDOYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 10:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVEDOYn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 10:24:43 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:25050 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261862AbVEDOX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 10:23:57 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j44ENpS8016353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 4 May 2005 14:23:51 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j44ENpSM016352
	for git@vger.kernel.org; Wed, 4 May 2005 16:23:51 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I edited a bunch of files and notice that I want to revert back one of
the files to the original one (the one that comes with HEAD). But I
already updated the cache. Is there a way to 'patch' the cache with the
original file. Or do I need todo a read-tree into a temporary index
file. Check out the one file from this alternate index file and use
update-cache to update my original index file?

	Thomas [ who want's a "git revert" ]
