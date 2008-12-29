From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git-add --verbose should say when something is already indexed
Date: Mon, 29 Dec 2008 17:52:58 +0900
Message-ID: <20081229175258.6117@nanako3.lavabit.com>
References: <87eizr32db.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Dec 29 09:55:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHDu4-0000ha-5c
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 09:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbYL2Ixh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 03:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbYL2Ixh
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 03:53:37 -0500
Received: from karen.lavabit.com ([72.249.41.33]:41612 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbYL2Ixg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 03:53:36 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 187EFC8425;
	Mon, 29 Dec 2008 02:53:36 -0600 (CST)
Received: from 3893.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 70KCL655336P; Mon, 29 Dec 2008 02:53:36 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=XWdEXAR+W9Muk6NHMWTnY3do+9brFLvEbFiOQVOo+r+1l7iDFaon/RHHgjD0IbVMGLpEjQBrf+lmAjw0GMLPbCnltFaXP7QiH8yqIkvzvVXzFzJODMDFSo/X60GEOuzjzKACMD4s/BYL6kUlIn74veOQonKa3wzlCEGHtfYYXy4=;
  h=From:To:Cc:Subject:Date:MIME-Version:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <87eizr32db.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104084>

Quoting jidanni@jidanni.org:

> git-add or at least git-add --verbose should say upon
> $ git-add bla.txt
> $ git-add bla.txt
> bla.txt is already in the index.

I do not think it should.

I suspect that you misunderstand what "git add" is. It is not about adding a new path to be tracked. Rather, it is to add the current contents of the file (unless --interactive is used).

You told git to add the contents of "bla.txt" to the index as path "bla.txt". I do not think there is anything more to report after it did exactly what it was told to do.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
