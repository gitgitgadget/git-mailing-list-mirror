From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: Something looks like CVS modules
Date: Fri, 11 Nov 2005 16:42:25 +0600
Organization: AcademSoft Ltd.
Message-ID: <200511111642.25908.lan@ac-sw.com>
References: <200511111313.27273.lan@ac-sw.com> <20051111102857.GM30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 11:43:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaWLT-0008Cf-Ec
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 11:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVKKKlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 05:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVKKKlV
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 05:41:21 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:7353 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932372AbVKKKlU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 05:41:20 -0500
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 41037BD1B; Fri, 11 Nov 2005 16:41:19 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id CCE9BFBEFD; Fri, 11 Nov 2005 16:42:26 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 3DF1846332;
	Fri, 11 Nov 2005 16:42:26 +0600 (NOVT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8
In-Reply-To: <20051111102857.GM30496@pasky.or.cz>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11581>

On Friday 11 November 2005 16:28, Petr Baudis wrote:
> Well, what exactly is the problem with just having multiple
> repositories?

1. The problem with checkout - single checkout should checkout all needed 
modules to build project. Update should also update all modules. The same 
with commit.
2. Tags should be done on all modules. All modules should be able to be in the 
same branch.

And in the same time one module should be able to exists in two or more 
projects !
