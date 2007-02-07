From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: describe fails on tagless branch
Date: Wed, 07 Feb 2007 01:23:38 +0100
Message-ID: <eqb660$ft7$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 01:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEabh-0000ah-CQ
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 01:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbXBGAXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 19:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbXBGAXn
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 19:23:43 -0500
Received: from main.gmane.org ([80.91.229.2]:48876 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030312AbXBGAXm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 19:23:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEab6-0002sE-3N
	for git@vger.kernel.org; Wed, 07 Feb 2007 01:23:40 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 01:23:40 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 01:23:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38880>



try 

  git init
  echo hoi > a
  git add a
  git commit -m 'add a' a
  git describe

this yields


[lilydev@haring t]$ git describe
fatal: cannot describe '3b26396bbb5f18580ffd4bc31f70ef0738ec73d6'


I would prefer it if an implicit tag INIT was supposed at the start of the
history, so we'd get

  INIT-3b2...


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
