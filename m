From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: Additions to commitdiff view
Date: Mon, 28 Aug 2006 14:48:09 +0200
Message-ID: <11567692943154-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 14:48:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHgXi-0005ac-VU
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 14:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWH1Ms2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 08:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWH1Ms1
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 08:48:27 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:9906 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750738AbWH1MsX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 08:48:23 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7SCl2ck031905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Aug 2006 14:47:02 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7SCmFR9017602;
	Mon, 28 Aug 2006 14:48:15 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7SCmEfm017601;
	Mon, 28 Aug 2006 14:48:14 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26151>

This series of patches makes signoff lines to be not removed in commitdiff and log 
views, adds author information to comittdiff view, and adds diff tree with links
to patches in commitdiff view.

You will be able to see it at work at
  http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi

Shortlog:
---------
1/5  gitweb: Make git_print_log generic; git_print_simplified_log uses it
2/5  gitweb: Do not remove signoff lines in git_print_simplified_log
3/5  gitweb: Add author information to commitdiff view
4/5  gitweb: git_print_log: signoff line is non-empty line
5/5  gitweb: Add diff tree, with links to patches, to commitdiff view

-- 
Jakub Narebski
ShadeHawk on #git
Poland
