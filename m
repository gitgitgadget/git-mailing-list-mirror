From: Josef Wolf <jw@raven.inka.de>
Subject: Network problems during "git svn dcommit": need help!
Date: Wed, 22 Dec 2010 12:50:08 +0100
Message-ID: <20101222115008.GA10765@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 22 12:50:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVND7-0000Zw-8k
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 12:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab0LVLuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 06:50:14 -0500
Received: from quechua.inka.de ([193.197.184.2]:43644 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721Ab0LVLuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 06:50:13 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1PVNCu-0005RF-Dm; Wed, 22 Dec 2010 12:50:12 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 7D3E976119; Wed, 22 Dec 2010 12:50:08 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164083>

Hello,

I am using git-svn to track a subversion repository. This used to work
fine so far. But today, I got a network outage during a "git svn dcommit"
operation. I can see with gitk, that not all of my commits made it to
the svn repositoy. I tried "git svn rebase" and "git svn dcommit" to
resume, but they act as if I had no local commits.

Any hints how to fix the situation?
