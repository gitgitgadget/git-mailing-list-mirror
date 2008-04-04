From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: git repository size vs. subversion repository size
Date: Fri, 4 Apr 2008 19:49:24 -0400
Message-ID: <p06240810c41c6e0993c1@[63.138.152.125]>
References: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com>
 <20080404221728.GA30728@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 01:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhvfi-0000z2-2X
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 01:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbYDDXtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYDDXtd
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 19:49:33 -0400
Received: from deanbrook.org ([66.160.189.173]:59775 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751408AbYDDXtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 19:49:33 -0400
Received: from 63.138.152.125 ([63.138.152.125]) by deanbrook.org for <git@vger.kernel.org>; Fri, 4 Apr 2008 16:49:31 -0700
In-Reply-To: <20080404221728.GA30728@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78823>

I'm just fooling around with git so far but I found a huge space 
savings after running git gc. Here are the rough numbers:

svn repo on server:        1GB
svn repo checked out:      2GB
git svn clone after gc:  384MB

That's saving the full history in git -- about 13000 revisions.

Using git version 1.5.4.4.
