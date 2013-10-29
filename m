From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: git svn already set =?utf-8?Q?=E2=80=A6?= wanted to set to:
Date: Tue, 29 Oct 2013 08:24:44 +0100
Message-ID: <87iowgiloj.fsf@linux-k42r.v.cablecom.net>
References: <1771383029875@web26g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: DimanNe <dimanne@ya.ru>
X-From: git-owner@vger.kernel.org Tue Oct 29 08:25:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb3gG-0007dv-Vr
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 08:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab3J2HZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 03:25:30 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:56350 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab3J2HZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 03:25:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id B3EA14D6580;
	Tue, 29 Oct 2013 08:25:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xwUM1e0mgqbQ; Tue, 29 Oct 2013 08:25:22 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 4ED834D6414;
	Tue, 29 Oct 2013 08:25:21 +0100 (CET)
In-Reply-To: <1771383029875@web26g.yandex.ru> (dimanne@ya.ru's message of
	"Tue, 29 Oct 2013 10:57:55 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236905>

DimanNe <dimanne@ya.ru> writes:

> I am trying to clone/fetch svn branch with git-svn:
>
> git config --add svn-remote.stable-2012-03-29.url https://some_host/branch
> git config --add svn-remote.stable-2012-03-29.fetch :refs/remotes/stable-2012-03-29
> git svn fetch stable-2012-03-29
>
> which gives me this error message:
>
> svn-remote.stable-2012-03-29.url already set:
> https://some_host/branch/ wanted to set to: https://some_host/
>
> I know that I probably can fix this by re-fetching all svn-repo from
> scratch, but it will take months or even years (due to size of repo).

What does your config look like now?

You should have only one svn-remote with one url, but it can have
multiple .fetch entries.  To fetch all branches, you can also just
configure its .branches.

-- 
Thomas Rast
tr@thomasrast.ch
