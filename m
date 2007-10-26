From: Pascal Obry <pascal.obry@wanadoo.fr>
Subject: Re: How to remove a specific hunk
Date: Fri, 26 Oct 2007 17:38:45 +0200
Organization: Home
Message-ID: <47220A05.4040705@wanadoo.fr>
References: <4722036E.5030204@wanadoo.fr> <472207AA.8030100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 26 17:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlRHR-0004nJ-RW
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 17:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbXJZPiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758181AbXJZPiu
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 11:38:50 -0400
Received: from smtp2a.orange.fr ([80.12.242.139]:52282 "EHLO smtp2a.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbXJZPit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 11:38:49 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2a09.orange.fr (SMTP Server) with ESMTP id 02B6470000A9
	for <git@vger.kernel.org>; Fri, 26 Oct 2007 17:38:48 +0200 (CEST)
Received: from [192.168.0.100] (AVelizy-151-1-88-36.w86-205.abo.wanadoo.fr [86.205.126.36])
	by mwinf2a09.orange.fr (SMTP Server) with ESMTP id ACE197000099;
	Fri, 26 Oct 2007 17:38:47 +0200 (CEST)
X-ME-UUID: 20071026153847708.ACE197000099@mwinf2a09.orange.fr
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <472207AA.8030100@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62420>

Andreas,

> Once you've added the other two hunks, they'll no longer show up in
> git-diff, so you can do something like this:
> 
> $ git-add -i; # add the other two hunks to commit
> $ git-diff > middle-hunk.patch
> $ git-apply -R middle-hunk.patch
> test, test, test
> $ git-apply middle-hunk.patch

Thanks, this will clearly work. I was expecting something more
integrated like a "git reset --interactive" or something like that :)

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
