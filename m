From: Peter Krefting <peter@softwolves.pp.se>
Subject: Bad DWIM response when git gui cannot start
Date: Mon, 20 Jul 2009 13:11:21 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0907201309150.5423@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 14:11:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSriN-0008CV-HG
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 14:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbZGTMLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 08:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZGTMLY
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 08:11:24 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:37692 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751053AbZGTMLX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 08:11:23 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n6KCBLWB030889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 Jul 2009 14:11:21 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n6KCBL9P030883;
	Mon, 20 Jul 2009 14:11:21 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 20 Jul 2009 14:11:21 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123596>

If git cannot start one of the external commands (at least some of them), 
the DWIM engine is a bit flaky:

   $ git citool
   /usr/local/libexec/git-core/git-citool: line 10: exec: wish: not found
   git: 'citool' is not a git-command. See 'git --help'.

   Did you mean this?
       citool

   $ git gui
   /usr/local/libexec/git-core/git-gui: line 10: exec: wish: not found
   git: 'gui' is not a git-command. See 'git --help'.

   Did you mean this?
       gui

-- 
\\// Peter - http://www.softwolves.pp.se/
