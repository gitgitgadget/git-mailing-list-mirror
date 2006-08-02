From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: optionally read config from GITWEB_CONFIG
Date: Wed, 02 Aug 2006 22:21:43 +0200
Organization: At home
Message-ID: <ear1fp$j9p$2@sea.gmane.org>
References: <20060802192333.GA30861@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 02 22:27:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NIb-0005NS-T8
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWHBU0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWHBU0f
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:26:35 -0400
Received: from main.gmane.org ([80.91.229.2]:16094 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932159AbWHBU0e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:26:34 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G8NH4-0004yE-CD
	for git@vger.kernel.org; Wed, 02 Aug 2006 22:25:02 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 22:25:02 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 22:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24675>

Jeff King wrote:

> Configuration will first be taken from variables inside the gitweb.cgi
> script, which in turn come from the Makefile. Afterwards, the contents of
> GITWEB_CONFIG are read, overriding the builtin defaults.
> 
> This should eliminate the need for editing the gitweb script at all. Users
> should edit the Makefile and/or add a config file.

Very nice.

> @@ -56,7 +50,7 @@ # URI of GIT logo
>  our $logo = "@@GITWEB_LOGO@@";
>  
>  # source of projects list
> -our $projects_list = "@@GITWEB_LIST@@" || "$projectroot";
> +our $projects_list = "@@GITWEB_LIST@@";
>  
>  # default blob_plain mimetype and default charset for text/plain blob
>  our $default_blob_plain_mimetype = 'text/plain';

But why that change?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
