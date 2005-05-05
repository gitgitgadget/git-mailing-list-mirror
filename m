From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: git-diff-cache uses checked-out-working-directory-files if files are newer than the cache entry
Date: Fri, 6 May 2005 00:58:22 +0200
Message-ID: <20050505225822.GT20994@cip.informatik.uni-erlangen.de>
References: <20050505223727.GR20994@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 00:52:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTpCF-0000RL-5X
	for gcvg-git@gmane.org; Fri, 06 May 2005 00:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVEEW60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 18:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVEEW60
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 18:58:26 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:31681 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261790AbVEEW6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 18:58:24 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j45MwNS8005635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 5 May 2005 22:58:23 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j45MwMCJ005634
	for git@vger.kernel.org; Fri, 6 May 2005 00:58:22 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050505223727.GR20994@cip.informatik.uni-erlangen.de>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

* Thomas Glanzmann <sithglan@stud.uni-erlangen.de> [050506 00:38]:
> I have trouble with git-diff-cache, because it uses the file from the
> working directory instead of the cache file if the working directory is
> newer than the entry in the cache:

'git-diff-cache -r --cached HEAD' does what I want.
                   ~~~~~~~~

	Thomas
