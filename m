From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Allow git-svnimport to take "" as the trunk directory.
Date: Tue, 14 Aug 2007 07:45:40 +0200
Message-ID: <85vebi3bzv.fsf@lola.goethe.zz>
References: <11870641981207-git-send-email-albertito@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, llucax@gmail.com
To: Alberto Bertogli <albertito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 07:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKpEC-0003W8-DC
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 07:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S942164AbXHNFpw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 01:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S942217AbXHNFpr
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 01:45:47 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:47981 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S942610AbXHNFpn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2007 01:45:43 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 433EE15BCE1;
	Tue, 14 Aug 2007 07:45:42 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 346FB212FB4;
	Tue, 14 Aug 2007 07:45:42 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-002-034.pools.arcor-ip.net [84.61.2.34])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 05EF635E5A9;
	Tue, 14 Aug 2007 07:45:41 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id EE74E1C3D500; Tue, 14 Aug 2007 07:45:40 +0200 (CEST)
In-Reply-To: <11870641981207-git-send-email-albertito@gmail.com> (Alberto Bertogli's message of "Tue\, 14 Aug 2007 01\:03\:18 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3955/Tue Aug 14 03:49:12 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55809>

Alberto Bertogli <albertito@gmail.com> writes:

> Some repositories started with the trunk in "/" and then moved it to the
> standard "trunk/" location.
>
> On these repositories, the correct thing would be to call
> git-svnimport -T "",

I would not call that the best solution: it makes the bad decision
from the past impact useful work in the future.  I very much like git
having a good toplevel directory structure.

There are two approaches possible: one is to version the mapping
trunk/tags/branches.  Another would be if one could tell git-svn where
to stick stuff that does not sort into trunk/tags/branches.
Incidentally, I've seen repositories that have something like a
"support" or "vendor" directory, too.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
