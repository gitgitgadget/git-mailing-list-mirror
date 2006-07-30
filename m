From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 11] gitweb: Read project description using utf-8 encoding
Date: Sun, 30 Jul 2006 17:20:33 +0200
Organization: At home
Message-ID: <eaiino$oo2$1@sea.gmane.org>
References: <200607292239.11034.jnareb@gmail.com> <200607301613.49947.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jul 30 17:20:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7D61-0005IT-I0
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 17:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWG3PUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 11:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWG3PUm
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 11:20:42 -0400
Received: from main.gmane.org ([80.91.229.2]:28112 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932334AbWG3PUm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 11:20:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7D5q-0005GL-Iq
	for git@vger.kernel.org; Sun, 30 Jul 2006 17:20:38 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 17:20:38 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 17:20:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24459>

Disregard this patch for now. It corrects error in project_list page, but
introduces errors on other pages:

  Software error: Cannot decode string with wide characters 
  at Encode.pm line 166.

Corrected patch to follow.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
