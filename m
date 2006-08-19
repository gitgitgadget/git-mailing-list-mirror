From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use common parameter parsing and generation for "o", too.
Date: Sat, 19 Aug 2006 23:44:27 +0200
Organization: At home
Message-ID: <ec80nk$i25$1@sea.gmane.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <ec1d6q$823$2@sea.gmane.org> <20060817191300.GA11477@admingilde.org> <200608172134.38751.jnareb@gmail.com> <20060818202013.GB30022@admingilde.org> <ec6qnp$aal$1@sea.gmane.org> <20060819183303.GC30022@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 19 23:44:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEYcP-0003fT-Ea
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 23:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWHSVoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWHSVoe
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 17:44:34 -0400
Received: from main.gmane.org ([80.91.229.2]:48042 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751828AbWHSVoe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 17:44:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GEYcG-0003e3-If
	for git@vger.kernel.org; Sat, 19 Aug 2006 23:44:28 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 23:44:28 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 23:44:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25736>

Martin Waitz wrote:

> hoi :)
> 
> On Sat, Aug 19, 2006 at 12:55:57PM +0200, Jakub Narebski wrote:
>>> Perhaps introduce a new function which is used to access the parameters?
>>> This new function could check the URL or CGI->param or whatever and then
>>> return the requested value.
>> 
>> CGI->param. There is no reason to duplicate CGI module.
> 
> yes there is.
> using CGI->param it is not possible to use nice URLs ala
> http://git.site.org/projectpath.git
> 
> I would really appreciate to be able to use nice URLs in gitweb that
> correspond to the repository URL.

As far as I know it is now possible (of course if your web server is
configured to redirect / to gitweb.cgi, e.g. for Apache using ScriptAlias
directive) via PATH_INFO support. At least it is what is intended.

Gitweb doesn't generate links in such a way, yet, but this should be fairly
easy now, changing only href() subroutine.

But apart from this one parameter the rest have to be passed as CGI
parameters,
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
