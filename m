From: Felipe Balbi <me@felipebalbi.com>
Subject: fixing duplicated history
Date: Thu, 13 Nov 2008 00:23:51 +0200
Message-ID: <20081112222346.GA24013@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 23:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0OA4-0002Wt-Gz
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbYKLWYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbYKLWYh
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:24:37 -0500
Received: from ns1.siteground211.com ([209.62.36.12]:53325 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbYKLWYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:24:36 -0500
Received: from a91-154-126-168.elisa-laajakaista.fi ([91.154.126.168]:14169 helo=frodo)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1L0O8X-0003m6-04
	for git@vger.kernel.org; Wed, 12 Nov 2008 16:24:33 -0600
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground211.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - felipebalbi.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100822>

Hi,

I have a git tree which history is completely messed up with duplicated
entries. By reading git man pages I saw that it might be possible to
delete those duplicated entries with git reflog delete, am I reading it
right ?

If so, would it cause any problems to the users who already cloned the
original tree ? I mean, will git see it as a different history line and
try a merge or will it figure it's the same tree with the duplicated
entries removed ?

Thanks in advance for the help

-- 
balbi
