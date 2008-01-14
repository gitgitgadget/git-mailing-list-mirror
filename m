From: Markus Korber <korbse@gmx.at>
Subject: Re: Revert git push
Date: Mon, 14 Jan 2008 11:39:55 +0100
Message-ID: <6z7iicpu6c.fsf@odpc25.int.ondemand.co.at>
References: <6zve61q0t3.fsf@odpc25.int.ondemand.co.at>
	<478627E2.4060808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 11:40:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEMjz-00072E-Vi
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 11:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbYANKj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 05:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYANKj6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 05:39:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:33138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751958AbYANKj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 05:39:58 -0500
Received: (qmail invoked by alias); 14 Jan 2008 10:39:55 -0000
Received: from vie004.vienna.atvirtual.net (EHLO odpc25.gmx.at) [212.186.216.185]
  by mail.gmx.net (mp046) with SMTP; 14 Jan 2008 11:39:55 +0100
X-Authenticated: #23003311
X-Provags-ID: V01U2FsdGVkX18QihMbVuQQRi23Nd+tePl9i1CFW4P9+sDgr7tHIr
	JDm3W56BEHxyP8
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70451>

Thus spake Johannes Sixt:

> Markus Korber schrieb:
>
>> revert this push if nobody has pushed something since my last pull from
>> the linux repository?
>
> $ cd /the/linux/repo
> $ git checkout 94545baded
> $ git branch -f master 94545baded
> $ git checkout master
>
> Omit the two checkouts if the repo is bare or if it did not have 'master'
> checked out.

Thanks a lot, that worked like a charm.

Regards,
Markus Korber
