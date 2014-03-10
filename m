From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: howto to run git without a master branch
Date: Mon, 10 Mar 2014 10:30:08 +0100
Message-ID: <874n36h04f.fsf@igel.home>
References: <531B8D91.6020800@ist.utl.pt> <531C1C69.6080809@web.de>
	<531CC6FE.2040803@ist.utl.pt> <531CE837.1080504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 10:30:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMwXd-0006sZ-Vc
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 10:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbaCJJa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 05:30:29 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44662 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbaCJJaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 05:30:25 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fjDgM2zlsz3hj7T;
	Mon, 10 Mar 2014 10:30:23 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fjDgM2hhrzbbg5;
	Mon, 10 Mar 2014 10:30:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id hdHKnUzkm5kH; Mon, 10 Mar 2014 10:30:08 +0100 (CET)
X-Auth-Info: Y3zEaTue7n9MVufAYGnpF5fLlIU9ySPLj4WAfaz1YeU=
Received: from igel.home (ppp-46-244-225-33.dynamic.mnet-online.de [46.244.225.33])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 10 Mar 2014 10:30:08 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 4F8882C01EF; Mon, 10 Mar 2014 10:30:08 +0100 (CET)
X-Yow: ...Get me a GIN and TONIC!!...make it HAIR TONIC!!
In-Reply-To: <531CE837.1080504@gmail.com> (Ilya Bobyr's message of "Sun, 09
	Mar 2014 15:16:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243722>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> There is a "git remote set-head" to manipulate HEAD in a remote repository.

This is misleading.  The command does nothing on the remote side, it
only changes the refs/remote namespace in your repository.  The purpose
is to change what branch the ref remote/<name> resolves to, ie. without
explicit branch name.

(The only command that manipulates the remote repository is git push,
and the plumbing beneath that.  To change HEAD in a remote repository
you need filesystem access to it.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
