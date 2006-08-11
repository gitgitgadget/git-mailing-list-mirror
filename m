From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] git-sh-setup: Fail if the git directory was not found.
Date: Fri, 11 Aug 2006 21:42:26 +0200
Message-ID: <20060811194226.GA12276@steel.home>
References: <44DC4C92.5060009@codeweavers.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 11 21:43:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBcuL-000269-GN
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 21:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWHKTms (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 15:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWHKTms
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 15:42:48 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:43153 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932292AbWHKTmr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 15:42:47 -0400
Received: from fwd35.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1GBctt-0005Lo-03; Fri, 11 Aug 2006 21:42:33 +0200
Received: from tigra.home (EeNV7uZSYeYy6lnm7RihtJjDqLML+velFIK4qWyJdmWtuvqy-HaT0T@[84.160.97.72]) by fwd35.sul.t-online.de
	with esmtp id 1GBctm-0h13Ls0; Fri, 11 Aug 2006 21:42:26 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4352E277AF;
	Fri, 11 Aug 2006 21:42:26 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GBctm-0003PW-49; Fri, 11 Aug 2006 21:42:26 +0200
To: Robert Shearman <rob@codeweavers.com>
Content-Disposition: inline
In-Reply-To: <44DC4C92.5060009@codeweavers.com>
User-Agent: Mutt/1.5.6i
X-ID: EeNV7uZSYeYy6lnm7RihtJjDqLML+velFIK4qWyJdmWtuvqy-HaT0T
X-TOI-MSGID: d746992c-a7b9-48ba-af63-95c5a77edc16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25237>

Robert Shearman, Fri, Aug 11, 2006 11:23:30 +0200:
> Always use git-rev-parse to find a valid git directory, as 
> git-repo-config no longer returns an error code if a git directory 
> wasn't found.

BTW, did anyone notice that "--usage" almost always needs git
directory? That is quite unusual.
