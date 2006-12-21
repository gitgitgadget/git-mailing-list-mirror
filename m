From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: UI: git-tag should support -F as well
Date: Thu, 21 Dec 2006 12:52:53 +0100
Message-ID: <emdsi9$ecm$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 12:53:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxMU6-0004Gr-KC
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 12:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWLULxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 06:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWLULxH
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 06:53:07 -0500
Received: from main.gmane.org ([80.91.229.2]:57602 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030187AbWLULxG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 06:53:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxMTn-0005qX-9F
	for git@vger.kernel.org; Thu, 21 Dec 2006 12:52:55 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 12:52:55 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 12:52:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35058>


Working on a little darcs2git script, I found the following inconsistency

git-commit supports -m and -F 
git-tag supports only -m


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
