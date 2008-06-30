From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: [RFC] Single system account for multiple git users
Date: Mon, 30 Jun 2008 08:59:56 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0806300858380.25384@alchemy.localdomain>
References: <20080630151113.GO5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:01:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDLoP-0003Sq-68
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 18:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756468AbYF3QAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 12:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756538AbYF3QAI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 12:00:08 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:36911 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756300AbYF3QAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 12:00:07 -0400
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id 2705DA015A;
	Mon, 30 Jun 2008 12:00:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTPS id 45CB36D30D;
	Mon, 30 Jun 2008 08:59:57 -0700 (PDT)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <20080630151113.GO5737@dpotapov.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86917>

On Mon, 30 Jun 2008, Dmitry Potapov wrote:

> Hi,
>
> Using SSH access with restricted git-shell as login shell and using the 
> script from the update-hook-example.txt works fine, but it requres that 
> every Git user has a separate system account on the server, which is 
> often frowned upon by system administrators, who would prefer to have a 
> single system account for access to Git repo.
>
> I have looked on gitosis, but it requires normal shell account for the 
> git user, which was vetoed by sysadmin. Also, I found its configuration 
> more complex than necessary and not flexible enough to differentiate 
> what branches can have non-fast-forward pushes on it and what cannot.

I seem to recall that gitosis works with git-shell.  Maybe I'm 
mis-remembering, though.

-- Asheesh.

-- 
QOTD:
 	Some people have one of those days.  I've had one of those lives.
