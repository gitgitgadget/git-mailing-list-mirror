From: Jakub Narebski <jnareb@gmail.com>
Subject: git-checkout doesn't understand -- separator
Date: Mon, 31 Jul 2006 11:35:26 +0200
Organization: At home
Message-ID: <eakisg$e6j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 11:37:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7UCy-00043F-QK
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 11:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWGaJhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 05:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWGaJhE
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 05:37:04 -0400
Received: from main.gmane.org ([80.91.229.2]:45011 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964829AbWGaJhD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 05:37:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7UC5-0003tb-RO
	for git@vger.kernel.org; Mon, 31 Jul 2006 11:36:14 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 11:36:13 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 11:36:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24505>

git-checkout doesn't understand '--' as a separator between <branch> (which
is optional, but you can always write HEAD), and <path>...

  1144:jnareb@roke:~/git> git checkout HEAD^ -- gitweb/gitweb.cgi
  git-checkout-index: -- is not in the cache

Strange...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
