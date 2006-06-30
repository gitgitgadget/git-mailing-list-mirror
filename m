From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 14] autoconf: Added --with/--without for openssl, curl, expat to ./configure
Date: Sat, 01 Jul 2006 00:34:44 +0200
Organization: At home
Message-ID: <e848tn$e36$1@sea.gmane.org>
References: <200606290301.51657.jnareb@gmail.com> <200606301708.19521.jnareb@gmail.com> <200606301711.39635.jnareb@gmail.com> <200606302345.17045.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jul 01 00:35:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwRZw-0007y2-0P
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 00:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWF3WfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 18:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWF3WfF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 18:35:05 -0400
Received: from main.gmane.org ([80.91.229.2]:22163 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750735AbWF3WfE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 18:35:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FwRZm-0007x5-HE
	for git@vger.kernel.org; Sat, 01 Jul 2006 00:35:02 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 00:35:02 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 00:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23022>

Jakub Narebski wrote:

> +AC_ARG_WITH(expat,
> +AS_HELP_STRING([--with-expat],[support git-push using http:// and https:// transports via WebDAV (default is YES)])
> +AS_HELP_STRING([],            [ARG can be also prefix for expat library and headers]),\
> +MY_PARSE_WITH(EXPAT))

Of course to do anything for --with-expat=PATH case this patch needs
the one that introduces EXPATDIR (there was such patch on the list,
I'm not sure if it got accepted).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
