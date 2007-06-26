From: Sam Vilain <sam@vilain.net>
Subject: Re: git for subversion users
Date: Tue, 26 Jun 2007 19:29:27 +1200
Message-ID: <4680C057.5070202@vilain.net>
References: <e2a1d0aa0706251248j1b8da150xbe19826bec15eed6@mail.gmail.com> <46809733.2060200@vilain.net> <4680A341.5000208@midwinter.com> <4680AA15.6040501@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 09:29:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I35Ud-0001EJ-VY
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 09:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbXFZH3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 03:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbXFZH3h
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 03:29:37 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48180 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXFZH3h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 03:29:37 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id A691413A502; Tue, 26 Jun 2007 19:29:34 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 2B1B413A4F8;
	Tue, 26 Jun 2007 19:29:30 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <4680AA15.6040501@vilain.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50952>

Sam Vilain wrote:
> It would be nice if git-svn could also fake setting
> remote merge properties, too.
> 
> Some beginnings at:
> 
>   http://git.catalyst.net.nz/gw?p=git.git;a=shortlog;h=svk-merge
>   (pull from git://git.catalyst.net.nz/git.git#svk-merge)
> 
> What it needs to do;
> 
>   0. preserve the notion that commits tagged with "git-svn-id:" should
>      not vary depending on who synced them.
> 
>   1. on commit, if we're committing a merge, make sure that the other
>      parent has the same revision somewhere in the repo, and then set
>      the "svk:merge" and "svnmerge-integrated" tags to accurately record
>      which parent SVN revisions are used
> 
>   2. when fetching revisions, spot these tickets and set parents
>      appropriately.

Proof of concept for #2 at:

http://git.catalyst.net.nz/gw?p=git.git;a=commitdiff;h=816e2ef

Sam.
