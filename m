From: Josef Wolf <jw@raven.inka.de>
Subject: How to restrict gitk to show only branch/merge commits?
Date: Wed, 6 May 2009 09:20:53 +0200
Message-ID: <20090506072053.GL15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 09:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1ba8-0005kS-JC
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 09:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbZEFHaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 03:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbZEFHaL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 03:30:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:48701 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbZEFHaK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 03:30:10 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M1bZx-0006sw-K7; Wed, 06 May 2009 09:30:10 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 5BF732CCAA; Wed,  6 May 2009 09:20:53 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118329>

Hello,

I would like gitk to show me only the heads, branch-points and
merge-points of branches.

For example, given a history like this:

                   d...e--F--g...h--H
                  /        \
 a1--a2...an--b--C          N--o...p--P
                  \        /
                   i...j--K--l...m--M

I would like to see only

 - a1     because it has no parent
 - C,F,K  because they are reachable from multiple heads
 - N      because it has multiple parents
 - H,M,P  because they are heads

Ideally, there would be a possibility to add some "context" to the
list of commits to be shown: with $context==1, all the commits shown
in the above history would be shown, but the commits indicated by
the triple-dots would be omitted.

The reason is that I have some repositories with several really long
linear history.  It is hard to get a global overview about the branch
history if you have to scroll constantly.

Is something like that possible with gitk?
