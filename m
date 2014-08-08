From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: push from one remote to another
Date: Fri, 08 Aug 2014 15:48:40 +0200
Message-ID: <87k36j853b.fsf@igel.home>
References: <20140808132021.GA23032@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 15:48:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFkXH-0000E6-Rh
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 15:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbaHHNso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 09:48:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52048 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187AbaHHNsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 09:48:43 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3hV7Fj3MRrz3hj9l;
	Fri,  8 Aug 2014 15:48:41 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3hV7Fj32Jzz7S6RT;
	Fri,  8 Aug 2014 15:48:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id OqqNztDKg56K; Fri,  8 Aug 2014 15:48:40 +0200 (CEST)
X-Auth-Info: N9aeqSYa1/LTgGL9DOF70P2+/ZXQQiS3OrP2A1DTVrY=
Received: from igel.home (host-188-174-221-149.customer.m-online.net [188.174.221.149])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri,  8 Aug 2014 15:48:40 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 833C52C37C0; Fri,  8 Aug 2014 15:48:40 +0200 (CEST)
X-Yow: My uncle Murray conquered Egypt in 53 B.C.  And I can prove it too!!
In-Reply-To: <20140808132021.GA23032@aepfle.de> (Olaf Hering's message of
	"Fri, 8 Aug 2014 15:20:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255016>

Olaf Hering <olaf@aepfle.de> writes:

> What is the correct syntax/setup to push from one remote to another?
> I did something like this, to feed a github repo:
>
>  # rm -rf $$
>  # mkdir $$
>  # cd $$
>  # git --init
>  # git remote add --tags t git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>  # git remote add --tags o git@github.com:user/repo.git
>  # git fetch --all
>
> This syntax does not work for me:
>  # git push t master o master
>  # git push --tags t master o master

$ git push o remotes/t/master:master

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
