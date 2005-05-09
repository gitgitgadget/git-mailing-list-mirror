From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Howto get repository up2date after pull with touching as less as possible files in the working directory
Date: Mon, 9 May 2005 19:49:51 +0200
Message-ID: <20050509174951.GK24216@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 09 19:57:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVCHa-0002Qz-F8
	for gcvg-git@gmane.org; Mon, 09 May 2005 19:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVEIRuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 13:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVEIRuH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 13:50:07 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:20910 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261463AbVEIRtx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 13:49:53 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j49HnpS8001188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 9 May 2005 17:49:52 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j49HnprJ001187
	for git@vger.kernel.org; Mon, 9 May 2005 19:49:51 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello alltogether,
at the moment I ensrure that there are no dirty files before the pull
and do a

	git-read-tree HEAD
	git-checkout -a -f
	git-update-cache --refresh

this is suboptimal because all the files in my working directory get a
new timestamp and if I call make everything is recompiled (ccache helps,
but is not the solution to this problem).

So what is the right way to touch *only* the files which are dirty. Are
there any shortcuts? Or should I call 'git dirty' pipe that to
git-checkout -f?

	Thomas
