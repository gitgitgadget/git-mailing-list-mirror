From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (amend)] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 21:14:29 +0200
Organization: At home
Message-ID: <eec9lt$7ll$1@sea.gmane.org>
References: <200609140839.56181.jnareb@gmail.com> <200609141939.39406.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 14 21:14:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNwfK-0003mM-Kc
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 21:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWINTOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 15:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWINTOT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 15:14:19 -0400
Received: from main.gmane.org ([80.91.229.2]:64940 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751053AbWINTOS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 15:14:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNwf5-0003iW-5y
	for git@vger.kernel.org; Thu, 14 Sep 2006 21:14:11 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 21:14:11 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 21:14:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27027>

Gaah, the code spews quite a lot of warnings as of now.

Variable "$pfxlen" will not stay shared at gitweb.perl line 724.
Variable "@list" will not stay shared at gitweb.perl line 727.
...
-- 
Jakub Narebski
